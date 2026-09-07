declare-user-mode match
define-command enter_match_mode %{
  enter-user-mode -lock match
}
map global normal   -docstring 'Match mode' m %{:enter-user-mode match<ret>}
# map global match -docstring 'Goto matching bracket' m 'm'
map global match -docstring 'Select around object' a '<a-a>'
map global match -docstring 'Select inside object' i '<a-i>'
map global match -docstring 'Lock' M ': enter_match_mode <ret>'

# from https://git.sr.ht/~raiguard/kak-mirror
# based on https://github.com/Delapouite/kakoune-mirror

# grow/shrink
map global match c 'C<a-;><a-C><a-;>'  -docstring column
map global match h 'H<a-;>L<a-;>'      -docstring character
map global match l 'L<a-;>H<a-;>'      -docstring character
map global match j 'J<a-;>K<a-;>'      -docstring line
map global match k 'K<a-;>J<a-;>'      -docstring line
map global match J 'J<a-;>K<a-;><a-x>' -docstring 'full line'
map global match K 'K<a-;>J<a-;><a-x>' -docstring 'full line'
map global match b 'B<a-;>W<a-;>'      -docstring 'word begin'
map global match w 'W<a-;>B<a-;>'      -docstring 'word begin'
map global match e 'E<a-;>B<a-;>'      -docstring 'word end'
map global match p '}p<a-;>{p<a-;>'    -docstring paragraph
# map global match s '}s<a-;>{s<a-;>'    -docstring sentence
map global match m 'M<a-;><a-M><a-;>'  -docstring matching
# fallthrough
map global match '<a-;>' '<a-;>'       -docstring 'swap anchor and cursor'
map global match '<a-S>' '<a-S>'       -docstring 'select sels boundaries'
map global match u u                   -docstring 'undo'
map global match U U                   -docstring 'redo'
# Surround / Delete
map global match ( '\a)<esc>\i(<esc>H<a-;>'          -docstring '(surround)'
map global match { '\a}<esc>\i{<esc>H<a-;>'          -docstring '{surround}'
map global match [ '\a]<esc>\i[<esc>H<a-;>'          -docstring '[surround]'
map global match < '\a<gt><esc>\i<lt><esc>H<a-;>'    -docstring '<surround>'
map global match ) '\a )<esc>\i( <esc>2H<a-;>'       -docstring '( surround )'
map global match } '\a }<esc>\i{ <esc>2H<a-;>'       -docstring '{ surround }'
map global match ] '\a ]<esc>\i[ <esc>2H<a-;>'       -docstring '[ surround ]'
map global match > '\a <gt><esc>\i<lt> <esc>2H<a-;>' -docstring '< surround >'
map global match '"' '\a"<esc>\i"<esc>H<a-;>'        -docstring '"surround"'
map global match "'" "\a'<esc>\i'<esc>H<a-;>"        -docstring "'surround'"
map global match '`' '\a`<esc>\i`<esc>H<a-;>'        -docstring '`surround`'
map global match d ': mirror-delete<ret>'            -docstring 'delete'
define-command -hidden mirror-delete %{ execute-keys Z<a-S><a-d>z<a-:>H }

