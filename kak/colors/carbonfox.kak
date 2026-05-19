declare-option -hidden str background "rgb:161616"
declare-option -hidden str color0 "rgb:282828"
declare-option -hidden str color1 "rgb:ee5396"
declare-option -hidden str color2 "rgb:25be6a"
declare-option -hidden str color3 "rgb:08bdba"
declare-option -hidden str color4 "rgb:78a9ff"
declare-option -hidden str color5 "rgb:be95ff"
declare-option -hidden str color6 "rgb:33b1ff"
declare-option -hidden str color7 "rgb:dfdfe0"
declare-option -hidden str color8 "rgb:484848"
declare-option -hidden str color9 "rgb:f16da6"
declare-option -hidden str color10 "rgb:46c880"
declare-option -hidden str color11 "rgb:2dc7c4"
declare-option -hidden str color12 "rgb:33b1ff"
declare-option -hidden str color13 "rgb:c8a5ff"
declare-option -hidden str color14 "rgb:52bdff"
declare-option -hidden str color15 "rgb:e4e4e5"
declare-option -hidden str color16 "rgb:3ddbd9"

# For Code
face global value "%opt{color3},default,default"
face global constant "rgb:5ae0df,default,default"
face global type "%opt{color3},default,default"
face global variable "%opt{color12},default,default"
face global module "%opt{color2},default,default"
face global function "%opt{color5},default,default"
face global string "%opt{color2},default,default"
face global keyword "%opt{color5},default,default"
face global operator "%opt{color15},default,default"
face global attribute "%opt{color12},default,default"
face global comment "rgb:6e6f70,default,default"
face global documentation "default,default,default"
face global meta "%opt{color5},default,default"
face global builtin "%opt{color1},default,default+b"

# For markup
face global title "%opt{color4},default,default"
face global header "%opt{color6},default,default"
face global mono "%opt{color2},default,default"
face global block "%opt{color5},default,default"
face global link "%opt{color6},default,default"
face global bullet "%opt{color6},default,default"
face global list "%opt{color3},default,default"

# builtin faces
face global Default "default,%opt{background},default"
face global PrimarySelection "%opt{color7},%opt{color0},default+fg"
face global SecondarySelection "%opt{color0},%opt{color4},default+fg"
face global PrimaryCursor "%opt{color0},%opt{color7},default+fg"
face global SecondaryCursor "%opt{color0},%opt{color7},default+fg"
face global PrimaryCursorEol "%opt{color0},%opt{color6},default+fg"
face global SecondaryCursorEol "%opt{color0},%opt{color6},default+fg"
face global LineNumbers "default,default,default"
face global LineNumberCursor "default,default,default+r"
face global LineNumbersWrapped "default,default,default+i"
face global WrapMarker "%opt{color4},default,default"
face global MenuForeground "%opt{color7},%opt{color4},default"
face global MenuBackground "%opt{color4},%opt{color0},default"
face global MenuInfo "%opt{color6},default,default"
face global Information "%opt{color0},%opt{color6},default"
face global InlineInformation "default,default,default"
face global Error "%opt{color0},%opt{color1},default"
face global DiagnosticError "%opt{color1},default,default"
face global DiagnosticWarning "%opt{color3},default,default"
face global StatusLine "%opt{color6},%opt{color8},default"
face global StatusLineMode "%opt{color3},default,default"
face global StatusLineInfo "%opt{color4},default,default"
face global StatusLineValue "%opt{color2},default,default"
face global StatusCursor "%opt{color0},%opt{color6},default"
face global Prompt "%opt{color3},default,default"
face global MatchingChar "default,default,default+b"
face global BufferPadding "%opt{color4},default,default"
face global Whitespace "default,default,default+df"
face global WhitespaceIndent "default,default,default"
# face global DiagnosticHint "default,default,default"
# face global DiagnosticInfo "default,default,default"
# face global DiagnosticTagDeprecated "default,default,default+s"
# face global DiagnosticTagUnnecessary "default,default,default+d"
# face global InlayDiagnosticError "default,default,default"
# face global InlayDiagnosticHint "default,default,default"
# face global InlayDiagnosticInfo "default,default,default"
# face global InlayDiagnosticWarning "default,default,default"
# face global LineFlagError "%opt{color1},default,default"
# face global LineFlagHint "default,default,default"
# face global LineFlagInfo "default,default,default"
# face global LineFlagWarning "%opt{color3},default,default"
# face global Reference "default,default,default"
# face global ReferenceBind "default,default,default+u"
# face global InlayHint "%opt{color6},default,default+d"
# face global InlayCodeLens "%opt{color6},default,default+d"
# face global SnippetsNextPlaceholders "%opt{color0},%opt{color2},default+Ffga"
# face global SnippetsOtherPlaceholders "%opt{color0},%opt{color3},default+Ffga"

# face global Label                    default@Conditional
# face global Operator                 rgb:b6b8bb,default,default
# face global diffChanged              rgb:08bdba,default,default
# face global Keyword                  rgb:be95ff,default,default
# face global Macro                    default@PreProc
# face global Comment                  rgb:6e6f70,default,default
# face global Delimiter                default@Special
# face global diffAdded                rgb:25be6a,default,default
# face global diffRemoved              rgb:ee5396,default,default
# face global Type                     rgb:08bdba,default,default
# face global Special                  rgb:8cb6ff,default,default
# face global String                   rgb:25be6a,default,default
# face global Conditional              rgb:c8a5ff,default,default
# face global Function                 rgb:8cb6ff,default,default
# face global Constant                 rgb:5ae0df,default,default
# face global Title                    rgb:8cb6ff,default,default+b
# face global PreProc                  rgb:ff91c1,default,default
# face global StorageClass             default@Type

face global ts_attribute                    default@attribute
face global ts_comment                      default@comment
face global ts_conceal                      "%opt{color8},default,default"
face global ts_constant                     default@constant
face global ts_constant_numeric             default@value
face global ts_constant_macro               default@constant
face global ts_constructor                  default@keyword
face global ts_diff_plus                    "%opt{color10},default,default"
face global ts_diff_minus                   "%opt{color5},default,default"
face global ts_diff_delta                   "%opt{color3},default,default"
face global ts_error                        default@Error
face global ts_function                     default@function
face global ts_function_macro               "%opt{color1},default,default@constant"
face global ts_function_builtin             "default@builtin"
face global ts_hint                        "%opt{color8},default,default"
face global ts_info                         default@Information
face global ts_keyword                      default@keyword
face global ts_keyword_directive            "%opt{color9}@keyword"
face global ts_label                        "%opt{color8},%opt{color3},default+i"
face global ts_markup_bold                  default+b@block
face global ts_markup_heading               default@header
face global ts_markup_italic                default+i@block
face global ts_markup_list_unchecked        default@list
face global ts_markup_list_unnumbered       default@bullet
face global ts_markup_link_label            default@link
face global ts_markup_link_url              default@link
face global ts_markup_link_uri              default@link
face global ts_markup_link_text             default@link
face global ts_markup_quote                 default@block
face global ts_markup_quote_raw             default@block
face global ts_markup_strikethrough         default+s@block
face global ts_namespace                    default@module
face global ts_operator                     default@operator
face global ts_property                     default@attribute
face global ts_punctuation                  default
face global ts_special                      default@meta
face global ts_string                       default@string
face global ts_tag                          default@type
face global ts_tag_error                    default@Error
face global ts_text                         default@block
face global ts_type                         default@type
face global ts_variable                     default@variable
face global ts_warning                      "%opt{color10},default,default+i"


