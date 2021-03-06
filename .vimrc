" vim:fdm=marker:
" General startup stuff {{{1
colorscheme slate
set nocp "non-compatibility mode to make pathogen happy
execute pathogen#infect()
syntax on
filetype plugin indent on
Helptags

" Set .page files as type 'pandoc'
autocmd BufNewFile,BufRead *.page set filetype=pandoc
" conflict between snipmate and tabbing out of brackets?

" Switch off vi-compatibility mode
set nocompatible

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Set tabs to equal four spaces when editing markdown/pandoc files
autocmd FileType markdown setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType pandoc setlocal ts=4 sts=4 sw=4 expandtab

" Include bibtags file in dictionary completion when editing markdown/pandoc
" files
autocmd FileType markdown setlocal iskeyword+=@-@
autocmd FileType markdown setlocal dictionary+=/home/aj/phd/citations/bibtags
autocmd FileType pandoc setlocal iskeyword+=@-@
autocmd FileType pandoc setlocal dictionary+=/home/aj/phd/citations/bibtags

" Remap @@ to trigger bib dictionary completion when editing markdown/pandoc
" files
autocmd FileType markdown imap @@ @<C-x><C-k>
autocmd FileType pandoc imap @@ @<C-x><C-k>

" Remap @<space> to trigger bib dictionary completion after typing some
" characters e.g. @coh@<space> when editing markdown/pandoc files
autocmd FileType markdown imap @<space> <C-x><C-k>
autocmd FileType pandoc imap @<space> <C-x><C-k>

" Set up cache info thing - viminfo
set vi=%,'50
set vi+=\"100,:100
set vi+=n~/.viminfo

" Yank from cursor to end of line, to be consistent with C and D
nnoremap Y y$

" Set British English as default and location of words file
set spelllang=en_gb
set dictionary-=/usr/share/dict/words dictionary+=/usr/share/dict/words

" Set shortcuts for thesaurus plugin
nnoremap <leader>t :ThesaurusQueryReplaceCurrentWord<CR>
inoremap <C-t> <C-o>:ThesaurusQueryReplaceCurrentWord<CR>


" Set blowfish as the default encryption
set cm=blowfish

" Screen stuff {{{1
" Statusbar stuff {{{2
set laststatus=2
set cursorline

" Switch on ShowCommand
set sc

" General display stuff {{{2
" Switch on Wildmenu filename completion in bash-like mode
set wildmode=longest:full,full
set wildmenu

" Set wordwrap for left/right
set ww=<,>,h,l

" Non-breaking wordwrap
set wrap linebreak nolist

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬,trail:.
" Needs 'set list' to show up - toggle with <leader>l

" Invisible character colors
highlight NonText guifg=#26262e
highlight SpecialKey guifg=#26262e

" Set line numbers on by default
set nu

" Relative line numbering
set relativenumber

" Highlight current line
set cursorline

" Keep current line centered
set so=99

" Show matching brackets
set showmatch

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

" Remaps {{{1
" Global importance {{{2
" Set leader key to comma
let mapleader = ","

" Map escape key to jj
imap jj <Esc>

" Map spacebar to colon
nmap <space> :

" Lose 'Line-Undo' to remap redo <C-r> to U
nnoremap U <C-r>

" Home/End/TOS/BOS/join/search man remaps
nnoremap H 0
nnoremap L $
nnoremap J L
nnoremap K H
nnoremap + J
nnoremap - K

" Quicksave & quit
imap zzz <ESC>:x<CR>

" Allow saving of files as sudo when I forgot to start vim using sudo
cmap w!! w !sudo tee > /dev/null %

" Leader maps {{{2
" Toggle spell checking on and off with `,s`
nmap <silent> <leader>s :set spell!<CR>

" Quickly open/close .vimrc without saving
function! Openrc()
	let current_file = expand('%:p')
	if current_file == '/home/aj/.vimrc'
		":w
		:bd!
	else
		:e ~/.vimrc
	endif
endfunction
nmap <leader>rc :call Openrc()<CR>

" Quickly open/close cheat-sheet
function! Cheatsheet()
	let current_file = expand('%:p')
	if current_file == '/home/aj/.cheat-sheet'
		:w
		:bd
	else
		:e ~/.cheat-sheet
	endif
endfunction
nmap <leader>cs :call Cheatsheet()<CR>

" Quickly open/close notepad file
function! Notepad()
	let current_file = expand('%:p')
	if current_file == '/home/aj/notepad'
		:w
		:bd
	else
		:e ~/notepad
	endif
endfunction
nmap <leader>, :call Notepad()<CR>

" Cut, copy, paste remaps
nnoremap <leader>d "+d
nnoremap <leader>y "+y
nnoremap <leader>p :set paste<CR>"+gp:set nopaste<CR>
nnoremap <leader>P :set paste<CR>"+gP:set nopaste<CR>
vnoremap <leader>d "+d
vnoremap <leader>y "+y
vnoremap <leader>p <ESC><ESC>:set paste<CR>gv"+p:set nopaste<CR>
vnoremap <leader>P <ESC><ESC>:set paste<CR>gv"+P:set nopaste<CR>
inoremap <Leader>p <ESC>:set paste<CR>"+gp:set nopaste<CR>a
inoremap <Leader>P <ESC>:set paste<CR>"+gp:set nopaste<CR>i


" Move between buffers
nnoremap <leader>. :bn<CR>
nnoremap <leader>m :bp<CR>
nnoremap <leader>k <C-^>

" Clear all buffers
nnoremap <leader>bd :bd *<C-a><CR><CR>

" Splits ,v or ,h to open a new vertical or horizontal split and switch to it
nn <leader>v <C-w>v<C-w>l
nn <leader>h <C-w>s<C-w>l

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Copy to clipboard
nnoremap <leader>z gg"+yG " whole buffer
nnoremap <leader>x 0"+y$ " line
nnoremap <leader>c "+y

" Generate pdf
" nnoremap <leader>df :w<CR>:silent !pandoc % --smart -o '%:r'.pdf<CR>:redraw!<CR>
" nnoremap <leader>ddf :w<CR>:silent !pandoc --smart --template=/home/aj/.vim/pandoc-templates/ajpdf --latex-engine=xelatex % --smart -o '%:r'.pdf<CR>:redraw!<CR>

function! Makepdf()
	let file_loc = fnamemodify(expand('%'), ":p:h:h")
	if match(file_loc,'/home/aj/phd') == 0
		let output = "/home/aj/phd/output/" . expand('%:t:r') . ".pdf"
		:w
"		execute 'silent !pandoc --from markdown+subscript % --smart --bibliography=/home/aj/phd/citations/bib.bib --latex-engine=xelatex -o ' . output
		execute 'silent !cat /home/aj/phd/.header.mkd % /home/aj/phd/.footer.mkd | pandoc --from markdown+subscript --smart --bibliography=/home/aj/phd/citations/bib.bib --latex-engine=xelatex -o ' . output
		execute 'redraw!'
	else
		:w
		execute 'silent !pandoc % --smart -o ' . expand('%:r') . '.pdf'
		execute 'redraw!'
	endif
endfunction

nnoremap <leader>df :call Makepdf()<CR>

function! Makepdfaj()
	let file_loc = fnamemodify(expand('%'), ":p:h:h")
	if match(file_loc,'/home/aj/phd') == 0
		let output = "/home/aj/phd/output/" . expand('%:t:r') . ".pdf"
		:w
"		execute 'silent !pandoc --smart --template=/home/aj/phd/styles/ajpdf --bibliography=/home/aj/phd/citations/bib.bib --latex-engine=xelatex % -o ' . output
		execute 'silent !cat /home/aj/phd/.header.mkd % /home/aj/phd/.footer.mkd | pandoc --from markdown+subscript --smart --template=/home/aj/phd/styles/ajpdf --bibliography=/home/aj/phd/citations/bib.bib --latex-engine=xelatex -o ' . output
		execute 'redraw!'
	else
		:w
		execute 'silent !pandoc --smart --template=/home/aj/.vim/pandoc-templates/ajpdf --latex-engine=xelatex % -o ' . expand('%:r') . '.pdf'
		execute 'redraw!'
	endif
endfunction

nnoremap <leader>ddf :call Makepdfaj()<CR>

" Display current jumplist
function! GotoJump()
	jumps
	let j = input("Please select your jump: ")
	if j != ''
		let pattern = '\v\c^\+'
		if j =~ pattern
			let j = substitute(j, pattern, '', 'g')
			execute "normal " . j . "\<c-i>"
		else
			execute "normal " . j . "\<c-o>"
		endif
	endif
endfunction

nmap <Leader>j :call GotoJump()<CR>
" Window {{{2
" Change windows
nnoremap <C-h> <C-w>h
nn <C-j> <C-w>j
"nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


" Bubbles! {{{2
" Bubble single lines
nmap <C-Up> ddkP
nmap <C-Down> ddp

" Bubble multiple lines
vmap <C-Up> xkP'[V']
vmap <C-Down> xp'[V']

" Macros {{{2

" Split line at next full-stop
nmap - f.lr<CR>
" Replace opening/closing quote marks - added 'e' to ignore errors
nmap _ :%s/“/"/ge<CR>:%s/”/"/ge<CR>:%s/‘/'/ge<CR>:%s/’/'/ge<CR>

" TODO: macro to remove all line breaks, then change all full-stops with
" full-stop<CR> -- to be used after c&p from pdf etc.
" Brackets {{{2
imap { {}<left>
imap [ []<left>
imap ( ()<left>
inoremap " ""<left>

" Use Tab to traverse closing brackets
function! TabOut()
	let current_char = getline('.')[col('.')-1]
	if match(current_char,')\|"\|]\|}') == 0
"		call cursor(line('.'),col('.')+1)
		if col('.') == col("$")-1
"			:execute "normal! a\ Monkey!"
			:startinsert!
		else
"			:execute "normal! a\ Monkey2!"
			:call cursor(line('.'),col('.')+1)
			:startinsert
		endif
	else
		inoremap <tab> <tab>
		if col('.') == col("$")-1
			:normal A	
			:startinsert!
		elseif col('.') == 1
			:normal i	
		else
			:normal i	
			call cursor(line('.'),col('.')+1)
			:startinsert
		endif
		inoremap <tab> <C-o>:call TabOut()<CR>
	endif
endfunction
inoremap <tab> <C-o>:call TabOut()<CR>
"*****nmap <tab> <tab>
" Snipmate may cause a conflict with TabOut() - edit
"/home/aj/.vim/bundle/snipmate.vim/after/plugin/snipMate.vim and
"change ino <tab> <c-r>=TriggerSnippet()<cr> and
"snor <tab> <esc>i<right><c-r>=TriggerSnippet()<cr>
"to ino <c-j> <c-r>=TriggerSnippet()<cr> and 
"snor <c-j> <esc>i<right><c-r>=TriggerSnippet()<cr>

" Use Enter to traverse closing brackets
function! EnterOut()
	let current_char = getline('.')[col('.')-1]
	if match(current_char,')\|"\|\]\|}') == 0
"		call cursor(line('.'),col('.')+2)
		if col('.') == 1
			:execute "normal! i\n"
			:startinsert
		elseif col('.') == col("$")-1
			:execute "normal! a\ "
			:startinsert!
		else
			:execute "normal! a\ "
			call cursor(line('.'),col('.')+1)
			:startinsert
		endif
	else
		inoremap <ENTER> <ENTER>
		if col('.') == col("$")-1
			:execute "normal! a\n"
			:startinsert!
		elseif col('.') == 1
			:execute "normal! i\n"
			:startinsert
		else
"			call cursor(line('.'),col('.'))
			:execute "normal! i\n"
"			call cursor(line('.'),col('.')+1)
			:startinsert
		endif
		inoremap <ENTER> <C-o>:call EnterOut()<CR>
	endif
endfunction
inoremap <ENTER> <C-o>:call EnterOut()<CR>
" Commands {{{1
" Create a .page file for citations
command! -nargs=1 Cite wincmd l|wincmd k|:e /home/aj/phd/citations/<args>.page

" Update bib.bib file
command! Makebib execute 'silent !sh ~/phd/.makebib.sh'|redraw!

" Edit header file
command! EditHeader wincmd l|wincmd j|:e /home/aj/phd/.header.mkd

" Open pdf output
function! OpenPDF()
	let file_loc = fnamemodify(expand('%'), ":p:h:h")
	if match(file_loc,'/home/aj/phd') == 0
		let output = "/home/aj/phd/output/" . expand('%:t:r') . ".pdf"
		execute 'silent !evince ' . output ' > /dev/null 2>&1 &'
		redraw!
	else
		execute 'silent !evince ' . expand('%:r') . '.pdf > /dev/null 2>&1 &'
	endif
endfunction

" Trigger this function from a command
command! OpenPDF call OpenPDF()

" Add ActionPoint to minutes
command! -nargs=* AA execute 'normal!o'|execute 'normal!o**ACTION: <args>.**'|execute 'normal!o'

" Email Sallies Minutes
function! EmailMinutes() 

	execute 'silent call Makepdfaj()'
	let mytime = strftime("%d/%m/%Y") 
	execute 'silent !echo | mail -s "Meeting minutes ' . mytime . '" -a ' . expand('%:r') . '.pdf sswarden@st-andrews.ac.uk,aw201@st-andrews.ac.uk,jk86@st-andrews.ac.uk,kc347@st-andrews.ac.uk'
	execute 'redraw!'
endfunction

" Trigger this function from a command
command! EmailMinutes execute 'silent call EmailMinutes()'

" Demo Email Minutes
function! DemoEmailMinutes() 

	execute 'silent call Makepdfaj()'
	let mytime = strftime("%d/%m/%Y") 
	execute 'silent !echo | mail -s "Demo meeting minutes ' . mytime . '" -a ' . expand('%:r') . '.pdf ah21@st-andrews.ac.uk'
	execute 'redraw!'
endfunction

" Trigger this function from a command
command! DemoEmailMinutes execute 'silent call DemoEmailMinutes()'

" Join all lines, make all sentence-breaks one space, then insert linebreaks
function! MagicReformat()
	%j
	%s/\.  /\. /g
	%s/\. /\.\r/g
endfunc

" Trigger this function from a command
command! MagicReformat call MagicReformat()

" Extensions {{{1
" Airline - tab support and powerline fonts
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
"let g:airline_section_c = 

" Clean up airline / vim-bufferline printing to statusbar
let g:bufferline_echo = 0

" gundo remap
nnoremap <F5> :GundoToggle<CR>

" vimroom remap
nnoremap <Leader>vr :VimroomToggle<CR>

" Fiddle with grep for the latex add-on and do a couple of formatting things
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

" Trigger overcommandline
nnoremap <Leader>o :OverCommandLine<cr>%s/

" Fuzzy finder remaps
nmap ,f :FufFileWithCurrentBufferDir<CR>
nmap ,b :FufBuffer<CR>
