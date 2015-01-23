" Execute pathogen
filetype off
 runtime /home/aj/.vim/autoload/pathogen.vim
execute pathogen#infect()
syntax on
filetype plugin indent on

" set the runtimepath variable - ~/vim_local should include the defaults
set runtimepath=~/vim_local,$VIMRUNTIME,~/.vim/l9,~/.vim/fuzzyfinder,~/.vim/vim-latex,/.vim/vim-over,/.vim/bundle/nerdtree,

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Switch off vi-compatibility mode
set nocompatible

" Switch on Wildmenu filename completion in bash-like mode
set wildmode=longest:full,full
set wildmenu

" Scary powerline thing
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

" Show status and tab bars and hide mode message (becasue powerline)
set ls=2
set showtabline=2
set noshowmode

" Set wordwrap for left/right
set ww=<,>,h,l

" Switch on ShowCommand
set sc

" Set crazy Enter-search-highlight thing
let g:highlighting = 0
function! Highlighting()
  if g:highlighting == 1 && @/ =~ '^\\<'.expand('<cword>').'\\>$'
    let g:highlighting = 0
    return ":silent nohlsearch\<CR>"
  endif
  let @/ = '\<'.expand('<cword>').'\>'
  let g:highlighting = 1
  return ":silent set hlsearch\<CR>"
endfunction
nnoremap <silent> <expr> <CR> Highlighting()
 
" Set up cache info thing - viminfo
set vi=%,'50
set vi+=\"100,:100
set vi+=n~/.viminfo

" show matching brackets
set showmatch

" Assume a dark background
set background=dark

" Set highlight searching, and CR to clear
"set hlsearch
"noremap <silent> <CR> :nohlsearch<CR>

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" fiddle with grep for the latex add-on and do a couple of formatting things
set grepprg=grep\ -nH\ $*
"filetype on
"filetype plugin on
"filetype indent on
"syntax on
let g:tex_flavor='latex'
" Compile with pdflatex by default
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats='pdf, aux'
" Disable conversion of " to `` etc. by latex-suite
let g:Tex_SmartKeyQuote = 0
" Set leader key
let mapleader = ","

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬,trail:.
set list

" Invisible character colors
highlight NonText guifg=#26262e
highlight SpecialKey guifg=#26262e

" Set line numbers on by default
set nu

" Relative line numbering
set relativenumber

" Map escape key to jj
imap jj <Esc>

" Highlight current line
set cursorline

" Yank from cursor to end of line, to be consistent with C and D
nnoremap Y y$

" Splits ,v to open a new vertical split and switch to it
nn <leader>v <C-w>v<C-w>l
nn <leader>h <C-w>s<C-w>l

" Change windows
nnoremap <C-h> <C-w>h
nn <C-j> <C-w>j
"nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Map spacebar to colon
nmap <space> :

" Bubble single lines
nmap <C-Up> ddkP
nmap <C-Down> ddp

" Bubble multiple lines
vmap <C-Up> xkP'[V']
vmap <C-Down> xp'[V']

" c&p from reddit about vim-over
nnoremap g/r :<c-u>OverCommandLine<cr>%s/
xnoremap g/r :<c-u>OverCommandLine<cr>%s/\%V

" Toggle spell checking on and off with `,s`
nmap <silent> <leader>s :set spell!<CR>

" Set British English as default
set spelllang=en_gb

" Set blowfish as the default encryption
set cm=blowfish

" Use the Ctrl+P plugin
set runtimepath^=~/.vim/bundle/ctrlp.vim
" Use the NERDTree plugin
set runtimepath^=~/.vim/bundle/nerdtree
map <C-a> :silent NERDTreeToggle<CR>:<BS>
" Use the Ctrl+P plugin
set runtimepath^=~/.vim/bundle/vim-fugitive
