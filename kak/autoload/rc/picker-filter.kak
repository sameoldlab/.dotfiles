# Examples
#   define-command pick-file %{ picker-filter -script 'fd -t f' }
#   define-command pick-line %{ picker-filter -buffer %val{bufname} }
#   define-command pick-grep %{ picker-filter -buffer '*grep*' -on-select grep-jump }
#
# Requires fzf, awk, and kakoune-focus (https://github.com/caksoylar/kakoune-focus).

declare-option str picker_preview_client ''
declare-option str picker_key_next '<a-j>'
declare-option str picker_key_prev '<a-k>'
declare-option str picker_key_preview '<tab>'
declare-option str picker_key_stay '<a-ret>'
declare-option -hidden bool picker_active false
declare-option -hidden bool picker_stay false
declare-option -hidden str picker_kind
declare-option -hidden str picker_src
declare-option -hidden str picker_on_select
declare-option -hidden str picker_on_change
declare-option -hidden str picker_on_abort
declare-option -hidden str picker_origin
declare-option -hidden str-list picker_saved_sels
declare-option -hidden str-list picker_buflist
declare-option -hidden str picker_tmp
declare-option -hidden str picker_query
declare-option -hidden int picker_length
declare-option -hidden str picker_shown
declare-option -hidden str-list picker_matches
declare-option -hidden int picker_idx 1
declare-option -hidden str picker_item
declare-option -hidden int picker_line 0

# ---------------------------------------------------------------- entry point

# options available in callbacks:
#   %opt{picker_item}   text of the chosen/highlighted line
#   %opt{picker_line}   line number in the source buffer (-buffer only, else 0)
# Defaults:
# on-select:   -script  picker-open-file (edit the item in jumpclient if available, else current client)
#              -buffer  nop
# on-change:   -script  picker-preview-file (previews existing file)
#              -buffer  nop
#  on-abort:            nop

define-command -params 1.. -docstring %{
  picker-filter (-buffer <name> | -script <shell>) [-on-select <cmd>] [-on-change <cmd>] [-on-abort <cmd>]
  Switches:
    -script <arg>     source     provide a shell command to run as a source.
    -buffer <arg>     source     give an existing buffer name to use as a source.
    -on-select <cmd>  callback   run on final entry selection.
    -on-change <cmd>  callback   run on change to query.
    -on-abort  <cmd>  callback   run on cancelled search.
} -shell-script-candidates %{
} picker-filter %{
  evaluate-commands %sh{
    q() { printf "'%s'" "$(printf '%s' "$1" | sed "s/'/''/g")"; }
    kind=; src=; sel=; chg=; abt=
    while [ $# -gt 0 ]; do
      case "$1" in
        -buffer)    kind=buffer; src=$2; shift 2 ;;
        -script)    kind=script; src=$2; shift 2 ;;
        -on-select) sel=$2; shift 2 ;;
        -on-change) chg=$2; shift 2 ;;
        -on-abort)  abt=$2; shift 2 ;;
        *) printf 'fail %s\n' "$(q "picker-filter: unknown argument $1")"; exit 0 ;;
      esac
    done
    if [ -z "$kind" ]; then
      echo "fail 'picker-filter: need -buffer or -script'"; exit 0
    fi
    if [ "$kind" = script ]; then
      [ -n "$sel" ] || sel='picker-open-file'
      [ -n "$chg" ] || chg='picker-preview-file'
    else
      [ -n "$sel" ] || sel='nop'
      [ -n "$chg" ] || chg='nop'
    fi
    [ -n "$abt" ] || abt='nop'
    printf 'set-option global picker_kind %s\n'      "$kind"
    printf 'set-option global picker_src %s\n'       "$(q "$src")"
    printf 'set-option global picker_on_select %s\n' "$(q "$sel")"
    printf 'set-option global picker_on_change %s\n' "$(q "$chg")"
    printf 'set-option global picker_on_abort %s\n'  "$(q "$abt")"
    echo picker-start
  }
}

define-command -hidden picker-start %{
  set-option global picker_origin %val{bufname}
  set-option global picker_saved_sels %val{selections_desc}
  set-option global picker_buflist %val{buflist}
  set-option global picker_query ''
  set-option global picker_shown '<none>'
  set-option global picker_matches
  set-option global picker_idx 1
  set-option global picker_tmp %sh{ mktemp -d }
  evaluate-commands "picker-start-%opt{picker_kind}"
  picker-update
  set-option global picker_active true
  set-option global picker_stay false
  hook -group picker-keys global RawKey %opt{picker_key_next}    %{ picker-next-entry }
  hook -group picker-keys global RawKey %opt{picker_key_prev}    %{ picker-prev-entry }
  hook -group picker-keys global RawKey %opt{picker_key_preview} %{ picker-preview }
  hook -group picker-keys global RawKey %opt{picker_key_stay}    %{ picker-stay }
  prompt 'pick:' \
    -on-change %{ set-option global picker_query %val{text}; picker-update } \
    -on-abort  %{ picker-abort } \
    %{ picker-accept }
}

# ------------------------------------------------------------- source: script

define-command -hidden picker-start-script %{
  edit -scratch '*picker*'
  add-highlighter -override window/picker-sel line '%opt{picker_idx}' 'default,rgba:3935527a+b'
  # Producer writes cache file. Watcher in the triggers rerender
  # on growth until producer exits or picker closes
  nop %sh{
    (
      tmp=$kak_opt_picker_tmp
      sh -c "$kak_opt_picker_src" > "$tmp/src" 2>/dev/null &
      pid=$!
      last=-1
      while :; do
        alive=1; kill -0 "$pid" 2>/dev/null || alive=0
        if [ ! -d "$tmp" ]; then
          kill "$pid" 2>/dev/null; pkill -P "$pid" 2>/dev/null
          break
        fi
        size=$(wc -c < "$tmp/src")
        if [ "$size" != "$last" ]; then
          last=$size
          printf "evaluate-commands -client '%s' %%{ picker-stream-refresh '%s' }\n" \
            "$kak_client" "$tmp" | kak -p "$kak_session"
        fi
        [ "$alive" = 1 ] || break
        sleep 0.15
      done
    ) >/dev/null 2>&1 </dev/null &
  }
}

define-command -hidden picker-stream-refresh -params 1 %{
  evaluate-commands %sh{
    if [ "$kak_opt_picker_active" = true ] && [ "$kak_opt_picker_kind" = script ] \
       && [ "$1" = "$kak_opt_picker_tmp" ]; then
      echo picker-render-script
    fi
    exit 0
  }
}

define-command -hidden picker-render-script %{
  set-option buffer picker_length %val{window_height}
  evaluate-commands -save-regs '"' -buffer '*picker*' %{
    set-register dquote %sh{ fzf --filter="$kak_opt_picker_query" < "$kak_opt_picker_tmp/src" 2>/dev/null | head -n "$kak_opt_picker_length" }
    execute-keys -draft '%R'
  }
}

# Query changed: re-render and go back to the top entry.
define-command -hidden picker-update-script %{
  picker-render-script
  set-option global picker_idx 1
}

define-command -hidden picker-move-script -params 1 %{
  evaluate-commands %sh{
    n=$kak_buf_line_count
    i=$((kak_opt_picker_idx + $1)); [ $i -lt 1 ] && i=1; [ $i -gt $n ] && i=$n
    echo "set-option global picker_idx $i"
  }
  picker-preview
}

define-command -hidden picker-load-item-script %{
  evaluate-commands -draft -buffer '*picker*' %{
    execute-keys "%opt{picker_idx}gx_"
    set-option global picker_item %val{selection}
  }
  set-option global picker_line 0
}

# ------------------------------------------------------------- source: buffer

define-command -hidden picker-start-buffer %{
  evaluate-commands %sh{ [ "$kak_bufname" = "$kak_opt_picker_src" ] || echo "buffer %opt{picker_src}" }
  set-option window focus_context_lines 0
  evaluate-commands -draft -no-hooks %{ write -force "%opt{picker_tmp}/raw" }
  nop %sh{ awk '{printf "%d\t%s\n", NR, $0}' "$kak_opt_picker_tmp/raw" > "$kak_opt_picker_tmp/src" }
}

define-command -hidden picker-update-buffer %{
  evaluate-commands %sh{
    src="$kak_opt_picker_tmp/src"
    matches=$(fzf --filter="$kak_opt_picker_query" --delimiter='\t' --nth=2.. --no-sort < "$src" 2>/dev/null | cut -f1)
    total=$(wc -l < "$src")
    count=$(printf '%s' "$matches" | grep -c .)
    printf 'set-option global picker_matches %s\n' "$(printf '%s' "$matches" | tr '\n' ' ')"
    if [ "$count" -eq 0 ] || [ "$count" -ge "$total" ]; then
      echo "try %{ focus-clear }"
    else
      descs=$(printf '%s\n' "$matches" | awk '{printf "%d.1,%d.1 ", $1, $1}')
      echo "evaluate-commands -draft %{ select $descs; focus-selections }"
    fi
    if [ -z "$kak_opt_picker_query" ]; then
      echo "set-option global picker_idx $kak_cursor_line"
    else
      echo "set-option global picker_idx 1"
      first=$(printf '%s\n' "$matches" | head -n 1)
      [ -n "$first" ] && echo "select $first.1,$first.1"
    fi
  }
}

define-command -hidden picker-move-buffer -params 1 %{
  evaluate-commands %sh{
    d=$1
    eval "set -- $kak_quoted_opt_picker_matches"
    n=$#; [ $n -gt 0 ] || exit 0
    i=$((kak_opt_picker_idx + d)); [ $i -lt 1 ] && i=1; [ $i -gt $n ] && i=$n
    eval "line=\${$i}"
    echo "set-option global picker_idx $i"
    echo "select $line.1,$line.1"
  }
  picker-preview
}

define-command -hidden picker-load-item-buffer %{
  evaluate-commands %sh{
    eval "set -- $kak_quoted_opt_picker_matches"
    [ $# -gt 0 ] || exit 0
    eval "line=\${$kak_opt_picker_idx}"
    [ -n "$line" ] || exit 0
    item=$(sed -n "${line}p" "$kak_opt_picker_tmp/src" | cut -f2-)
    printf 'set-option global picker_line %s\n' "$line"
    printf "set-option global picker_item '%s'\n" "$(printf '%s' "$item" | sed "s/'/''/g")"
  }
}

# ------------------------------------------------------------------- shared

define-command -hidden picker-update %{
  evaluate-commands %sh{
    if [ "$kak_opt_picker_query" != "$kak_opt_picker_shown" ]; then
      echo 'set-option global picker_shown %opt{picker_query}; evaluate-commands "picker-update-%opt{picker_kind}"'
    fi
    exit 0
  }
}

define-command -hidden picker-move -params 1 %{
  evaluate-commands "picker-move-%opt{picker_kind} %arg{1}"
}

define-command -hidden picker-preview %{
  evaluate-commands "picker-load-item-%opt{picker_kind}"
  evaluate-commands %sh{
    c=${kak_opt_picker_preview_client:-$kak_opt_toolsclient}
    [ -n "$c" ] || exit 0
    printf "try %%{ evaluate-commands -client '%s' %%opt{picker_on_change} }\n" \
      "$(printf '%s' "$c" | sed "s/'/''/g")"
  }
}

define-command -hidden picker-check-active %{
  evaluate-commands %sh{
    [ "$kak_opt_picker_active" = true ] || echo "fail 'picker: no picker is open'"
    exit 0
  }
}

define-command picker-next-entry -docstring 'picker: move to the next entry' %{
  picker-check-active
  picker-move 1
}

define-command picker-prev-entry -docstring 'picker: move to the previous entry' %{
  picker-check-active
  picker-move -1
}

define-command picker-open-file -docstring 'open %opt{picker_item} in jumpclient if there is one, else in the current client' %{
  evaluate-commands -try-client %opt{jumpclient} %{ edit -existing %opt{picker_item} }
  try %{ focus %opt{jumpclient} }
}

define-command picker-preview-file -docstring 'open %opt{picker_item} if it is an existing file' %{
  evaluate-commands %sh{
    [ -f "$kak_opt_picker_item" ] && echo 'edit -existing %opt{picker_item}'
    exit 0
  }
}

define-command -hidden picker-teardown -params 1 %{
  set-option global picker_active false
  remove-hooks global picker-keys
  try %{ remove-highlighter window/picker-sel }
  evaluate-commands %sh{
    [ "$1" = stay ] && exit 0
    echo "try %{ focus-clear }"
    echo "try %{ unset-option window focus_context_lines }"
    if [ "$kak_opt_picker_kind" = script ]; then
      echo "buffer %opt{picker_origin}"
      echo "try %{ delete-buffer! '*picker*' }"
    elif [ "$1" = abort ]; then
      echo "buffer %opt{picker_origin}"
      echo "select %opt{picker_saved_sels}"
    fi
    exit 0
  }
}

# Delete every buffer that did not exist when the picker started, drop temp files.
define-command -hidden picker-gc %{
  evaluate-commands %sh{
    eval "set -- $kak_quoted_opt_picker_buflist"
    old=$(printf '%s\n' "$@")
    eval "set -- $kak_quoted_buflist"
    for b; do
      [ "$b" = "$kak_bufname" ] && continue
      if ! printf '%s\n' "$old" | grep -Fxq -- "$b"; then
        printf "try %%{ delete-buffer '%s' }\n" "$(printf '%s' "$b" | sed "s/'/''/g")"
      fi
    done
    rm -rf "$kak_opt_picker_tmp"
    exit 0
  }
}

define-command -hidden picker-accept %{
  evaluate-commands "picker-load-item-%opt{picker_kind}"
  picker-teardown accept
  picker-gc
  evaluate-commands %opt{picker_on_select}
}

define-command -hidden picker-abort %{
  evaluate-commands %sh{
    if [ "$kak_opt_picker_stay" = true ]; then echo picker-stay-finish; else echo picker-cancel; fi
    exit 0
  }
}

define-command -hidden picker-cancel %{
  picker-teardown abort
  picker-gc
  evaluate-commands %opt{picker_on_abort}
}

define-command picker-stay -docstring 'close the prompt but keep the results buffer' %{
  picker-check-active
  set-option global picker_stay true
  # NOT -draft. key goes to the prompt which aborts
  execute-keys '<esc>'
}

define-command -hidden picker-stay-finish %{
  set-option global picker_stay false
  picker-teardown stay
  try {
    evaluate-commands "picker-stay-finish-script"
  }
  picker-gc
}

define-command -hidden picker-stay-finish-script %{
  select "%opt{picker_idx}.1,%opt{picker_idx}.1"
  set-option buffer picker_on_select %opt{picker_on_select}
  try %{ delete-buffer! "*picker: %opt{picker_query}*" }
  rename-buffer "*picker: %opt{picker_query}*"
  map buffer normal <ret> ':picker-open-here<ret>'
}

define-command picker-open-here -docstring 'run on-select on the line under the cursor (stay buffers)' %{
  evaluate-commands -draft %{
    execute-keys 'x_'
    set-option global picker_item %val{selection}
  }
  set-option global picker_line 0
  evaluate-commands %opt{picker_on_select}
}

