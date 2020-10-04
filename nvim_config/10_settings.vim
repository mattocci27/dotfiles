" base setting
" -------------------------------------------------------------------
"I don't want to use backup and undo files.
set nobackup
set noswapfile
set noundofile
"set guifont=Cousine\ Regular\ Nerd\ Font\ Plus\ Font\ Awesome\ Plus\ Octicons\ Plus\ Pomicons\ Plus\ Font\ Linux:h14
set guifont=Cousine\ Nerd:h14
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
set wrap
set textwidth=80
set linebreak
set synmaxcol=200
set fo+=l
set nolist

"set list
"set listchars=tab:\|\ ,trail:·,eol:↲,extends:»,precedes:«,nbsp:%

set foldmethod=indent
set foldlevel=2
set foldcolumn=3

" WSL
if system('uname -a | grep microsoft') != ""
  let g:clipboard = {
        \   'name': 'wslClipboard',
        \   'copy': {
        \      '+': 'win32yank.exe -i',
        \      '*': 'win32yank.exe -i',
        \    },
        \   'paste': {
        \      '+': 'win32yank.exe -o',
        \      '*': 'win32yank.exe -o',
        \   },
        \   'cache_enabled': 1,
        \ }
endif
