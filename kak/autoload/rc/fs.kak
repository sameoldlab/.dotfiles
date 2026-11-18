define-command mkdir %{ nop %sh{ mkdir -p $(dirname $kak_buffile) } }

define-command -docstring 'move <path>: move buffer to new file' \
    -params 1 -file-completion move %{
    evaluate-commands %sh{
        if [ "$kak_modified" = true ]; then
            printf 'fail "move: buffer %s is modified"\n' "$kak_buffile"
            exit
        fi
        if [ ! -f "$kak_buffile" ]; then
            printf 'fail "move: buffer %s is not a file"\n' "$kak_buffile"
            exit
        fi
        src=$kak_buffile
        dest=$1
        case $dest in
            '~') dest=$HOME ;;
            '~/'*) dest="$HOME/${dest#'~/'}" ;;
        esac
        if [ -d "$dest" ]; then
            new="${dest%/}/$(basename -- "$src")"
        else
            new=$dest
        fi
        if [ -e "$new" ]; then
            printf 'fail "move: file %s already exists"\n' "$new"
            exit
        fi
        if ! err=$(mv -- "$src" "$new" 2>&1); then
            printf 'fail "move: %s"\n' "$err"
            exit
        fi
        printf 'edit -existing %s %s %s\n' "$new" "$kak_cursor_line" "$kak_cursor_column"
        printf 'delete-buffer %s\n' "$kak_quoted_bufname"
    }
}

# create directory??
define-command -docstring 'move <path>: move buffer to new file. overriting existing files' \
    -params 1 -file-completion move-force %{
    evaluate-commands %sh{
        if [ "$kak_modified" = true ]; then
            printf 'fail "move: buffer %s is modified"\n' "$kak_buffile"
            exit
        fi
        if [ ! -f "$kak_buffile" ]; then
            printf 'fail "move: buffer %s is not a file"\n' "$kak_buffile"
            exit
        fi
        src=$kak_buffile
        dest=$1
        case $dest in
            '~') dest=$HOME ;;
            '~/'*) dest="$HOME/${dest#'~/'}" ;;
        esac
        if [ -d "$dest" ]; then
            new="${dest%/}/$(basename -- "$src")"
        else
            new=$dest
        fi
        mkdir -p "$(dirname $new)"
        if ! err=$(mv -- "$src" "$new" 2>&1); then
            printf 'fail "move: %s"\n' "$err"
            exit
        fi
        printf 'edit -existing %s %s %s\n' "$new" "$kak_cursor_line" "$kak_cursor_column"
        printf 'delete-buffer %s\n' "$kak_quoted_bufname"
    }
}

# trash provided file, or current buffer's file.
define-command trash -params 0..1 %{
  nop %sh{ trash "$kak_buffile" }
  evaluate-commands delete-buffer!
}

define-command write-p -params 0..  %{
	try %{
		write! %arg{@}
	} catch {
		mkdir
		write %arg{@}
	}
}

alias global mv  move
alias global mv! move-force
alias global rm! trash
alias global w!  write-p
