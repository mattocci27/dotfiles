" Material Theme (https://github.com/atom-material/atom-material-syntax)
" Name: my_material2.vim
" Maintainer: ***
" Based on: https://github.com/MaxSt/FlatColor/
"            https://github.com/jdkanani/vim-material-theme

" This enables the coresponding base16-shell script to run so that
" :colorscheme works in terminals supported by base16-shell scripts
" "
" User must set this variable in .vimrc
"   let g:base16_shell_path=base16-builder/output/shell/
" if !has('gui_running')
"  if exists("g:base16_shell_path")
"    execute "silent !/bin/sh ".g:base16_shell_path."/base16-materialtheme.".&background.".sh"
"  endif
" endif

" Color Reference
"gui00 = "#263238"
"gui01 = "#404C52"
"gui02 = "#546E7A"
"gui03 = "#5C7E8C"
"gui04 = "#80CBC4"
"gui05 = "#C792EA"
"gui06 = "#7986CB"
"gui07 = "#82B1FF"
"gui08 = "#8BD649"
"gui09 = "#C3E88D"
"gui0A = "#CDD3DE"
"gui0B = "#EC5F67"
"gui0C = "#F1E655"
"gui0D = "#F77669"
"gui0E = "#FFE082"
"gui0F = "#AABBC3"

"@very-light-gray:   #EEFFFF;
"@light-gray:        #B2CCD6;
"@gray:              #373b41;
"@dark-gray:         #282a2e;
"@very-dark-gray:    #263238;
"
"@green:             #C3E88D;
"@teal:              #009688;
"@light-teal:        #73d1c8;
"@cyan:              #89DDF3;
"@blue:              #82AAFF;
"@indigo:            #7986CB;
"@purple:            #C792EA;
"@pink:              #FF5370;
"@red:               #F07178;
"@strong-orange:     #F78C6A;
"@orange:            #FFCB6B;
"@light-orange:      #FFE082;
" +---------------+
" |Initialization |
" +---------------+

" Theme setup
hi clear
syntax reset
let g:colors_name = "my_material2"

" This function is based on one from FlatColor: https://github.com/MaxSt/FlatColor/
" Which in turn was based on one found in hemisu: https://github.com/noahfrederick/vim-hemisu/
function! s:h(group, style)
  if g:my_material_terminal_italics == 0
    if has_key(a:style, "cterm") && a:style["cterm"] == "italic"
      unlet a:style.cterm
    endif
    if has_key(a:style, "gui") && a:style["gui"] == "italic"
      unlet a:style.gui
    endif
  endif
  if g:my_material_termcolors == 16
    let l:ctermfg = (has_key(a:style, "fg") ? a:style.fg.cterm16 : "NONE")
    let l:ctermbg = (has_key(a:style, "bg") ? a:style.bg.cterm16 : "NONE")
  else
    let l:ctermfg = (has_key(a:style, "fg") ? a:style.fg.cterm : "NONE")
    let l:ctermbg = (has_key(a:style, "bg") ? a:style.bg.cterm : "NONE")
  endif
  execute "highlight" a:group
    \ "guifg="   (has_key(a:style, "fg")    ? a:style.fg.gui   : "NONE")
    \ "guibg="   (has_key(a:style, "bg")    ? a:style.bg.gui   : "NONE")
    \ "guisp="   (has_key(a:style, "sp")    ? a:style.sp.gui   : "NONE")
    \ "gui="     (has_key(a:style, "gui")   ? a:style.gui      : "NONE")
    \ "ctermfg=" . l:ctermfg
    \ "ctermbg=" . l:ctermbg
    \ "cterm="   (has_key(a:style, "cterm") ? a:style.cterm    : "NONE")
endfunction

"public {{

function! my_material2#set_highlight(group, style)
  call s:h(a:group, a:style)
endfunction

"public end }}

" +-----------------+
" | Color Variables |
" +-----------------+

" GUI color definitions
let s:gui00 = "263238"
"let s:gui00 = "d81b60"
let s:gui01 = "404C52"

let s:gui02 = "546E7A"
let s:gui03 = "5C7E8C"
let s:gui04 = "80CBC4"
let s:gui05 = "C792EA"
let s:gui06 = "7986CB"
let s:gui07 = "82B1FF"
let s:gui08 = "8BD649"
let s:gui09 = "C3E88D"
let s:gui0A = "CDD3DE"
let s:gui0B = "EC5F67"
let s:gui0C = "F1E655"
let s:gui0D = "F77669"
let s:gui0E = "F8E71C"
let s:gui0F = "AABBC3"

" Terminal color definitions
let s:cterm00 = "00"
let s:cterm03 = "08"
let s:cterm05 = "07"
let s:cterm07 = "15"
let s:cterm08 = "01"
let s:cterm0A = "03"
let s:cterm0B = "02"
let s:cterm0C = "06"
let s:cterm0D = "04"
let s:cterm0E = "05"
if exists('base16colorspace') && base16colorspace == "256"
  let s:cterm01 = "18"
  let s:cterm02 = "19"
  let s:cterm04 = "20"
  let s:cterm06 = "21"
  let s:cterm09 = "16"
  let s:cterm0F = "17"
else
  let s:cterm01 = "10"
  let s:cterm02 = "11"
  let s:cterm04 = "12"
  let s:cterm06 = "13"
  let s:cterm09 = "09"
  let s:cterm0F = "14"
endif

" Terminal color definitions
"let s:cterm00 = "263238"
"let s:cterm01 = "37474F"
"let s:cterm02 = "546E7A"
"let s:cterm03 = "5C7E8C"
"let s:cterm04 = "80CBC4"
"let s:cterm05 = "C792EA"
"let s:cterm06 = "7986CB"
"let s:cterm07 = "82B1FF"
"let s:cterm08 = "8BD649"
"let s:cterm09 = "C3E88D"
"let s:cterm0A = "CDD3DE"
"let s:cterm0B = "EC5F67"
"let s:cterm0C = "F1E655"
"let s:cterm0D = "F77669"
"let s:cterm0E = "F8E71C"
"let s:cterm0F = "FFFFFF"


" Highlighting function
fun <sid>hi(group, guifg, guibg, ctermfg, ctermbg, attr)
  if a:guifg != ""
    exec "hi " . a:group . " guifg=#" . s:gui(a:guifg)
  endif
  if a:guibg != ""
    exec "hi " . a:group . " guibg=#" . s:gui(a:guibg)
  endif
  if a:ctermfg != ""
    exec "hi " . a:group . " ctermfg=" . s:cterm(a:ctermfg)
  endif
  if a:ctermbg != ""
    exec "hi " . a:group . " ctermbg=" . s:cterm(a:ctermbg)
  endif
  if a:attr != ""
    exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
  endif
endfun

" Return GUI color for light/dark variants
fun s:gui(color)
  if &background == "dark"
    return a:color
  endif

  if a:color == s:gui00
    return s:gui0F
  elseif a:color == s:gui01
    return s:gui06
  elseif a:color == s:gui02
    return s:gui05
  elseif a:color == s:gui03
    return s:gui04
  elseif a:color == s:gui05
    return s:gui02
  elseif a:color == s:gui06
    return s:gui01
  elseif a:color == s:gui0F
    return s:gui0A
  endif

  return a:color
endfun

" Return terminal color for light/dark variants
fun s:cterm(color)
  if &background == "dark"
    return a:color
  endif

  if a:color == s:cterm00
    return s:cterm07
  elseif a:color == s:cterm01
    return s:cterm06
  elseif a:color == s:cterm02
    return s:cterm05
  elseif a:color == s:cterm03
    return s:cterm04
  elseif a:color == s:cterm04
    return s:cterm03
  elseif a:color == s:cterm05
    return s:cterm02
  elseif a:color == s:cterm06
    return s:cterm01
  elseif a:color == s:cterm07
    return s:cterm00
  endif

  return a:color
endfun

" Vim editor colors
call <sid>hi("Bold",          "", "", "", "", "bold")
call <sid>hi("Debug",         s:gui08, "", s:cterm08, "", "")
call <sid>hi("Directory",     s:gui04, "", s:cterm04, "", "")
call <sid>hi("ErrorMsg",      s:gui08, s:gui00, s:cterm08, s:cterm00, "")
call <sid>hi("Exception",     s:gui0D, "", s:cterm0D, "", "")
call <sid>hi("FoldColumn",    "", s:gui00, "", s:cterm01, "")
call <sid>hi("Folded",        s:gui03, s:gui00, s:cterm03, s:cterm01, "")
call <sid>hi("IncSearch",     s:gui01, s:gui09, s:cterm01, s:cterm09, "none")
call <sid>hi("Italic",        "", "", "", "", "none")
call <sid>hi("Macro",         s:gui08, "", s:cterm08, "", "")
call <sid>hi("MatchParen",    s:gui00, s:gui03, s:cterm00, s:cterm03,  "")
call <sid>hi("ModeMsg",       s:gui04, "", s:cterm04, "", "")
call <sid>hi("MoreMsg",       s:gui04, "", s:cterm04, "", "")
call <sid>hi("Question",      s:gui0D, "", s:cterm0D, "", "")
call <sid>hi("Search",        s:gui03, s:gui0A, s:cterm03, s:cterm0A,  "")
call <sid>hi("specialkey",    s:gui03, "", s:cterm03, "", "")
call <sid>hi("TooLong",       s:gui08, "", s:cterm08, "", "")
call <sid>hi("Underlined",    s:gui08, "", s:cterm08, "", "")
call <sid>hi("Visual",        "", s:gui02, "", s:cterm01, "none")
call <sid>hi("VisualNOS",     "", s:gui02, "", s:cterm01, "")
call <sid>hi("WarningMsg",    s:gui08, "", s:cterm08, "", "")
call <sid>hi("WildMenu",      s:gui08, "", s:cterm08, "", "")
call <sid>hi("Title",         s:gui04, "", s:cterm04, "", "none")
call <sid>hi("Conceal",       s:gui04, s:gui00, s:cterm04, s:cterm00, "")
call <sid>hi("Cursor",        "", s:gui02, "", s:cterm01, "")
call <sid>hi("NonText",       s:gui03, "", s:cterm03, "", "")
call <sid>hi("Normal",        s:gui0F, s:gui00, s:cterm0F, s:cterm00, "")
call <sid>hi("LineNr",        s:gui03, s:gui00, s:cterm01, s:cterm00, "")
call <sid>hi("SignColumn",    s:gui03, s:gui01, s:cterm03, s:cterm01, "")
call <sid>hi("SpecialKey",    s:gui04, "", s:cterm04, "", "")
call <sid>hi("StatusLine",    s:gui04, s:gui02, s:cterm04, s:cterm02, "none")
call <sid>hi("StatusLineNC",  s:gui03, s:gui01, s:cterm03, s:cterm01, "none")
call <sid>hi("VertSplit",     s:gui00, s:gui00, s:cterm00, s:cterm00, "none")
call <sid>hi("ColorColumn",   "", s:gui02, "", s:cterm01, "none")
call <sid>hi("CursorColumn",  "", s:gui02, "", s:cterm01, "none")
call <sid>hi("CursorLine",    "", s:gui02, "", s:cterm01, "none")
call <sid>hi("CursorLineNr",  s:gui04, s:gui00, "", s:cterm01, "none")
call <sid>hi("PMenu",         s:gui04, s:gui01, s:cterm04, s:cterm01, "none")
call <sid>hi("PMenuSel",      s:gui0A, s:gui01, s:cterm0A, s:cterm01, "")
call <sid>hi("TabLine",       s:gui03, s:gui01, s:cterm03, s:cterm01, "none")
call <sid>hi("TabLineFill",   s:gui03, s:gui01, s:cterm03, s:cterm01, "none")
call <sid>hi("TabLineSel",    s:gui09, s:gui01, s:cterm03, s:cterm01, "none")

" Hide '~' at end of buffer in neovim
" Set g:material_hide_endofbuffer = 0 to disable
if has('nvim') && (!exists('g:material_hide_endofbuffer') || g:material_hide_endofbuffer == 1)
  call <sid>hi("EndOfBuffer",s:gui00, s:gui00, s:cterm00, s:cterm00, "none")
endif

" Standard syntax highlighting
call <sid>hi("Boolean",      s:gui0D, "", s:cterm0D, "", "none")
call <sid>hi("Character",    s:gui08, "", s:cterm08, "", "none")
call <sid>hi("Comment",      s:gui03, "", s:cterm03, "", "none")
call <sid>hi("Conditional",  s:gui05, "", s:cterm05, "", "none")
call <sid>hi("Constant",     s:gui0D, "", s:cterm0D, "", "none")
call <sid>hi("Define",       s:gui07, "", s:cterm07, "", "none")
call <sid>hi("Delimiter",    s:gui04, "", s:cterm04, "", "none")
call <sid>hi("Float",        s:gui0D, "", s:cterm0D, "", "none")
call <sid>hi("Function",     s:gui07, "", s:cterm07, "", "none")
call <sid>hi("Identifier",   s:gui05, "", s:cterm05, "", "none")
call <sid>hi("Include",      s:gui05, "", s:cterm05, "", "none")
call <sid>hi("Keyword",      s:gui05, "", s:cterm05, "", "none")
call <sid>hi("Label",        s:gui06, "", s:cterm06, "", "none")
call <sid>hi("Number",       s:gui0D, "", s:cterm0D, "", "none")
call <sid>hi("Operator",     s:gui05, "", s:cterm05, "", "none")
call <sid>hi("PreProc",      s:gui05, "", s:cterm05, "", "none")
call <sid>hi("Repeat",       s:gui04, "", s:cterm04, "", "none")
call <sid>hi("Special",      s:gui07, "", s:cterm07, "", "none")
call <sid>hi("SpecialChar",  s:gui04, "", s:cterm04, "", "none")
call <sid>hi("Statement",    s:gui05, "", s:cterm05, "", "none")
call <sid>hi("StorageClass", s:gui07, "", s:cterm07, "", "none")
call <sid>hi("String",       s:gui09, "", s:cterm09, "", "none")
call <sid>hi("Structure",    s:gui07, "", s:cterm07, "", "none")
call <sid>hi("Tag",          s:gui07, "", s:cterm07, "", "none")
call <sid>hi("Todo",         s:gui0D, s:gui00, s:cterm0D, s:cterm00, "")
call <sid>hi("Type",         s:gui07, "", s:cterm07, "", "none")
call <sid>hi("Typedef",      s:gui07, "", s:cterm07, "", "none")

" C highlighting
call <sid>hi("cOperator",   s:gui0C, "", s:cterm0C, "", "")
call <sid>hi("cPreCondit",  s:gui0E, "", s:cterm0E, "", "")

" C# highlighting
call <sid>hi("csClass",                 s:gui0A, "", s:cterm0A, "", "")
call <sid>hi("csAttribute",             s:gui0A, "", s:cterm0A, "", "")
call <sid>hi("csModifier",              s:gui0E, "", s:cterm0E, "", "")
call <sid>hi("csType",                  s:gui08, "", s:cterm08, "", "")
call <sid>hi("csUnspecifiedStatement",  s:gui0D, "", s:cterm0D, "", "")
call <sid>hi("csContextualStatement",   s:gui0E, "", s:cterm0E, "", "")
call <sid>hi("csNewDecleration",        s:gui08, "", s:cterm08, "", "")

" CSS highlighting
call <sid>hi("cssBraces",      s:gui05, "", s:cterm05, "", "")
call <sid>hi("cssClassName",   s:gui0E, "", s:cterm0E, "", "")
call <sid>hi("cssColor",       s:gui0C, "", s:cterm0C, "", "")

" Diff highlighting
call <sid>hi("DiffAdd",      s:gui04, s:gui01,  s:cterm04, s:cterm01, "")
call <sid>hi("DiffChange",   s:gui03, s:gui01,  s:cterm03, s:cterm01, "")
call <sid>hi("DiffDelete",   s:gui06, s:gui01,  s:cterm06, s:cterm01, "")
call <sid>hi("DiffText",     s:gui04, s:gui01,  s:cterm04, s:cterm01, "")
call <sid>hi("DiffAdded",    s:gui06, s:gui00,  s:cterm06, s:cterm00, "")
call <sid>hi("DiffFile",     s:gui06, s:gui00,  s:cterm06, s:cterm00, "")
call <sid>hi("DiffNewFile",  s:gui05, s:gui00,  s:cterm05, s:cterm00, "")
call <sid>hi("DiffLine",     s:gui04, s:gui00,  s:cterm04, s:cterm00, "")
call <sid>hi("DiffRemoved",  s:gui0D, s:gui00,  s:cterm0D, s:cterm00, "")

" Git highlighting
call <sid>hi("gitCommitOverflow",  s:gui08, "", s:cterm08, "", "")
call <sid>hi("gitCommitSummary",   s:gui04, "", s:cterm04, "", "")

" GitGutter highlighting
call <sid>hi("GitGutterAdd",     s:gui04, s:gui01, s:cterm04, s:cterm01, "")
call <sid>hi("GitGutterChange",  s:gui05, s:gui01, s:cterm05, s:cterm01, "")
call <sid>hi("GitGutterDelete",  s:gui0D, s:gui01, s:cterm0D, s:cterm01, "")
call <sid>hi("GitGutterChangeDelete",  s:gui0E, s:gui01, s:cterm0E, s:cterm01, "")

" HTML highlighting
call <sid>hi("htmlBold",    s:gui0A, "", s:cterm0A, "", "")
call <sid>hi("htmlItalic",  s:gui0E, "", s:cterm0E, "", "")
call <sid>hi("htmlEndTag",  s:gui04, "", s:cterm04, "", "")
call <sid>hi("htmlTag",     s:gui04, "", s:cterm04, "", "")
call <sid>hi("htmlTagName", s:gui07, "", s:cterm07, "", "")
call <sid>hi("htmlArg",     s:gui04, "", s:cterm04, "", "")

" JavaScript highlighting
call <sid>hi("javaScript",        s:gui05, "", s:cterm05, "", "")
call <sid>hi("javaScriptBraces",  s:gui05, "", s:cterm05, "", "")
call <sid>hi("javaScriptNumber",  s:gui0D, "", s:cterm0D, "", "")

" Markdown highlighting
call <sid>hi("markdownCode",              s:gui06, "", s:cterm06, "", "")
call <sid>hi("markdownError",             s:gui0B, s:gui00, s:cterm0B, s:cterm00, "")
call <sid>hi("markdownCodeBlock",         s:gui06, "", s:cterm06, "", "")
call <sid>hi("markdownHeadingDelimiter",  s:gui0D, "", s:cterm0D, "", "")

" NERDTree highlighting
call <sid>hi("NERDTreeDirSlash",  s:gui04, "", s:cterm04, "", "")
call <sid>hi("NERDTreeExecFile",  s:gui0D, "", s:cterm0D, "", "")

" PHP highlighting
call <sid>hi("phpComparison",     s:gui05, "", s:cterm05, "", "")
call <sid>hi("phpMethodsVar",     s:gui07, "", s:cterm07, "", "")
call <sid>hi("phpMemberSelector", s:gui04, "", s:cterm04, "", "")
call <sid>hi("phpIdentifier",     s:gui04, "", s:cterm04, "", "")
call <sid>hi("phpVarSelector",    s:gui04, "", s:cterm04, "", "")
call <sid>hi("phpType",           s:gui05, "", s:cterm05, "", "")
call <sid>hi("phpClass",          s:gui0C, "", s:cterm0C, "", "")
call <sid>hi("phpClasses",        s:gui0C, "", s:cterm0C, "", "")
call <sid>hi("phpParent",         s:gui02, "", s:cterm02, "", "")
call <sid>hi("phpFunctions",      s:gui07, "", s:cterm07, "", "")
call <sid>hi("phpFunction",       s:gui07, "", s:cterm07, "", "")
call <sid>hi("phpMethod",         s:gui07, "", s:cterm07, "", "")
call <sid>hi("phpOperator",       s:gui04, "", s:cterm04, "", "")
call <sid>hi("phpKeyword",        s:gui05, "", s:cterm05, "", "")
call <sid>hi("phpClassExtends",   s:gui0A, "", s:cterm0A, "", "")
call <sid>hi("phpInclude",        s:gui05, "", s:cterm05, "", "")
call <sid>hi("phpUseClass",       s:gui0A, "", s:cterm0A, "", "")
call <sid>hi("phpBoolean",        s:gui05, "", s:cterm05, "", "")

" Python highlighting
call <sid>hi("pythonOperator",  s:gui04, "", s:cterm04, "", "")
call <sid>hi("pythonRepeat",    s:gui04, "", s:cterm04, "", "")

" R highlighting
call <sid>hi("rOperator",  s:gui07, "", s:cterm07, "", "")


" Ruby highlighting
call <sid>hi("rubyAttribute",               s:gui0D, "", s:cterm0D, "", "")
call <sid>hi("rubyConstant",                s:gui0A, "", s:cterm0A, "", "")
call <sid>hi("rubyInterpolation",           s:gui0B, "", s:cterm0B, "", "")
call <sid>hi("rubyInterpolationDelimiter",  s:gui0F, "", s:cterm0F, "", "")
call <sid>hi("rubyRegexp",                  s:gui0C, "", s:cterm0C, "", "")
call <sid>hi("rubySymbol",                  s:gui0B, "", s:cterm0B, "", "")
call <sid>hi("rubyStringDelimiter",         s:gui0B, "", s:cterm0B, "", "")

" SASS highlighting
call <sid>hi("sassidChar",     s:gui08, "", s:cterm08, "", "")
call <sid>hi("sassClassChar",  s:gui09, "", s:cterm09, "", "")
call <sid>hi("sassInclude",    s:gui0E, "", s:cterm0E, "", "")
call <sid>hi("sassMixing",     s:gui0E, "", s:cterm0E, "", "")
call <sid>hi("sassMixinName",  s:gui0D, "", s:cterm0D, "", "")

" Signify highlighting
call <sid>hi("SignifySignAdd",     s:gui0B, s:gui01, s:cterm0B, s:cterm01, "")
call <sid>hi("SignifySignChange",  s:gui0D, s:gui01, s:cterm0D, s:cterm01, "")
call <sid>hi("SignifySignDelete",  s:gui08, s:gui01, s:cterm08, s:cterm01, "")

" Spelling highlighting
call <sid>hi("SpellBad",     "", s:gui00, "", s:cterm00, "undercurl")
call <sid>hi("SpellLocal",   "", s:gui00, "", s:cterm00, "undercurl")
call <sid>hi("SpellCap",     "", s:gui00, "", s:cterm00, "undercurl")
call <sid>hi("SpellRare",    "", s:gui00, "", s:cterm00, "undercurl")

" Remove functions
delf <sid>hi
delf <sid>gui
delf <sid>cterm

" Remove color variables
unlet s:gui00 s:gui01 s:gui02 s:gui03  s:gui04  s:gui05  s:gui06  s:gui07  s:gui08  s:gui09 s:gui0A  s:gui0B  s:gui0C  s:gui0D  s:gui0E  s:gui0F
unlet s:cterm00 s:cterm01 s:cterm02 s:cterm03 s:cterm04 s:cterm05 s:cterm06 s:cterm07 s:cterm08 s:cterm09 s:cterm0A s:cterm0B s:cterm0C s:cterm0D s:cterm0E s:cterm0F
