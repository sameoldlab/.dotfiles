hook -group lsp-filetype-markdown global BufSetOption filetype=markdown %{
     set-option buffer lsp_servers %{
         [zk]
         root_globs = [".zk"]
         args = ["lsp"]
     }
}
