"Plugin
" set the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')
  Plug 'lambdalisue/fern.vim'
  Plug 'lambdalisue/fern-git-status.vim'
  Plug 'lambdalisue/nerdfont.vim'
  Plug 'lambdalisue/fern-renderer-nerdfont.vim'
  Plug 'lambdalisue/glyph-palette.vim'
  Plug 'ryanoasis/vim-devicons'
  Plug 'chrisbra/Colorizer'

  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'itchyny/lightline.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'Yggdroot/indentLine'
  Plug 'godlygeek/tabular'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'vim-scripts/SyntaxRange'
  Plug 'tpope/vim-surround'
  Plug 'wavded/vim-stylus'
  Plug 'jiangmiao/auto-pairs'
  Plug 'sedm0784/vim-you-autocorrect'
"  Plug 'autozimu/LanguageClient-neovim', {
"      \ 'branch': 'next',
"      \ 'do': 'bash install.sh',
"      \ }
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
 
  " R
  Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
  Plug 'eigenfoo/stan.vim'

  " julia
  Plug 'JuliaEditorSupport/julia-vim'

  " c++
  Plug 'justmao945/vim-clang'

  " snippet
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'

  " color
  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'jdkanani/vim-material-theme', { 'as': 'material-theme' }
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
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
 
  "tex
  Plug 'lervag/vimtex'

call plug#end()

" R-LSP{{{
" deoplete options
"let g:deoplete#enable_at_startup = 1
"
"" disable autocomplete by default
"let b:deoplete_disable_auto_complete=1
"let g:deoplete_disable_auto_complete=1
"
"" Disable the candidates in Comment/String syntaxes.
"call deoplete#custom#source('_',
"            \ 'disabled_syntaxes', ['Comment', 'String'])
"
"let g:deoplete#sources#rust#rust_source_path = '/usr/local/src/rust/src'
"
"autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
"
"" set sources
"call deoplete#custom#option('sources', {
"		\ '_': ['buffer'],
"		\ 'cpp': ['buffer', 'tag'],
"		\})

"}}}
"LanguageClient{{{
set hidden
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
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
"noremap <silent><C-e> :NERDTreeToggle<CR>
"let g:NERDTreeDirArrows = 1
"let NERDTreeWinSize=30
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
  let R_source = '$HOME/.config/tmux/tmux_split.vim'
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
let g:indentLine_setConceal = 0
" }}}
" gitgutter{{{
"let g:gitgutter_override_sign_column_highlight = 0
"highlight SignColumn guibg='#263238'   " terminal Vim "
"highlight SignColumn ctermbg=red   " terminal Vim "
"" git操作
" g]で前の変更箇所へ移動する
nnoremap g[ :GitGutterPrevHunk<CR>
" g[で次の変更箇所へ移動する
nnoremap g] :GitGutterNextHunk<CR>
" ghでdiffをハイライトする
nnoremap gh :GitGutterLineHighlightsToggle<CR>
" gpでカーソル行のdiffを表示する
nnoremap gp :GitGutterPreviewHunk<CR>
" 記号の色を変更する
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=blue
highlight GitGutterDelete ctermfg=red

"" 反映時間を短くする(デフォルトは4000ms)
set updatetime=250
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

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
" let g:mkdp_filetypes = ['markdown', 'rmd', 'Rmd']
let g:mkdp_filetypes = ['markdown']

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
"vim_clang{{{
let g:clang_c_options = '-std=gnu11'
let g:clang_cpp_options = '-std=c++11 -stdlib=libc++'
"}}}
" fgf{{{
"nnoremap <C-p> :FZFFileList<CR>
"command! FZFFileList call fzf#run({
"      \ 'source': 'find . -type d -name .git -prune -o ! -name .DS_Store',
"      \ 'sink': 'e'})
"" fzf.vim
" Ctrl+pでファイル検索を開く
" git管理されていれば:GFiles、そうでなければ:Filesを実行する
fun! FzfOmniFiles()
  let is_git = system('git status')
  if v:shell_error
    :Files
  else
    :GFiles
  endif
endfun
nnoremap <C-p> :call FzfOmniFiles()<CR>

" Ctrl+gで文字列検索を開く
" <S-?>でプレビューを表示/非表示する
command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\ 'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
\ <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 3..'}, 'up:60%')
\ : fzf#vim#with_preview({'options': '--exact --delimiter : --nth 3..'}, 'right:50%:hidden', '?'),
\ <bang>0)
nnoremap <C-g> :Rg<CR>

" frでカーソル位置の単語をファイル検索する
nnoremap fr vawy:Rg <C-R>"<CR>
" frで選択した単語をファイル検索する
xnoremap fr y:Rg <C-R>"<CR>

" fbでバッファ検索を開く
nnoremap fb :Buffers<CR>
" fpでバッファの中で1つ前に開いたファイルを開く
nnoremap fp :Buffers<CR><CR>
" flで開いているファイルの文字列検索を開く
nnoremap fl :BLines<CR>
" fmでマーク検索を開く
nnoremap fm :Marks<CR>
" fhでファイル閲覧履歴検索を開く
nnoremap fh :History<CR>
" fcでコミット履歴検索を開く
nnoremap fc :Commits<CR>
"" }}}
" fern.vim{{{
nnoremap <silent><C-e> :Fern . -reveal=% -drawer -toggle -width=40<CR>
"nmap <buffer><nowait> V <Plug>(fern-action-open:side)

let g:fern#renderer = 'nerdfont'


augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END
"" }}}
