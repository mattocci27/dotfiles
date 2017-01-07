syntax enable
set background=dark
colorscheme my_material

if has('tmux')
  set termguicolors
endif 

if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

set t_8b=[48;2;%lu;%lu;%lum
set t_8f=[38;2;%lu;%lu;%lum

let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }

set nobackup
set noswapfile
set guifont=MyricaM\ Monospace:h15
set number " put line numbers
set clipboard=unnamed,autoselect " use clipboard
set ruler "use ruler
set cmdheight=2 "height for cmd
set laststatus=2 "position for status line  
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P " contens for status line
set title " show file path in title
set tabstop=2 " 
set expandtab " tab -> space 
set smartindent "
set guifont=MyricaM\ Monospace:h15 "
set encoding=utf-8 "for moji bake


" keybinding
noremap! <C-j> <Esc>
vmap<C-j> <Esc>
nnoremap <S-h>   ^
nnoremap <S-j>   }
nnoremap <S-k>   {
nnoremap <S-l>   $

" Filetypes -----------------------------------------------------------

" Coffee {{{
augroup filetype_r
  autocmd!
  au BufNewFile,BufReadPost *.r,*R, setl foldmethod=indent nofoldenable
augroup END
" }}}


"Plugin
set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight' " 
Plugin 'jalvesaq/Nvim-R'
Plugin 'severin-lemaignan/vim-minimap'
"Plugin 'thinca/vim-quickrun'
Plugin 'Townk/vim-autoclose'  
Plugin 'tpope/vim-fugitive'
Plugin 'itchyny/lightline.vim'
call vundle#end()            " required
filetype plugin indent on    " required


" nerdtree {{{
nnoremap <silent><C-e> :NERDTreeToggle<CR>
let g:NERDTreeDirArrows = 1
let NERDTreeWinSize=22
" }}}
" vim-nerdtree-syntax-highlight{{{
let s:rspec_red = 'FE405F'
let s:git_orange = 'F54D27'
let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange " sets the color for .gitignore files
let g:NERDTreePatternMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreePatternMatchHighlightColor['.*_spec\.rb$'] = s:rspec_red " sets the color for files ending with _spec.rb
"}}}
" Nvim-R{{{ 
vmap <C-r> <Plug>RSendLine
nmap <C-r> <Plug>RSendLine
let R_in_buffer = 0
let R_applescript = 0
let R_tmux_split = 1
let R_assign = 0 "do not use <- 
" }}}
" vim-minimap{{{ 
let g:minimap_show='<leader>ms'
let g:minimap_update='<leader>mu'
let g:minimap_close='<leader>gc'
let g:minimap_toggle='<leader>gt'
let g:minimap_highlight='Visual'
" }}}
" vim-fugitive{{{ show git brunch
if isdirectory(expand('~/.vim/bundle/vim-fugitive'))
  set statusline+=%{fugitive#statusline()}
endif
" }}}
