""
"" Customisations
""
let g:indent_guides_auto_colors = 0
let g:multi_cursor_use_default_mapping=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgrey

set mouse:a
set showcmd
set noerrorbells
set showmatch
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

" Search Highlighting
" turn on by default
set nohlsearch
" toggle highlighting on and off
map <leader>hh :set hlsearch! hlsearch?<CR>

nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

"=========================
"YOUR CUSTOM MAPPINGS:
"=========================
"***SEE VIM KEY-NOTATION IN VIM HELP FOR HELP WITH VARIOUS KEY-CODES**

let mapleader = "\\"

"WINDOW MANAGEMENT:
"Toggle NerdTree
map <leader>n :NERDTreeToggle<CR>
"Open with grid layout view
map <leader>4 :q<cr>:vsplit<cr>:split<cr>:wincmd l<cr>:split<cr>:wincmd h<cr>
"Open with 2 windows horizontally split
map <leader>h :q<cr>:split<cr>
"Close two of four panes and split windows horizontally
map <leader>v :wincmd j<cr>:q<cr>:wincmd l<cr>:wincmd j<cr>:q<cr>

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

"MOVING AROUND BUFFERS:
"Tab to go to the next buffer
nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
"Shit-Tab to go to the previous buffer
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>

"TOGGLE BUFFER TO FULL SCREEN
map <leader>fa :tab split<cr>
map <leader>fd :tab close<cr>

"OPENING FILES:
" Opens a new tab with the current buffer's path
" " Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

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
"FixWhitespace
" map <leader>fw :FixWhitespace<cr>
"Paste
map <leader>sp :set paste<cr>
map <leader>np :set nopaste<cr>
"map <leader>ff mzgg=G`z<cr>

"CTAGS
"Tag all source files and save in .git directory
map <leader>st :ctags -R -f ./.git/tags .<cr>

"============================
"VIM STUFF:
"============================

if filereadable(expand("~/.vimrc.before"))
	source ~/.vimrc.before
endif

"=============================
"PLUGIN CONFIGURATIONS
"=============================
"Nvim-completion-manager:
"use <tab> to select the popup menu
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"FZF File Finder
map <leader>zz :FZF<cr>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

"Vim-Search
let g:esearch = {
    \ 'use': ['visual', 'hlsearch', 'last'],
    \}

"Neoterm
let g:neoterm_position = 'horizontal'
let g:neoterm_automap_keys = ',tt'
" Useful maps
" show/open terminal
nnoremap <silent> ,ty :call neoterm#open()<cr>
" hide/close terminal
nnoremap <silent> ,th :call neoterm#close()<cr>
" clear terminal
nnoremap <silent> ,tl :call neoterm#clear()<cr>
" kills the current job (send a <c-c>)
nnoremap <silent> ,tc :call neoterm#kill()<cr>
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

" VIM NOTES
let g:notes_directories = ['/workspace/NOTES']

"=============================
"VIM-PLUG Manager:
"=============================

call plug#begin('~/.local/shared/nvim/plugged')
Plug 'tpope/vim-commentary'
Plug 'neomake/neomake'
Plug 'kien/ctrlp.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
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
call plug#end()

"NeoMake linter
" when writing a buffer
call neomake#configure#automake('w')

runtime macros/matchit.vim
