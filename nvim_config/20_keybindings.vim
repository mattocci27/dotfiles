" keybinding

"yank to system clipboard
vnoremap <y> "+y
vnoremap <d> "+d

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

nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H

"autocomplete for {} ()
"inoremap { {}<Left>
"inoremap {<Enter> {}<Left><CR><ESC><S-o>
"inoremap ( ()<ESC>i
"inoremap (<Enter> ()<Left><CR><ESC><S-o>
inoremap <silent> jj <ESC>

" j/k for displayed line
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk

set backspace=indent,eol,start "enable delete key
let mapleader = "\<space>"

"copy one line
noremap <leader>v 0v$h
noremap <leader>o :<c-p> <cr>
noremap <leader>w :w <CR>


" vv to generate new vertical split
nnoremap <silent> vv <C-w>v

" new tab
nnoremap <C-c> :tabclose<CR>
nnoremap <C-n> :tabnew<CR>
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>


"md preview
nmap <C-s> <Plug>MarkdownPreview
nmap <M-s> <Plug>MarkdownPreviewStop
nmap <C-p> <Plug>MarkdownPreviewToggle
