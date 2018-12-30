syntax enable
"test
set background=dark

set t_ut= "clearing uses the current background color

" alacritty Operator Mono and VIM #489
"https://github.com/jwilm/alacritty/issues/489
hi Comment gui=italic cterm=italic
hi htmlArg gui=italic cterm=italic

if (v:version >= 800) && has("termguicolors")
"if has("nvim") && has("termguicolors")
  set termguicolors
  set t_8b=[48;2;%lu;%lu;%lum
  set t_8f=[38;2;%lu;%lu;%lum

  "if exists('$TMUX')
    " change cursor
    " for iTerm2 and Tmux
    "let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    "let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
    "let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    " for alacritty and Tmux
    "let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=\e[6 q\x7\<Esc>\\"
    "let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=\e[4 q\x7\<Esc>\\"
    "let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=\e[2 q\x7\<Esc>\\"
    let &t_SI = "\<Esc>]50;CursorShape=\e[6 q\x7"
    let &t_SR = "\<Esc>]50;CursorShape=\e[4 q\x7"
    let &t_EI = "\<Esc>]50;CursorShape=\e[2 q\x7"

  colorscheme my_material2
  "colorscheme palenight
  highlight CursorLine guibg='#292930'
else
  autocmd ColorScheme * highlight Normal ctermbg=none
  autocmd ColorScheme * highlight LineNr ctermbg=none
  set t_Co=256
  colorscheme material-theme
endif

" tranparent
highlight Normal guibg=none 
highlight NonText guibg=none
highlight LineNr guibg=none
highlight Folded guibg=none
highlight EndOfBuffer guibg=none

"ses_transparent = 0
function! Toggle_transparent()
    if t:is_transparent == 0
        hi Normal guibg=NONE ctermbg=NONE
        let t:is_transparent = 1
    else
        set background=dark
        let t:is_tranparent = 0
    endif
endfunction
nnoremap <C-t> : call Toggle_transparent()<CR>t cursorline


set updatetime=4000
augroup vimrc-auto-cursorline
  autocmd CursorMoved,CursorMovedI * call s:auto_cursorline('CursorMoved')
  autocmd CursorHold,CursorHoldI * call s:auto_cursorline('CursorHold')
  autocmd WinEnter,BufEnter,CmdwinLeave * call s:auto_cursorline('WinEnter,BufEnter,CmdwinLeave')
  autocmd WinLeave * call s:auto_cursorline('WinLeave')

  let s:cursorline_lock = 0
  function! s:auto_cursorline(event)
    if a:event ==# 'WinEnter,BufEnter,CmdwinLeave'
      setlocal cursorline
      let s:cursorline_lock = 2
    elseif a:event ==# 'WinLeave'
      setlocal nocursorline
    elseif a:event ==# 'CursorMoved'
      if s:cursorline_lock
        if 1 < s:cursorline_lock
          let s:cursorline_lock = 1
        else
          setlocal nocursorline
          let s:cursorline_lock = 0
        endif
      endif
    elseif a:event ==# 'CursorHold'
      setlocal cursorline
      let s:cursorline_lock = 1
    endif
  endfunction
augroup END


"let g:lightline = {
"  \ 'colorscheme': 'material-theme',
"  \ }

" base setting
" -------------------------------------------------------------------
"I don't want to use backup and undo files.
set nobackup
set noswapfile
set noundofile
set guifont=Cousine\ Regular\ Nerd\ Font\ Plus\ Font\ Awesome\ Plus\ Octicons\ Plus\ Pomicons\ Plus\ Font\ Linux:h14
set encoding=utf-8
set number " put line numbers
set clipboard+=unnamedplus
"set clipboard=unnamed " use clipboard
set ruler "use ruler
set cmdheight=2 "height for cmd
set laststatus=2 "position for status line
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P " contens for status line
set title " show file path in title
set expandtab " tab -> space
set tabstop=2 "
set shiftwidth=2
set smartindent "
set linespace=5
set textwidth=0
set synmaxcol=200
set wrap

set list
set listchars=tab:\|\ ,trail:·,eol:↲,extends:»,precedes:«,nbsp:%

set foldmethod=indent
set foldlevel=2
set foldcolumn=3
