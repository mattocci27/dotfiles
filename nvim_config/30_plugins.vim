"Plugin
" set the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')
  "Plug 'gmarik/Vundle.vim'
  Plug 'scrooloose/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight' "
  Plug 'jalvesaq/Nvim-R'
  Plug 'Townk/vim-autoclose'
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'itchyny/lightline.vim'
 " Plug 'alpaca-tc/alpaca_powertabline'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'Yggdroot/indentLine'
  Plug 'rking/ag.vim'
  Plug 'cohama/agit.vim'
  Plug 'Shougo/unite.vim'
  "Plug 'Shougo/neocomplete.vim'
  Plug 'godlygeek/tabular'
  Plug 'christoomey/vim-tmux-navigator'
  "Plug 'plasticboy/vim-markdown'
  "Plug 'mattocci27/vim-markdown'
  Plug 'vim-scripts/SyntaxRange'
  Plug 'shime/vim-livedown'
  Plug 'tpope/vim-surround'
  Plug 'wavded/vim-stylus'
  Plug 'maverickg/stan.vim'
  Plug 'jiangmiao/auto-pairs'
  Plug 'sedm0784/vim-you-autocorrect'
  Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
 
  " julia
  Plug 'JuliaEditorSupport/julia-vim'

  " snippet
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'

  " color
  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'mattocci27/vim-material-theme', { 'as': 'material-theme' }
  Plug 'drewtempelmeyer/palenight.vim'
  Plug 'altercation/vim-colors-solarized'

  " tmux vim
  Plug 'christoomey/vim-tmux-navigator'

  " for writing
  Plug 'reedes/vim-pencil' " Super-powered writing things
  Plug 'tpope/vim-abolish' " Fancy abbreviation replacements
  Plug 'junegunn/limelight.vim' " Highlights only active paragraph
  Plug 'junegunn/goyo.vim' " Full screen writing mode
  Plug 'reedes/vim-lexical' " Better spellcheck mappings
  Plug 'reedes/vim-litecorrect' " Better autocorrections
  Plug 'reedes/vim-textobj-sentence' " Treat sentences as text objects
  Plug 'reedes/vim-wordy' " Weasel words and passive voice
  "Plug 'plasticboy/vim-markdown'
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
  "Plug 'vim-pandoc/vim-pandoc'
  "Plug 'vim-pandoc/vim-pandoc-syntax'
  "Plug 'vim-pandoc/vim-rmarkdown'

call plug#end()

" R-LSP{{{
" deoplete options
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

" disable autocomplete by default
let b:deoplete_disable_auto_complete=1
let g:deoplete_disable_auto_complete=1

" call deoplete#custom#buffer_option('auto_complete', v:false)
" call deoplete#custom#source('LanguageClient', \ 'min_pattern_length', \ 2)

if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif

" Disable the candidates in Comment/String syntaxes.
call deoplete#custom#source('_',
            \ 'disabled_syntaxes', ['Comment', 'String'])

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" set sources
let g:deoplete#sources = {}
let g:deoplete#sources.cpp = ['LanguageClient']
let g:deoplete#sources.python = ['LanguageClient']
let g:deoplete#sources.python3 = ['LanguageClient']
let g:deoplete#sources.rust = ['LanguageClient']
let g:deoplete#sources.c = ['LanguageClient']
let g:deoplete#sources.vim = ['vim']

" ignored sources
let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources._ = ['buffer', 'around']
"}}}

"LanguageClient{{{
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
    \ 'r': ['R', '--slave', '-e', 'languageserver::run()'],
    \ 'rmd': ['R', '--slave', '-e', 'languageserver::run()'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ 'julia': ['julia', '--startup-file=no', '--history-file=no', '-e', '
    \       using LanguageServer;
    \       server = LanguageServer.LanguageServerInstance(stdin, stdout, false);
    \       server.runlinter = true;
    \       run(server);
    \ '],
    \ }
let g:LanguageClient_loadSettings = 1

let g:default_julia_version = '1.0'

" }}}
" nerdtree {{{
noremap <silent><C-e> :NERDTreeToggle<CR>
let g:NERDTreeDirArrows = 1
let NERDTreeWinSize=30
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

"Not to use the R.app
"
if $TMUX != ''
  let R_source = '$HOME/dotfiles/tmux_split.vim'
endif

let R_app = "radian"
let R_cmd = "R"
let R_hl_term = 0
let R_args = []  " if you had set any
let R_bracketed_paste = 1

let R_in_buffer = 0
let R_applescript = 0
"let R_tmux_split = 1
let R_nvimpager = "tab"
let R_rconsole_width = 0
let R_assign = 0 "do not use <-
let R_source_args = "echo=TRUE, print.eval=TRUE"
" }}}
" vim-fugitive{{{ show git brunch
if isdirectory(expand('~/.vim/bundle/vim-fugitive'))
  set statusline+=%{fugitive#statusline()}
endif
" }}}
" indentLine{{{
let g:indentLine_newVersion = 1
let g:indetLine_char = '|'
" }}}
" gitgutter{{{
let g:gitgutter_override_sign_column_highlight = 0
"highlight SignColumn guibg='#263238'   " terminal Vim "
highlight SignColumn ctermbg=red   " terminal Vim "
" }}}
" vim-airline{{{
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 2
let g:airline_theme='bubblegum'
let g:airline_powerline_fonts = 1
"}}}
"vim_markdown{{{
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:pandoc#modules#disabled = ["folding", "spell"]
let g:pandoc#syntax#conceal#use = 0
"}}}
"vim_devicons{{{
autocmd FileType nerdtree setlocal nolist
let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '
"}}}
"goyo{{{
let g:goyo_width = 80
"}}}
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
"markdown-preview.nvim{{{
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
" for rmd"
let g:mkdp_command_for_global = 1

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
"let g:mkdp_browser = 'google-chrome-stable'
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {}
    \ }

" use a custom markdown style must be absolute path
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
 let g:mkdp_page_title = '「${name}」'
"}}}
