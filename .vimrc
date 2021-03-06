"=============================
"VIM-PLUG Manager:
"=============================

call plug#begin('~/.local/shared/nvim/plugged')
"Syntax
Plug 'sheerun/vim-polyglot'

"Linters
Plug 'w0rp/ale'
" Plug 'neomake/neomake'

"Nerdtree
Plug 'scrooloose/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'tpope/vim-commentary'
Plug 'kien/ctrlp.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'eugen0329/vim-esearch'
Plug 'bronson/vim-trailing-whitespace'
Plug 'kassio/neoterm'
Plug 'janko-m/vim-test'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Ruby completion
Plug 'fishbullet/deoplete-ruby', { 'for': 'ruby' }
" Javascript completion
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
"Typescript completion
Plug 'mhartington/nvim-typescript'
Plug 'HerringtonDarkholme/yats.vim'
"Typscript navigation
"Plug 'Quramy/tsuquyomi'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}

"CTags Helpers
Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'

"Elixir support
Plug 'elixir-editors/vim-elixir'
Plug 'c-brenn/phoenix.vim'
Plug 'tpope/vim-projectionist'
Plug 'slashmili/alchemist.vim'

Plug 'matze/vim-move'
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

"Alchemist
let g:alchemist_tag_disable = 1

" Vim move bindings
let g:move_key_modifier = 'S'

"Nerdtree
"open filetree automatically if no file specified at launch
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"open the filetree
map <C-n> :NERDTreeToggle<CR>
"close vim if nerdtree is last window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"change the default arrows
let NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
"show hidden files by default
let NERDTreeShowHidden=1
" Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction
" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction
" Highlight currently open buffer in NERDTree
autocmd BufEnter * call SyncTree()
" Automaticallly delete the buffer of the file you just deleted in Nerdtree
let NERDTreeAutoDeleteBuffer = 1
" Remove press for help and other text
let NERDTreeMinimalUI = 1
" Prevent tab on Nerdtree buffer (breaks everything otherwise)
autocmd FileType nerdtree noremap <buffer> <Tab> <nop>
autocmd FileType nerdtree noremap <buffer> <leader><Tab> <nop>

"Tsuquyomi remappings
"nnoremap <C-[> :call tsuquyomi#goBack()<cr>

" Ale linter
" control alewarning hightlight color
highlight ALEWarning ctermbg=Red
" jump between errors quickly
nmap <silent> <leader>3 <Plug>(ale_previous_wrap)
nmap <silent> <leader>4 <Plug>(ale_next_wrap)

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
" autocmd! BufWritePost * Neomake
"call neomake#configure#automake('w')
" runtime macros/matchit.vim

"" ==============
"" CONFIGURATION SETTINGS
"" ===============

" Automatically execute ctags each time a file is saved
" autocmd BufWritePost * call system("ctags -R")
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_missing = 1
" Display indicator of tag generation progress in status line
" set statusline+=%{gutentags#statusline()}
" Generate Ctags
noremap <leader>r call system("ctags -R")<cr>

" Gutentags
" Send tag files to a separate directory
" So as to not pollute the working directory
let g:gutentags_cache_dir = '~/.git/tags'

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
map <leader>1 :tabprevious<CR>
map <leader>2   :tabnext<CR>
map <leader>t     :tabnew<CR>

"CYCLING BETWEEN BUFFERS:
"Tab to go to the next buffer
nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
"Shift-Tab to go to the previous buffer
nnoremap  <silent> <leader><tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>

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

