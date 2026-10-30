# niri-repl.kak
hook global ModuleLoaded niri %{
    require-module niri-repl
}

provide-module niri-repl %{

declare-option -docstring "niri window id of the REPL window" str niri_repl_id

define-command -docstring %{
    niri-repl [<arguments>]: create a new window for repl interaction, tracked by id
} \
    -params 1.. niri-repl %{ nop %sh{
        temp=$(mktemp -d kak-niri-repl-XXXXXX)
        fifo="$temp/fifo"
        mkfifo "$fifo"
        cleanup() { rm -rf "$temp"; }
        trap cleanup EXIT INT TERM

        cur_id=$(niri msg -j focused-window | sed -n 's/.*"id":[[:space:]]*\([0-9][0-9]*\).*/\1/p')
        niri msg -j event-stream >"$fifo" &
        stream_pid=$!
        ( sleep 3; kill "$stream_pid" 2>/dev/null ) >/dev/null 2>&1 </dev/null &

        kakquote() {
            set -- "$*" ""
            while [ "${1#*\'}" != "$1" ]; do
                set -- "${1#*\'}" "$2${1%%\'*}''"
            done
            printf "'%s' " "$2$1"
        }
        quoted_args=''
        for arg in "$@"; do
            quoted_args="$quoted_args$(kakquote "$arg")"
        done

        {
            ready=false
            while IFS= read -r line; do
                case "$line" in
                *"OverviewOpenedOrClosed"*)
                    if [ "$ready" = false ]; then
                        ready=true
                        printf 'niri-terminal-window %s' "$quoted_args" >"$kak_command_fifo"
                    fi
                    ;;
                *"WindowOpenedOrChanged"*)
                    if expr "${line}" : '.*"is_floating":[[:space:]]*false.*' >/dev/null; then
                        id="$(echo "$line" | sed -n 's/.*"id":[[:space:]]*\([0-9][0-9]*\).*/\1/p')"
                        printf "evaluate-commands -client %s 'set-option global niri_repl_id %s'" \
                            "$kak_client" "$id" >"$kak_command_fifo"
                        niri msg action focus-window --id "${cur_id}"
                        kill "$stream_pid";
                        wait "$stream_pid" 2>/dev/null
                        exit 0
        fi
                    ;;
                esac
            done <"$fifo"
        } >/dev/null 2>&1 </dev/null &
    }
}
complete-command niri-repl shell

define-command niri-send-text -params 0..1 -docstring %{
        niri-send-text [text]: Send text to the REPL window.
        If no text is passed, then the selection is used
    } %{
    nop %sh{
        if [ $# -eq 0 ]; then
            text="$kak_selection"
        else
            text="$1"
        fi
        cur_id=$(niri msg -j focused-window | sed -n 's/.*"id":[[:space:]]*\([0-9][0-9]*\).*/\1/p') &&
        niri msg action focus-window --id "${kak_opt_niri_repl_id}" &&
        printf '%s' "$text" | wtype - &&
        niri msg action focus-window --id "${cur_id}" ||
        echo 'fail niri-send-text: failed to send text, see *debug* buffer for details'
    }
}

alias global repl-new niri-repl
alias global repl-send-text niri-send-text

}
