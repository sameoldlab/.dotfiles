hook global ModuleLoaded lisp %{
  require-module user-lisp
}

provide-module user-lisp %{

declare-option str scheme_repl_in "/tmp/scheme-repl-in"
declare-option str scheme_repl_out "/tmp/scheme-repl-out"


define-command scheme-repl-start -override %{
  nop %sh{
    mkfifo "$kak_opt_scheme_repl_in" 2>/dev/null
    mkfifo "$kak_opt_scheme_repl_out" 2>/dev/null
    ( exec 3<> "$kak_opt_scheme_repl_in"
      mit-scheme <&3 > "$kak_opt_scheme_repl_out" 2>&1
    ) > /dev/null 2>&1 < /dev/null &
    disown 2>/dev/null
  }
  evaluate-commands -try-client %opt{toolsclient} %{
    edit! -fifo %opt{scheme_repl_out} -scroll *scheme-repl*
  }
}

define-command scheme-send -override %{
  nop %sh{
    printf '%s\n' "$kak_selection" >> "$kak_opt_scheme_repl_in"
  }
}

map global normal <c-a> ': scheme-send<ret>' -docstring 'send selection/sexp to scheme REPL'

# ================================================================
# ================================================================

# adapted to icl from https://github.com/zeroplissken/clak.kak/blob/master/rc/clak.kak
define-command -hidden send-newline-char %{
	evaluate-commands -save-regs n %{
    	execute-keys -draft ge"ny
    	repl-send-text %reg{n}
	}
}

define-command -hidden select-expr -docstring 'convenient parens object selection' %{
    execute-keys <a-a>b 
}

define-command icl-start -docstring 'start REPL and launch SBCL with current file' %{
    evaluate-commands %{
        repl-new icl --no-banner 
    }
}
define-command cl-quit -docstring 'closes SBCL and REPL window' %{
	repl-send-text "(quit)
	"
}
define-command cl-send-expr -docstring 'sends form under cursor to SBCL' %{
    evaluate-commands -save-regs l %{
		try %{ select-expr }
		execute-keys -draft %{"ly}
		repl-send-text %reg{l}
		send-newline-char
	}
}

define-command cl-reload-file -docstring 'reload current file in SBCL'  %{
	repl-send-text "(load ""%val{buffile}"")
	"
}

define-command cl-compile-file -docstring 'compile current file in SBCL' %{
    repl-send-text "(compile-file ""%val{buffile}"")
    (:load ""%val{buffile}"")
    "
}

define-command cl-describe-symbol -docstring 'view description of symbol under cursor' %{
    evaluate-commands -save-regs f %{
        execute-keys -draft be"fy
        repl-send-text "(describe '%reg{f}))
        "
        send-newline-char
    }
}

map global normal <c-e> ': cl-reload-file<ret>' -docstring 'send selection/sexp to lisp REPL'
map global normal <c-E> ': cl-compile-file<ret>' -docstring 'send selection/sexp to lisp REPL'

add-highlighter shared/common-lisp/code/ regex \
    \b(if|let|let\*|lambda|quote|function|setq|block|return-from|catch|throw|unwind-protect|progn|prog1|prog2|tagbody|go|the|locally|flet|labels|macrolet|symbol-macrolet)\b \
    0:keyword

add-highlighter shared/common-lisp/code/ regex \
    \b(and|or|not|when|unless|cond|case|ccase|ecase|typecase|ctypecase|etypecase)\b \
    0:keyword.control.conditional

add-highlighter shared/common-lisp/code/ regex \
    \b(loop|do|do\*|dotimes|dolist|mapcar|mapc|mapcan|mapcon|mapl|maplist|mapl|repeat|while|until)\b \
    0:keyword.control.repeat

add-highlighter shared/common-lisp/code/ regex \
    \b(defun|defmacro|defgeneric|defmethod|defclass|defstruct|deftype|defpackage|defparameter|defvar|defconstant|define-condition)\b \
    0:keyword.function

add-highlighter shared/common-lisp/code/ regex \
    \b(handler-case|handler-bind|restart-case|restart-bind|signal|error|cerror|warn|invoke-restart|with-simple-restart)\b \
    0:keyword.control
}
