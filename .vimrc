" colors ---------------------------------------------------------------
syntax enable
"test
set background=dark

set t_ut= "clearing uses the current background color


if (v:version >= 800)
  set termguicolors
  colorscheme my_material2
  "colorscheme solarized8_light
else
  set t_Co=256
  colorscheme material-theme
endif


set t_8b=[48;2;%lu;%lu;%lum
set t_8f=[38;2;%lu;%lu;%lum

" change cursor
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

set cursorline
highlight CursorLine guibg='#292930'

"let g:lightline = {
"  \ 'colorscheme': 'material-theme',
"  \ }

" base setting
" -------------------------------------------------------------------
"I don't want to use backup and undo files.
set nobackup
set noswapfile
set noundofile
set guifont=MyricaM\ Monospace:h15
"set guifont=Arial:h15
"set guifont=Richty\ Regular\ for\ Powerline\ Nerd\ Font\ Plus\ Font\ Awesome\ Plus\ Octicons\ Plus\ Pomicons\ Plus\ Font\ Linux:h15
set encoding=utf-8
set number " put line numbers
set clipboard=unnamed,autoselect " use clipboard
set ruler "use ruler
set cmdheight=2 "height for cmd
set laststatus=2 "position for status line
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P " contens for status line
set title " show file path in title
set expandtab " tab -> space
set tabstop=2 "
set shiftwidth=2
set smartindent "
set linespace=3
set textwidth=80
set synmaxcol=200
set wrap

set list
set listchars=tab:\|\ ,trail:·,eol:↲,extends:»,precedes:«,nbsp:%

set foldmethod=indent
set foldlevel=2
set foldcolumn=3

set tw=0
" keybinding
"noremap! <c-j> <esc>
"vmap<c-j> <esc>
nnoremap <s-h>   ^
nnoremap <s-j>   }
nnoremap <s-k>   {
nnoremap <s-l>   $
vmap <s-h>       ^
vmap <s-l>       $

"Easier split navigations
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h


inoremap { {}<Left>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap ( ()<ESC>i
inoremap (<Enter> ()<Left><CR><ESC><S-o>))}}

set backspace=indent,eol,start "enable delete key
let mapleader = "\<space>"

"copy one line
noremap <leader>v 0v$h
noremap <leader>o :<c-p> <cr>
noremap <leader>w :w <CR>


" vv to generate new vertical split 
nnoremap <silent> vv <C-w>v

"autocmd BufWritePre * :%s/\s\+$//ge
"map <s>co <s-i># <esc>
" filetypes -----------------------------------------------------------

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
"Plugin 'ryanoasis/vim-devicons'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight' "
Plugin 'jalvesaq/Nvim-R'
Plugin 'severin-lemaignan/vim-minimap'
"Plugin 'thinca/vim-quickrun'
Plugin 'Townk/vim-autoclose'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'itchyny/lightline.vim'
Plugin 'alpaca-tc/alpaca_powertabline'
"Plugin 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim'}
"Plugin 'Lokaltog/powerline-fontpatcher'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'Yggdroot/indentLine'
Plugin 'rking/ag.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'cohama/agit.vim'
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/neomru.vim'
Plugin 'Shougo/neocomplete.vim'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'christoomey/vim-tmux-navigator'

"Plugin 'mattn/benchvimrc-vim'
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
vmap <leader>r <Plug>RSendLine
nmap <leader>r <Plug>RSendLine
nmap <leader>sr <Plug>RStart
"imap <leader>sr <Plug>RStart
vmap <leader>sr <Plug>RStart
nmap <leader>qr <Plug>RClose
"imap <leader>qr <Plug>RClose
vmap <leader>qr <Plug>RClose

let R_in_buffer = 0
let R_applescript = 0
let R_tmux_split = 1
"let R_vsplit = 1
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
" powerline{{{
" let g:airline_powerline_fonts=1
" }}}
" indentLine{{{
let g:indetLine_char = '*'
" }}}
" unit.vim{{{
let g:unite_enable_start_insert=1
" バッファ一覧
noremap <C-P> :Unite buffer<CR>
" ファイル一覧
noremap <C-N> :Unite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
noremap <C-Z> :Unite file_mru<CR>
" sourcesを「今開いているファイルのディレクトリ」とする
noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
"}}}
" gitgutter{{{
let g:gitgutter_override_sign_column_highlight = 0
highlight SignColumn guibg='#263238'   " terminal Vim "
" }}}
" vim-airline{{{
"let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 2
let g:airline_theme='bubblegum'
let g:airline_powerline_fonts = 1
"}}}


" neocomplete{{{
highlight Pmenu ctermbg=4
highlight PmenuSel ctermbg=1
highlight PMenuSbar ctermbg=4

" 補完ウィンドウの設定
set completeopt=menuone

" rsenseでの自動補完機能を有効化
let g:rsenseUseOmniFunc = 1
" let g:rsenseHome = '/usr/local/lib/rsense-0.3'

" auto-ctagsを使ってファイル保存時にtagsファイルを更新
let g:auto_ctags = 1

" 起動時に有効化
let g:neocomplcache_enable_at_startup = 1

" 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplcache_enable_smart_case = 1

" _(アンダースコア)区切りの補完を有効化
let g:neocomplcache_enable_underbar_completion = 1

let g:neocomplcache_enable_camel_case_completion  =  1

" 最初の補完候補を選択状態にする
let g:neocomplcache_enable_auto_select = 1

" ポップアップメニューで表示される候補の数
let g:neocomplcache_max_list = 20

" シンタックスをキャッシュするときの最小文字長
let g:neocomplcache_min_syntax_length = 3

" 補完の設定
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
"autocmd FileType r setlocal omnifunc=rcomplete#Complete
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
if !exists('g:neocomplete#sources#omni#functions')
  let g:neocomplete#sources#omni#functions = {}
endif
"let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.r = '[[:alnum:].\\]\+'
"let g:neocomplete#sources#omni#functions.r = 'rcomplete#CompleteR'
let g:neocomplete#force_omni_input_patterns.r = '[[:alnum:].\\]\+'
let g:neocomplete#sources#omni#functions.r = 'rcomplete#CompleteR'
"if !exists('g:neocomplete#keyword_patterns')
"        let g:neocomplete#keyword_patterns = {}
"endif
"let g:neocomplete#keyword_patterns['default'] = '\h\w*'
"}}}
"vim_markdown{{{
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
"}}}
"}
