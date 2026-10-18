# Catppuccin Mocha theme for Kakoune recolored to rose_pine
#
# Taken and adapted from
# <https://github.com/catppuccin/kakoune/blob/7f187d9da2867a7fda568b2135d29b9c00cfbb94/colors/catppuccin_mocha.kak>

# Color palette (Rosé Pine + Rosé Pine Moon)
declare-option str rose "rgb:ea9a97" # rosewater
declare-option str rose_2  "rgb:ea9a97" # flamingo
declare-option str pink      "rgb:eb6f92" # love
declare-option str mauve     "rgb:c4a7e7" # iris
declare-option str red       "rgb:eb6f92" # love
declare-option str maroon    "rgb:ea9a97" # rose
declare-option str peach     "rgb:ea9d34" # gold
declare-option str yellow    "rgb:f6c177" # gold
declare-option str green     "rgb:9ccfd8" # foam
declare-option str teal      "rgb:9ccfd8" # foam
declare-option str sky       "rgb:3e8fb0" # moon pine
declare-option str sapphire  "rgb:31748f" # pine
declare-option str blue      "rgb:f6c177" # gold
declare-option str lavender  "rgb:c4a7e7" # iris

declare-option str text      "rgb:e0def4"
declare-option str subtext1  "rgb:908caa"
declare-option str subtext0  "rgb:6e6a86"
declare-option str overlay2  "rgb:6e6a86"
declare-option str overlay1  "rgb:56526e"
declare-option str overlay0  "rgb:393552"
declare-option str surface2  "rgb:393552"
declare-option str surface1  "rgb:2a273f"
declare-option str surface0  "rgb:26233a"
declare-option str base      "rgb:1f1d2e"
declare-option str mantle    "rgb:191724"
declare-option str crust     "rgb:16141f"

# Markup
set-face global title  "%opt{text}+b"
set-face global header "%opt{subtext0}+b"
set-face global bold   "%opt{maroon}+b"
set-face global italic "%opt{maroon}+i"
set-face global mono   "%opt{green}"
set-face global block  "%opt{sapphire}"
set-face global link   "%opt{blue}"
set-face global bullet "%opt{peach}"
set-face global list   "%opt{peach}"

# Builtins
set-face global Default            "%opt{text},%opt{crust}"
set-face global PrimarySelection   "default,rgba:3935527a"
set-face global SecondarySelection "default,rgba:3935527a"
set-face global PrimaryCursor      "%opt{base},%opt{text}+b"
set-face global SecondaryCursor    "%opt{surface0},%opt{text}+b"
set-face global PrimaryCursorEol   "%opt{surface2},%opt{lavender}"
set-face global SecondaryCursorEol "%opt{surface2},%opt{overlay1}"
set-face global LineNumbers        "%opt{overlay1},%opt{crust}"
set-face global LineNumberCursor   "%opt{subtext1},%opt{base}+b"
set-face global LineNumbersWrapped "%opt{rose},%opt{base}"
set-face global MenuForeground     "%opt{text},%opt{base}+i"
set-face global MenuBackground     "%opt{subtext1},%opt{mantle}"
set-face global MenuInfo           "%opt{subtext1},%opt{mantle}"
set-face global Information        "%opt{subtext1},%opt{mantle}"
set-face global Error              "%opt{crust},%opt{red}"
set-face global DiagnosticError    "default,default,%opt{red}+c"
set-face global DiagnosticWarning  "default,default,%opt{yellow}+c"
set-face global StatusLine         "%opt{subtext1},%opt{crust}"
set-face global StatusLineMode     "%opt{crust},%opt{yellow}"
set-face global StatusLineInfo     "%opt{text},%opt{surface0}"
set-face global StatusLineValue    "%opt{crust},%opt{yellow}"
set-face global StatusCursor       "default,%opt{overlay2}"
set-face global Prompt             "%opt{text},%opt{crust}"
set-face global MatchingChar       "%opt{maroon},%opt{mantle}+b"
set-face global Whitespace         "%opt{overlay0},%opt{mantle}+f"
set-face global WrapMarker         "%opt{overlay1},%opt{crust}+f"
set-face global BufferPadding      "%opt{base},%opt{crust}"

# Code
set-face global value         "%opt{rose}"
set-face global type          "%opt{mauve}"
set-face global variable      "%opt{text}"
set-face global module        "%opt{sapphire}"        # changed from maroon: less visual separation from identifiers
set-face global function      "%opt{teal}"
set-face global string        "%opt{peach}"           # changed from green: closer to the previous string face
set-face global keyword       "%opt{maroon}"            # changed from mauve: can reduce distinction between keywords and functions
set-face global operator      "%opt{sky}"            # changed from sky: improves neutrality, but reduces operator visibility
set-face global attribute     "%opt{yellow}"            # changed from yellow: improves consistency, but loses attribute distinction
set-face global comment       "%opt{subtext1}+i"
set-face global documentation "%opt{subtext1}+i"
set-face global meta          "%opt{subtext1}"
set-face global builtin       "%opt{red}"

# Tree-sitter (<https://github.com/hadronized/kak-tree-sitter>)
# Copied from catppuccin_macchiato.kak
# Adjusted with https://github.com/catppuccin/catppuccin/blob/main/docs/style-guide.md
set-face global ts_attribute                    "%opt{yellow}"
set-face global ts_comment                      "%opt{subtext0}+i"
set-face global ts_comment_unused               "%opt{subtext0}+is"
set-face global ts_conceal                      "%opt{mauve}+i"
set-face global ts_constant                     "%opt{peach}"
set-face global ts_constant_builtin_boolean     "%opt{sky}"
set-face global ts_constant_character           "%opt{yellow}"
set-face global ts_constant_macro               "%opt{mauve}"
set-face global ts_constructor                  "%opt{sky}"
set-face global ts_diff_plus                    "%opt{green}"
set-face global ts_diff_minus                   "%opt{red}"
set-face global ts_diff_delta                   "%opt{blue}"
set-face global ts_diff_delta_moved             "%opt{mauve}"
set-face global ts_error                        "%opt{red}+b"
set-face global ts_function                     "%opt{teal}"
set-face global ts_function_builtin             "%opt{teal}+i"
set-face global ts_function_macro               "%opt{mauve}"
set-face global ts_hint                         "%opt{blue}+b"
set-face global ts_info                         "%opt{teal}+b"
set-face global ts_keyword                      "%opt{mauve}"
set-face global ts_keyword_conditional          "%opt{mauve}+i"
set-face global ts_keyword_control_conditional  "%opt{mauve}+i"
set-face global ts_keyword_control_directive    "%opt{mauve}+i"
set-face global ts_keyword_control_import       "%opt{mauve}+i"
set-face global ts_keyword_directive            "%opt{mauve}+i"
set-face global ts_keyword_storage              "%opt{mauve}"
set-face global ts_keyword_storage_modifier     "%opt{mauve}"
set-face global ts_keyword_storage_modifier_mut "%opt{mauve}"
set-face global ts_keyword_storage_modifier_ref "%opt{teal}"
set-face global ts_label                        "%opt{sky}+i"
set-face global ts_markup_bold                  "%opt{peach}+b"
set-face global ts_markup_heading               "%opt{red}"
set-face global ts_markup_heading_1             "%opt{red}"
set-face global ts_markup_heading_2             "%opt{mauve}"
set-face global ts_markup_heading_3             "%opt{green}"
set-face global ts_markup_heading_4             "%opt{yellow}"
set-face global ts_markup_heading_5             "%opt{pink}"
set-face global ts_markup_heading_6             "%opt{teal}"
set-face global ts_markup_heading_marker        "%opt{peach}+b"
set-face global ts_markup_italic                "%opt{pink}+i"
set-face global ts_markup_list_checked          "%opt{green}"
set-face global ts_markup_list_numbered         "%opt{blue}+i"
set-face global ts_markup_list_unchecked        "%opt{teal}"
set-face global ts_markup_list_unnumbered       "%opt{mauve}"
set-face global ts_markup_link_label            "%opt{blue}"
set-face global ts_markup_link_url              "%opt{teal}+u"
set-face global ts_markup_link_uri              "%opt{teal}+u"
set-face global ts_markup_link_text             "%opt{blue}"
set-face global ts_markup_quote                 "%opt{overlay1}"
set-face global ts_markup_raw                   "%opt{green}"
set-face global ts_markup_strikethrough         "%opt{overlay1}+s"
set-face global ts_namespace                    "%opt{blue}+i"
set-face global ts_operator                     "%opt{sky}"
set-face global ts_property                     "%opt{sky}"
set-face global ts_punctuation                  "%opt{overlay1}"
set-face global ts_punctuation_special          "%opt{sky}"
set-face global ts_special                      "%opt{blue}"
set-face global ts_spell                        "%opt{mauve}"
set-face global ts_string                       "%opt{yellow}"
set-face global ts_string_regex                 "%opt{peach}"
set-face global ts_string_regexp                "%opt{peach}"
set-face global ts_string_escape                "%opt{rose_2}"
set-face global ts_string_special               "%opt{blue}"
set-face global ts_string_special_path          "%opt{green}"
set-face global ts_string_special_symbol        "%opt{mauve}"
set-face global ts_string_symbol                "%opt{red}"
set-face global ts_tag                          "%opt{mauve}"
set-face global ts_tag_error                    "%opt{red}"
set-face global ts_text                         "%opt{text}"
set-face global ts_text_title                   "%opt{mauve}"
set-face global ts_type                         "%opt{green}"
set-face global ts_type_enum_variant            "%opt{sky}"
set-face global ts_type_enum_variant_builtin    "%opt{sky}+i"
set-face global ts_variable                     "%opt{text}"
set-face global ts_variable_builtin             "%opt{red}"
set-face global ts_variable_other_member        "%opt{teal}"
set-face global ts_variable_parameter           "%opt{maroon}+i"
set-face global ts_warning                      "%opt{yellow}+b"
