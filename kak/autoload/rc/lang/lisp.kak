hook global BufCreate .*[.](asd|lisp) %{
    set-option buffer filetype lisp
    set-option buffer tree_sitter_lang 'common-lisp'

    define-command lisp-expand %{
      try %{
        execute-keys <a-a>b
      }
    }
    define-command lisp-next %{
      execute-keys <semicolon>
      try %{
        execute-keys <a-a>b
      }
      execute-keys f(<a-a>b
    }
    define-command lisp-prev %{
      execute-keys <semicolon>
      try %{
        execute-keys <a-a>b
      }
      execute-keys <a-f>)<a-a>b
    }
    map global normal <a-n>  ': lisp-next<ret>'
    map global normal <a-p>  ': lisp-prev<ret>'
    map global normal <a-o>  ': lisp-expand<ret>'
}

hook global WinSetOption filetype=(asd|ct|lisp|scheme|janet) %{
    # parinfer-enable-window -smart
    # rainbow-enable-window
}

hook -group lsp-filetype-janet global BufSetOption filetype=janet %{
    set-option buffer formatcmd "janet-format -i %val{buffile} -o %val{buffile}"
    set-option buffer lsp_servers %{
        [janet-lsp]
        root_globs = ["project.janet"]
        command = "janet-lsp"
        args = ["--stdio"]
    }
}
