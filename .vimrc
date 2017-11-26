"=============================
"VIM-PLUG Manager:
"=============================

call plug#begin('~/.local/shared/nvim/plugged')
Plug 'tpope/vim-commentary'
Plug 'neomake/neomake'
Plug 'kien/ctrlp.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'eugen0329/vim-esearch'
Plug 'bronson/vim-trailing-whitespace'
Plug 'kassio/neoterm'
Plug 'janko-m/vim-test'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'fishbullet/deoplete-ruby', { 'for': 'ruby' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'
Plug 'tpope/vim-fugitive'
Plug 'tmhedberg/matchit'
Plug 'kana/vim-vspec'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'mklabs/split-term.vim'
call plug#end()

"=============================
"PLUGIN CONFIGURATIONS
"=============================
"Nvim-completion-manager:
"use <tab> to select the popup menu
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"FZF File Finder
map <leader>vv :FZF<cr>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
" note: access prev and next history with C-n and C-p
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_layout = { 'left': '~40%' }

"Vim-Search
"To switch between case-sensitive/insensitive, whole-word-match and
" regex/literal pattern in command line use <C-o><C-r>, <C-o><C-s> or <C-o><C-w>
" (mnemonics is set Option: Regex, case Sesnsitive, Word regex).
let g:esearch = {
    \ 'use': ['visual', 'hlsearch', 'last'],
    \}

"Neoterm
" Useful maps
" show/open terminal
nnoremap <leader>ty :call neoterm#open()<cr>
" hide/close terminal
nnoremap <leader>th :call neoterm#close()<cr>
" clear terminal
nnoremap <leader>tc :call neoterm#clear()<cr>
" kills the current job (send a <c-c>)
nnoremap <leader>tk :call neoterm#kill()<cr>
" Rails commands
command! Trspec :T bundle exec rspec
command! -nargs=+ Tspec :T bundle exec rspec <args>
command! Troutes :T bundle exec rake routes
command! -nargs=+ Troute :T bundle exec rake routes | grep <args>
command! Tmigrate :T bundle exec rake db:migrate
" Git commands
command! -nargs=+ Tg :T git <args>

"VIM-TEST
" make test commands execute in split window
let test#strategy = {
      \ 'nearest': 'basic',
      \ 'last': 'basic',
      \ 'file': 'basic',
      \ 'suite': 'basic'
      \}
" mappings for running and exiting specs
nmap <silent> <leader>tr :TestNearest<CR>
nmap <silent> <leader>te :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>

" DEOPLETE
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 0
let g:deoplete#enable_refresh_always = 1
" VIM NOTES
let g:notes_directories = ['/workspace/NOTES']

" SPLIT TERM
" mappings for switching buffers while in the neovim terminal
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

" NETRW FILE EXPLORER
" initial window size
let g:netrw_winsize = 50
" preview window as vertical split
let g:netrw_preview = 1
" let v option in right split
let g:netrw_altv = 1
" open file in last open buffer if possible, else create new window
let g:netrw_browse_split = 4
" toggle explorer
map <C-a>0 :Lexplore<cr>
" recursively delete non-empty directories
let g:netrw_localrmdir='rm -rf'
" open file vertically to the right
augroup netrw_mappings
    autocmd!
    autocmd filetype netrw call Netrw_mappings()
augroup END
function! Netrw_mappings()
    " moving cursor in and out of explorer
    nnoremap <buffer> <c-l> <c-w>l
endfunction

" NEOMAKE LINTER
" when writing a buffer
call neomake#configure#automake('w')
runtime macros/matchit.vim

"" ==============
"" CONFIGURATION SETTINGS
"" ===============

" Use Vim's native file explorer NETRW
filetype plugin on

set nocompatible
set mouse:a
set showcmd
set noerrorbells
set autoindent
set guifont=Inconsolata\ for\ Powerline:h15
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set termencoding=utf-8
set cursorline
set equalalways
set conceallevel=0
let g:vim_json_syntax_conceal = 0
set number
set smartindent
set autoindent
set shiftwidth=2
set tabstop=2
set expandtab
" <S-%> to jump between matching parens, etc
set showmatch

" HIGHLIGHTING
" Search Highlighting
" turned off by default
set nohlsearch
" toggle highlighting on and off
map <leader>hh :set hlsearch! hlsearch?<cr>

nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

"=========================
"YOUR CUSTOM MAPPINGS:
"=========================
"***SEE VIM KEY-NOTATION IN VIM HELP FOR HELP WITH VARIOUS KEY-CODES**

let mapleader = "\\"

"MOVING AROUND WINDOWS:
"Better window navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

"MOVING AROUND TABS:
map <C-e> :tabprevious<CR>
map <C-r>   :tabnext<CR>
map <C-t>     :tabnew<CR>

"CYCLING BETWEEN BUFFERS:
"Tab to go to the next buffer
nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
"Shift-Tab to go to the previous buffer
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>

"TOGGLE BUFFER TO FULL SCREEN
map <leader>fa :tab split<cr>
map <leader>fd :tab close<cr>

"SAVING AND QUITTING:
"Save all buffers
map <leader>sa :w<cr>:wincmd l<cr>:w<cr>:wincmd j<cr>:w<cr>:wincmd h<cr>:w<cr>:wincmd k<cr>
"Save current buffer
map <leader>s :FixWhitespace<cr>:w<cr>
"Save current buffer and quit
map <leader>wq :FixWhitespace<cr>:wq<cr>
"Quit current window without saving
map <leader>q :q<cr>
"Quit the grid view without saving
map <leader>qg :q!<cr>:q!<cr>:q!<cr>:q!<cr>
"Quit the grid view and save
map <leader>wg :wq<cr>:wq<cr>:wq<cr>:wq<cr>

"COPY TO CLIPBOARD
map <leader>c :w !pbcopy<cr>

"SHORTCUTS:
"Paste
map <leader>sp :set paste<cr>
map <leader>np :set nopaste<cr>

" BREAKING TEXT APART TO A NEW LINE
function! BreakHere()
    s/^\(\s*\)\(.\{-}\)\(\s*\)\(\%#\)\(\s*\)\(.*\)/\1\2\r\1\4\6
    call histdel("/", -1)
endfunction
nnoremap <C-Space> :<C-u>call BreakHere()<CR>

