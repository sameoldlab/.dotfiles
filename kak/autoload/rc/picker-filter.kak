declare-option -docstring 'client that shows previews, defaults to toolsclient' str picker_preview_client ''
declare-option str picker_key_next '<c-j>'
declare-option str picker_key_prev '<c-k>'
declare-option str picker_key_stay '<a-ret>'
declare-option -docstring 'milliseconds to wait for a -run command to produce a buffer' int picker_timeout 1000

declare-option -hidden str picker_phase idle
declare-option -hidden str picker_kind
declare-option -hidden str picker_script
declare-option -hidden str picker_run
declare-option -hidden str picker_pin
declare-option -hidden str picker_label
declare-option -hidden str picker_on_select
declare-option -hidden str picker_on_preview
declare-option -hidden str picker_on_abort
declare-option -hidden str picker_finally
declare-option -hidden int picker_timeout_now 1000
declare-option -hidden str picker_origin
declare-option -hidden str-list picker_saved_sels
declare-option -hidden str-list picker_buflist
declare-option -hidden str-list picker_created
declare-option -hidden str picker_stamp_now
declare-option -hidden str picker_source
declare-option -hidden str picker_source_stamp
declare-option -hidden str picker_tmp
declare-option -hidden str picker_query
declare-option -hidden str picker_shown
declare-option -hidden int picker_idx 1
declare-option -hidden int picker_count 1
declare-option -hidden int picker_height 0
declare-option -hidden str picker_item
declare-option -hidden bool picker_stay false
declare-option -hidden bool picker_failed false

# ------------------------------------------------------ entry point

define-command -params 1.. -docstring %{
  picker-filter (-script <shell> | -run <kak> [-buffer <name>] | -buffer <name>) [-on-select <cmd>] [-on-preview <cmd>] [-on-abort <cmd>] [-timeout <ms>]
  Fuzzy filter lines from a shell command or a buffer.
  Switches:
    -script <shell>    shell command whose output is the candidate list
    -run <kak>         Kakoune command that creates the candidate buffer
    -buffer <name>     use or require this buffer as the source
    -on-select <cmd>   run on the chosen line (default loc-jump)
    -on-preview <cmd>  run in the preview client when moving (default loc-preview)
    -on-abort <cmd>    run when the picker is cancelled
    -finally  <cmd>    run at any completion
    -timeout <ms>      how long -run may take to produce a buffer

    Options available in callbacks
      %opt{picker_item}    text of the chosen or highlighted line
      %opt{picker_source}  name of the source buffer (-run and -buffer only)

    Defaults
      -on-select   loc-jump
      -on-preview  loc-preview (needs picker_preview_client or toolsclient)
      -on-abort    nop
} picker-filter %{
  evaluate-commands %sh{
    apos=$(printf '\047')
    quote() { printf '%s%s%s' "$apos" "$(printf '%s' "$1" | sed "s/$apos/$apos$apos/g")" "$apos"; }
    fail_with() { printf 'fail %s\n' "$(quote "$1")"; exit 0; }
    script=; run=; pin=; on_select=; on_preview=; on_abort=; finally=; timeout_ms=
    while [ $# -gt 0 ]; do
      case $1 in
        -script|-run|-buffer|-on-select|-on-preview|-on-abort|-finally|-timeout)
          [ $# -ge 2 ] || fail_with "picker-filter: $1 needs a value"
          case $1 in
            -script)     script=$2 ;;
            -run)        run=$2 ;;
            -buffer)     pin=$2 ;;
            -on-select)  on_select=$2 ;;
            -on-preview) on_preview=$2 ;;
            -on-abort)   on_abort=$2 ;;
            -finally)    finally=$2 ;;
            -timeout)    timeout_ms=$2 ;;
          esac
          shift 2 ;;
        *) fail_with "picker-filter: unknown argument $1" ;;
      esac
    done
    if [ -n "$script" ]; then
      [ -z "$run$pin" ] || fail_with 'picker-filter: -script cannot be combined with -run or -buffer'
      kind=script
      source_text=$script
    elif [ -n "$run$pin" ]; then
      kind=buffer
      source_text=${run:-$pin}
    else
      fail_with 'picker-filter: need -script, -run or -buffer'
    fi
    case $timeout_ms in
      '') timeout_ms=$kak_opt_picker_timeout ;;
      *[!0-9]*) fail_with 'picker-filter: -timeout takes a number of milliseconds' ;;
    esac
    [ -n "$on_select" ]  || on_select=loc-jump
    [ -n "$on_preview" ] || on_preview=loc-preview
    [ -n "$on_abort" ]   || on_abort=nop
    first_line=$(printf '%s' "$source_text" | head -n 1)
    label=$(printf '%s' "$first_line" | cut -c1-60)
    [ "$label" = "$source_text" ] || label="$label..."
    printf 'set-option global picker_kind %s\n'       "$kind"
    printf 'set-option global picker_script %s\n'     "$(quote "$script")"
    printf 'set-option global picker_run %s\n'        "$(quote "$run")"
    printf 'set-option global picker_pin %s\n'        "$(quote "$pin")"
    printf 'set-option global picker_label %s\n'      "$(quote "$label")"
    printf 'set-option global picker_on_select %s\n'  "$(quote "$on_select")"
    printf 'set-option global picker_on_preview %s\n' "$(quote "$on_preview")"
    printf 'set-option global picker_on_abort %s\n'   "$(quote "$on_abort")"
    printf 'set-option global picker_finally %s\n'    "$(quote "$finally")"
    printf 'set-option global picker_timeout_now %s\n' "$timeout_ms"
    echo picker-run
  }
}

define-command -hidden picker-run %{
  picker-release
  set-option global picker_origin %val{bufname}
  set-option global picker_saved_sels %val{selections_desc}
  set-option global picker_tmp %sh{ mktemp -d }
  set-option global picker_source ''
  set-option global picker_source_stamp ''
  set-option global picker_query ''
  set-option global picker_stay false
  set-option global picker_failed false
  nop %sh{ : > "$kak_opt_picker_tmp/src"; : > "$kak_opt_picker_tmp/results" }
  evaluate-commands "picker-start-%opt{picker_kind}"
  picker-open
}

define-command -hidden picker-start-script %{
  nop %sh{
    (
      tmp=$kak_opt_picker_tmp
      client=$kak_client
      session=$kak_session
      sh -c "$kak_opt_picker_script" > "$tmp/src" 2>/dev/null &
      producer=$!
      last_size=-1
      while :; do
        alive=1
        kill -0 "$producer" 2>/dev/null || alive=0
        if [ ! -d "$tmp" ]; then
          kill "$producer" 2>/dev/null
          pkill -P "$producer" 2>/dev/null
          break
        fi
        size=$(wc -c < "$tmp/src")
        if [ "$size" != "$last_size" ]; then
          last_size=$size
          printf "evaluate-commands -client '%s' %%{ picker-event '%s' refresh }\n" \

            "$client" "$tmp" | kak -p "$session"
        fi
        if [ "$alive" = 0 ]; then
          [ "$size" -gt 0 ] || printf "evaluate-commands -client '%s' %%{ picker-event '%s' empty }\n" \
            "$client" "$tmp" | kak -p "$session"
          break
        fi
        sleep 0.1
      done
    ) >/dev/null 2>&1 </dev/null &
    exit 0
  }
}

define-command -hidden picker-start-buffer %{
  set-option global picker_created
  evaluate-commands %sh{
    [ -n "$kak_opt_picker_pin" ] && echo 'set-option global picker_created %opt{picker_pin}'
    [ -n "$kak_opt_picker_pin" ] && [ -n "$kak_opt_picker_run" ] && echo 'try %{
      evaluate-commands -buffer %opt{picker_pin} %{ set-option global picker_source_stamp %val{timestamp} }
    }'
    exit 0
  }
  hook -group picker-created global BufCreate .* %{
    set-option -add global picker_created %val{hook_param}
    set-option global picker_source_stamp ''
  }
  try %{
    evaluate-commands %opt{picker_run}
  } catch %{
    picker-release
    fail %val{error}
  }
  nop %sh{
    (
      tmp=$kak_opt_picker_tmp
      client=$kak_client
      session=$kak_session
      timeout_ms=$kak_opt_picker_timeout_now
      elapsed_ms=0
      while [ -d "$tmp" ]; do
        sleep 0.1
        elapsed_ms=$((elapsed_ms + 100))
        if [ ! -f "$tmp/found" ] && [ "$elapsed_ms" -ge "$timeout_ms" ]; then
          printf "evaluate-commands -client '%s' %%{ picker-event '%s' empty }\n" \
            "$client" "$tmp" | kak -p "$session"
          break
        fi
        printf "evaluate-commands -client '%s' %%{ picker-event '%s' refresh }\n" \
          "$client" "$tmp" | kak -p "$session"
      done
    ) >/dev/null 2>&1 </dev/null &
    exit 0
  }
}

define-command -hidden picker-refresh-buffer %{
  set-option global picker_source %sh{
    if [ -f "$kak_opt_picker_tmp/found" ]; then
      printf '%s' "$kak_opt_picker_source"
      exit 0
    fi
    eval "set -- $kak_quoted_opt_picker_created"
    for buffer_name; do
      if [ -n "$kak_opt_picker_pin" ]; then
        [ "$buffer_name" = "$kak_opt_picker_pin" ] || continue
      else
        case $buffer_name in
          '*debug*'|'*picker*') continue ;;
        esac
        [ -f "$buffer_name" ] && continue
      fi
      printf '%s' "$buffer_name"
      break
    done
  }
  set-option global picker_stamp_now ''
  try %{
    evaluate-commands -buffer %opt{picker_source} %{
      set-option global picker_stamp_now %val{timestamp}
    }
  }
  evaluate-commands %sh{
    if [ -n "$kak_opt_picker_stamp_now" ] && [ "$kak_opt_picker_stamp_now" != "$kak_opt_picker_source_stamp" ]; then
      echo picker-load-source
    fi
    exit 0
  }
}

define-command -hidden picker-load-source %{
  set-option global picker_source_stamp %opt{picker_stamp_now}
  evaluate-commands -draft -no-hooks -buffer %opt{picker_source} %{
    write -force "%opt{picker_tmp}/src"
  }
  evaluate-commands %sh{
    if [ "$(wc -c < "$kak_opt_picker_tmp/src")" -gt 1 ]; then
      touch "$kak_opt_picker_tmp/found"
      echo 'try %{ remove-hooks global picker-created }'
      echo picker-refilter
    fi
    exit 0
  }
}

# ------------------------------------------------------ events and open

define-command -hidden picker-event -params 2 %{
  evaluate-commands %sh{
    [ "$1" = "$kak_opt_picker_tmp" ] || exit 0
    case $2 in
      refresh) echo "picker-refresh-$kak_opt_picker_kind" ;;
      empty)   echo picker-fail-empty ;;
    esac
    exit 0
  }
}

define-command -hidden picker-open %{
  set-option global picker_phase open
  set-option global picker_idx 1
  set-option global picker_shown ''
  set-option global picker_buflist %val{buflist}
  edit -scratch '*picker*'
  add-highlighter -override window/picker-sel line '%opt{picker_idx}' 'default,rgba:3935527a+b'
  hook -group picker-keys window RawKey %opt{picker_key_next}    %{ picker-next-entry }
  hook -group picker-keys window RawKey %opt{picker_key_prev}    %{ picker-prev-entry }
  hook -group picker-keys window RawKey %opt{picker_key_stay}    %{ picker-stay }
  picker-refilter
  picker-preview
  evaluate-commands %sh{
    [ "$kak_opt_picker_kind" = buffer ] && echo picker-refresh-buffer
    exit 0
  }
  prompt -on-change %{
    set-option global picker_query %val{text}
    picker-update
  } -on-abort %{
    picker-abort
  } 'pick:' %{
    picker-accept
  }
}

# ------------------------------------------------------ filtering

define-command -hidden picker-update %{
  evaluate-commands %sh{
    if [ "$kak_opt_picker_query" = "$kak_opt_picker_shown" ]; then echo nop; else echo picker-requery; fi
    exit 0
  }
}

define-command -hidden picker-requery %{
  set-option global picker_shown %opt{picker_query}
  set-option global picker_idx 1
  picker-refilter
  picker-preview
}

define-command -hidden picker-refilter %{
  nop %sh{
    fzf --filter="$kak_opt_picker_query" < "$kak_opt_picker_tmp/src" > "$kak_opt_picker_tmp/results" 2>/dev/null
    exit 0
  }
  picker-render %val{window_height}
}

define-command -hidden picker-render -params 1 %{
  set-option global picker_height %arg{1}
  evaluate-commands -save-regs '"' -buffer '*picker*' %{
    set-register dquote %sh{ head -n "$kak_opt_picker_height" "$kak_opt_picker_tmp/results" }
    execute-keys -draft '%R'
  }
  evaluate-commands %sh{
    total=$(wc -l < "$kak_opt_picker_tmp/results")
    shown=$total
    [ "$shown" -gt "$kak_opt_picker_height" ] && shown=$kak_opt_picker_height
    index=$kak_opt_picker_idx
    [ "$index" -gt "$shown" ] && index=$shown
    [ "$index" -lt 1 ] && index=1
    echo "set-option global picker_count $shown"
    echo "set-option global picker_idx $index"
    exit 0
  }
}

# ------------------------------------------------------ selection and keys

define-command -hidden picker-check-open %{
  evaluate-commands %sh{
    [ "$kak_opt_picker_phase" = open ] || echo "fail 'picker: no picker is open'"
    exit 0
  }
}

define-command picker-next-entry -docstring 'picker: move to the next entry' %{
  picker-check-open
  picker-move 1
}

define-command picker-prev-entry -docstring 'picker: move to the previous entry' %{
  picker-check-open
  picker-move -1
}

define-command -hidden picker-move -params 1 %{
  evaluate-commands %sh{
    delta=$1
    index=$((kak_opt_picker_idx + delta))
    [ "$index" -gt "$kak_opt_picker_count" ] && index=$kak_opt_picker_count
    [ "$index" -lt 1 ] && index=1
    echo "set-option global picker_idx $index"
    exit 0
  }
  picker-preview
}

define-command -hidden picker-load-item %{
  set-option global picker_item %sh{ sed -n "${kak_opt_picker_idx}p" "$kak_opt_picker_tmp/results" }
}

define-command -hidden picker-preview %{
  picker-load-item
  try %{
    evaluate-commands -client %sh{ printf '%s' "${kak_opt_picker_preview_client:-$kak_opt_toolsclient}" } %opt{picker_on_preview}
  }
}

# ------------------------------------------------------ closing the picker

define-command -hidden picker-accept %{
  picker-load-item
  picker-close
  evaluate-commands %sh{
    [ -n "$kak_opt_picker_item" ] && echo 'evaluate-commands %opt{picker_on_select}'
    echo 'evaluate-commands %opt{picker_finally}'
    exit 0
  }
}

define-command -hidden picker-abort %{
  evaluate-commands %sh{
    if [ "$kak_opt_picker_stay" = true ]; then
      echo picker-stay-finish
    elif [ "$kak_opt_picker_failed" = true ]; then
      echo picker-fail-finish
    else
      echo picker-cancel
    fi
    exit 0
  }
}

define-command -hidden picker-cancel %{
  picker-close
  evaluate-commands %opt{picker_on_abort}
  evaluate-commands %opt{picker_finally}
}

define-command -hidden picker-fail-empty %{
  set-option global picker_failed true
  execute-keys '<esc>'
}

define-command -hidden picker-fail-finish %{
  set-option global picker_failed false
  picker-close
  echo -debug "picker-filter: command did not produce any candidates: %opt{picker_label}"
  fail "picker-filter: command did not produce any candidates: %opt{picker_label}"
}

define-command -hidden picker-close %{
  try %{ remove-highlighter window/picker-sel }
  try %{ remove-hooks window picker-keys }
  try %{ buffer %opt{picker_origin} }
  try %{ delete-buffer! '*picker*' }
  try %{ select %opt{picker_saved_sels} }
  picker-gc
  picker-release
}

define-command -hidden picker-gc %{
  try %{
    evaluate-commands -buffer %sh{
      eval "set -- $kak_quoted_opt_picker_buflist"
      known_buffers=$(printf '%s\n' "$@")
      eval "set -- $kak_quoted_buflist"
      for buffer_name; do
        [ "$buffer_name" = "$kak_bufname" ] && continue
        [ "$buffer_name" = "$kak_opt_picker_source" ] && continue
        printf '%s\n' "$known_buffers" | grep -Fxq -- "$buffer_name" && continue
        printf '%s\n' "$buffer_name"
      done | paste -sd, -
    } %{
      try %{ delete-buffer }
    }
  }
}

define-command -hidden picker-release %{
  nop %sh{
    [ -n "$kak_opt_picker_tmp" ] && rm -rf -- "$kak_opt_picker_tmp"
    exit 0
  }
  set-option global picker_tmp ''
  set-option global picker_phase idle
  try %{ remove-hooks window picker-keys }
  try %{ remove-hooks global picker-created }
}

define-command picker-stay -docstring 'close the prompt but keep the results buffer' %{
  picker-check-open
  set-option global picker_stay true
  execute-keys '<esc>'
}

define-command -hidden picker-stay-finish %{
  set-option global picker_stay false
  picker-render 1000000
  try %{ remove-highlighter window/picker-sel }
  try %{ remove-hooks window picker-keys }
  select "%opt{picker_idx}.1,%opt{picker_idx}.1"
  set-option buffer picker_on_select %opt{picker_on_select}
  try %{ delete-buffer! "*picker: %opt{picker_query}*" }
  rename-buffer "*picker: %opt{picker_query}*"
  picker-gc
  picker-release
}

define-command picker-open-here -docstring 'run on-select on the line under the cursor' %{
  evaluate-commands -draft %{
    execute-keys 'ghGl'
    set-option global picker_item %val{selection}
  }
  evaluate-commands %sh{
    stripped=$(printf '%s' "$kak_opt_picker_item" | tr -d '\n')
    [ -n "$stripped" ] && echo 'evaluate-commands %opt{picker_on_select}'
    exit 0
  }
}

# ------------------------------------------------------ default jump actions

define-command -hidden picker-split-location %{
  set-register l %sh{ printf '%s' "${kak_opt_picker_item%%:*}" } %sh{
    r=${kak_opt_picker_item#*:}; r=${r%%:*}
    case $r in ''|*[!0-9]*) r=1 ;; esac
    printf '%s' "$r"
  }
}

define-command loc-jump -docstring 'open a path:line item in current client or, if available, jumpclient' %{
  evaluate-commands -save-regs l %{
    picker-split-location
    evaluate-commands -try-client %opt{jumpclient} -verbatim -- edit -existing -- %reg{l}
    try %{ focus %opt{jumpclient} }
  }
}

define-command loc-preview -docstring 'preview a path:line item' %{
  evaluate-commands -save-regs l %{
    picker-split-location
    evaluate-commands -verbatim -- edit -existing -- %reg{l}
  }
}
