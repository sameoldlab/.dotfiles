define-command set-comments -hidden -override -params 3 %{
  set-option buffer comment_line         %arg{1}
  set-option buffer comment_block_begin  %arg{2}
  set-option buffer comment_block_end    %arg{3}
}

define-command set-comments-html %{
  try %{
    exec -draft '<a-a>c<lt>script.*?<gt>,<lt>/script<gt><ret>'
    set-comments '//' '/*' '*/'
  } catch %{ try %{
    exec -draft '<a-a>c<lt>style.*?<gt>,<lt>/style<gt><ret>'
    set-comments '' '/*' '*/'
  } catch %{
    set-comments '' '<!--' '-->'
  }}
}

define-command -override comment %{
  try %{
    execute-keys -draft ': comment-line<ret>'
  } catch %{
    execute-keys -draft 'xGlH: comment-block<ret>'
  }
}

map global user c ': comment<ret>'        -docstring 'comment/uncomment selections (line)'
map global user C ': comment-block<ret>'  -docstring 'block comment/uncomment selections'

hook global BufSetOption filetype=(html|svelte) %{
  # map buffer normal <c-v> ': eval -itersel %{ set-comments-html; comment; }<ret>'
  map buffer user c       ': eval -itersel %{ set-comments-html; comment; }<ret>'
  map buffer user C       ': eval -itersel %{ set-comments-html; comment-block; }<ret>'
}

hook -group lsp-filetype-css global BufSetOption filetype=(?:css|less|scss) %{
    set-option buffer lsp_servers %{
        # Documented options see
        # https://github.com/sublimelsp/LSP-css/blob/master/LSP-css.sublime-settings
        [vscode-css-language-server]
        root_globs = ["package.json", ".git", ".hg"]
        args = ["--stdio"]
        settings_section = "_"
        [vscode-css-language-server.settings._]
        provideFormatter = true
        handledSchemas = ["file"]
        [vscode-css-language-server.settings]
        css.format.enable = true
        css.validProperties = []
        css.validate = true
        scss.validProperties = []
        scss.format.enable = true
        scss.validate = true
        less.validProperties = []
        less.format.enable = true
        less.validate = true
        [css-variable-lsp]
        root_globs = ["package.json", ".git", ".hg"]
        args = ["--lookup-files", "'*.css,*.scss,*.svelte,*.html'"]
        [css-variable-lsp]
        root_globs = ["package.json", ".git"]
        [csscls]
        root_globs = ["package.json", ".git"]
        [go-css-lsp]
        root_globs = ["package.json", ".git"]
        args = [""]
    }
    # set-option buffer lsp_servers %opt{lsp_server_biome}
}

# hook -group lsp-filetype-svelte global BufSetOption filetype=(html|js|ts|svelte|jsx|tsx|vue) %{
#     set-option buffer lsp_servers %{
#         [css-variable-lsp]
#         root_globs = ["package.json", ".git", ".hg"]
#         [csscls]
#         root_globs = ["package.json", ".git", ".hg"]
#     }
# }

hook -group lsp-filetype-svelte global BufSetOption filetype=svelte %{
    set-option buffer lsp_servers %{
        [svelteserver]
        root_globs = ["package.json", "tsconfig.json", "jsconfig.json", ".git"]
        args = ["--stdio"]
        [css-variable-lsp]
        root_globs = ["package.json", ".git" ]
        [csscls]
        root_globs = ["package.json", ".git" ]
    }
}
