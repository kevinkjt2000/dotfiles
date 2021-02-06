let mapleader=","  " <leader> is ,

" Running tests
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>

" Move lines down and up with A-j and A-k
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Match ctags in a case sensitive manner when using C-]
fun! MatchCaseTag()
	let ic = &ic
	set noignorecase
	try
		exe 'tjump ' . expand('<cword>')
	finally
		let &ic = ic
	endtry
endfun
nnoremap <silent><C-]> :call MatchCaseTag()<CR>

" For Python files call flake 8 with F7
autocmd FileType python map <buffer> <F7> :call Flake8()<CR>

" Some helpful shortcuts for C++ GDB
autocmd FileType cpp map <buffer> <leader>d :GdbLocal confloc#me a.out ""<CR>
autocmd FileType cpp map <buffer> <leader>b :GdbToggleBreak<CR><CR>

" Bind tab to ultisnip expansion
let g:UltiSnipsExpandTrigger="<tab>"

" Toggle hiding whitespace characters
map <leader>i :set list!<CR>

" Turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" Switch to alternate file using tpope/vim-projectionist
nnoremap <leader>a :A<CR>

" Save file with leader w
nnoremap <leader>w :w<CR>

" Swap between the current buffer and the last buffer
nnoremap <leader><leader> <C-^>

" Change CtrlP to open with <leader>f instead
let g:ctrlp_map = '<leader>f'
" Open CtrlP in buffer mode with <leader>b
nnoremap <leader>b :CtrlPBuffer<CR>

" Spacebar open/closes folds
nnoremap <space> za

" Move vertically by visual line
nnoremap j gj
nnoremap k gk

" Toggle gundo
nnoremap <leader>u :GundoToggle<CR>

" jk is escape
inoremap jk <esc>

if has('nvim')
	" Make terminal mode escape actually be <Esc>
	tnoremap <Esc> <C-\><C-n>
endif

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
