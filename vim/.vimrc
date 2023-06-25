filetype plugin indent on    " required

" Use space as <mapleader> key
:let mapleader = " "
nnoremap <space> <nop>

" Basic settings
syntax enable		" Active la coloration syntaxique
set mouse=a			" Permet d'utiliser la souris
set title			" Met a jour le titre du terminal
set ruler			" Affiche la position actuelle du curseur
set wrap			" Affiche les lignes trop longues sur plusieur lignes
set linebreak		" Ne coupe pas les mots
set scrolloff=5		" Affiche un minimum de 5 lignes autour du curseur
set shiftwidth=4	" Regle les tabulations automatiques sur 4 espaces
set tabstop=4		" Regle l'affichage des tabulations sur 4 espaces
set background=dark	" Utilise des couleurs adaptees pour fond noir
set laststatus=2	" Affiche la bar de status
set cc=80			" Change la couleur de fond a 80 colonnes
set showcmd			" Affiche les commandes incompletes
set wildmenu		" Show autocompletion possibles
set noshowmode		" Dont show -- INSERT --, -- VISUAL -- whene changing mode
set backspace=2
set re=0
set wildmode=longest,list,full
set wildmenu
set listchars=space:.,tab:▸\ ,eol:¬ " Set list set nolist nice caracteres
set cursorlineopt=screenline

" Set clipboard to system clipboard
if system('uname -s') == "Darwin\n"
  set clipboard=unnamed "OSX
else
  set clipboard=unnamedplus "Linux
endif

" Colorscheme
colorscheme onedark
function! AdaptColorscheme()
   " highlight clear CursorLine
   highlight Normal ctermbg=none
   highlight LineNr ctermbg=none
   highlight Folded ctermbg=none
   highlight NonText ctermbg=none
   highlight SpecialKey ctermbg=none
   highlight VertSplit ctermbg=none
   highlight SignColumn ctermbg=none
endfunction

autocmd ColorScheme * call AdaptColorscheme()

" Search
set ignorecase		" Ignore la casse lors d'une recherche
set smartcase		" Sauf si la recherche contient une majuscule
set incsearch		" Surligne le resultat pendant la saisie

" Disable beep
set vb t_vb=

set hidden " Hide a buffer instead of showing error when opening a new file

" Raccourci pour passer la numérotation en mode relative "
nnoremap <leader>N :set relativenumber!<cr>
nnoremap <leader>n :set number!<cr>

" Do not create swapfiles
:set noswapfile

" Macro in visual range
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
	echo "@".getcmdline()
	execute ":'<,'>normal @".nr2char(getchar())
endfunction

" Netrw
let g:netrw_banner=0		" disable annoying banner
let g:netrw_liststyle=3		" tree view
let g:netrw_winsize=15
let g:netrw_preview=1

nnoremap <leader>l :Lex<cr>

" Goyo
:nnoremap <leader>g <esc>:Goyo<cr>

let g:goyo_width=120
let g:goyo_height="80%"

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

function! s:goyo_enter()
	if executable('tmux') && strlen($TMUX)
		silent !tmux set status off
		silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
	endif
	set noshowmode
	set noshowcmd
	set scrolloff=999
endfunction

function! s:goyo_leave()
	if executable('tmux') && strlen($TMUX)
		silent !tmux set status off
		silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
	endif
	set showmode
	set showcmd
	set scrolloff=5
	" Set colorscheme
	" silent! colorscheme onedark
	" Make it transparent
	hi Normal guibg=NONE ctermbg=NONE
endfunction

" Vimtex
let g:vimtex_compiler_latexmk = {'callback' : 0}
"setlocal keywordprg=texdoc				" Make K work with tex documentation

" Neovim

" Use escape to get out insert-mode in terminal
if has('nvim')
	:tnoremap <Esc> <C-\><C-n>
endif

" Use Alt-[hjkl] to move around splits
if has('nvim')
	:tnoremap <A-h> <C-\><C-N><C-w>h
	:tnoremap <A-j> <C-\><C-N><C-w>j
	:tnoremap <A-k> <C-\><C-N><C-w>k
	:tnoremap <A-l> <C-\><C-N><C-w>l
endif
:inoremap <A-h> <C-\><C-N><C-w>h
:inoremap <A-j> <C-\><C-N><C-w>j
:inoremap <A-k> <C-\><C-N><C-w>k
:inoremap <A-l> <C-\><C-N><C-w>l
:nnoremap <A-h> <C-w>h
:nnoremap <A-j> <C-w>j
:nnoremap <A-k> <C-w>k
:nnoremap <A-l> <C-w>l

" Use <alt-j> and <alt-k> to change tab
:nnoremap <C-j> gT
:nnoremap <C-k> gt

" Let Vim say something nice at startup
autocmd VimEnter * echo system('curl -s https://zenquotes.io/api/random | jq -j ".[]|.q,.a"')
" Open and source vimrc
:nnoremap <leader>ev :vs $HOME/.vimrc<cr>
:nnoremap <leader>sv :so $MYVIMRC<cr>

" FZF
:nnoremap <leader>ef :Files<cr>
:nnoremap <leader>rg :Rg<cr>

" Open the previous buffer when delete one
:command! Bd bp\|bd \#

" Real vim terminal
set splitbelow

" Change in next parenthese
onoremap in( :<c-u>normal! f(vi(<cr>
" Change in previous parenthese
onoremap il( :<c-u>normal! F)vi(<cr>
" Change around next parenthese
onoremap an( :<c-u>normal! f(va(<cr>
" Change around previous parenthese
onoremap al( :<c-u>normal! F)va(<cr>

" Change in next square brackets
onoremap in[ :<c-u>normal! f[vi[<cr>
" Change in previous square brackets
onoremap il[ :<c-u>normal! F]vi[<cr>
" Change around next square brackets
onoremap an[ :<c-u>normal! f[va[<cr>
" Change around previous square brackets
onoremap al[ :<c-u>normal! F]va[<cr>

" Change in next simple quote
onoremap in" :<c-u>normal! f'vi'<cr>
" Change in previous simple quote
onoremap il" :<c-u>normal! F'vi'<cr>
" Change around next simple quote
onoremap an" :<c-u>normal! f'va'<cr>
" Change around previous simple quote
onoremap al" :<c-u>normal! F'va'<cr>

" Change in next double quote
onoremap in" :<c-u>normal! f"vi"<cr>
" Change in previous double quote
onoremap il" :<c-u>normal! F"vi"<cr>
" Change around next double quote
onoremap an" :<c-u>normal! f"va"<cr>
" Change around previous double quote
onoremap al" :<c-u>normal! F"va"<cr>

" Change in next curly brackets
onoremap in{ :<c-u>normal! f{vi{<cr>
" Change in previous curly brackets
onoremap il{ :<c-u>normal! F}vi{<cr>
" Change around next curly brackets
onoremap an{ :<c-u>normal! f{va{<cr>
" Change around previous curly brackets
onoremap al{ :<c-u>normal! F}va{<cr>

onoremap ih :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rkvg_"<cr>
onoremap ah :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rg_vk0"<cr>

" The cross
nnoremap <leader>c :set cursorline! cursorcolumn!<cr>

" Vim-go
let g:go_fmt_command="gopls"
let g:go_gopls_gofumpt=1

" Rust
let g:syntastic_rust_checkers = ['cargo']
let g:rustfmt_autosave = 1
nmap <leader>tb :TagbarToggle<CR>

" Html
autocmd FileType html :setlocal nowrap
" Javascript
autocmd FileType javascript vue set expandtab shiftwidth=2
" Xml
autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

let g:coc_global_extensions = [
			\ 'coc-python',
			\ 'coc-json',
			\ 'coc-rust-analyzer',
			\ 'coc-tsserver',
			\ ]

" use <tab> to trigger completion and navigate to the next complete item
function! CheckBackspace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
			\ coc#pum#visible() ? coc#pum#next(1) :
			\ CheckBackspace() ? "\<Tab>" :
			\ coc#refresh()

" Right indentation for yaml files
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Avoid autoindent on comments
:set indentkeys-=0#
autocmd BufNewFile,BufReadPost * if &filetype == "python" | set indentkeys-=0# | endif
autocmd BufNewFile,BufReadPost * if &filetype == "yaml" | set expandtab shiftwidth=2 indentkeys-=0# | endif

" Map <C-s> to save, on mac add \<C-s> keybinding to iterm2 to use command-s
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <Esc>:update<CR>

" Manage set paste
function! WrapForTmux(s)
	if !exists('$TMUX')
		return a:s
	endif

	let tmux_start = "\<Esc>Ptmux;"
	let tmux_end = "\<Esc>\\"

	return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
	set pastetoggle=<Esc>[201~
	set paste
	return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

"------------------------------------ Undo -------------------------------------
nnoremap <leader>u :UndotreeToggle<CR>

let g:undotree_WindowLayout = 2
let g:undotree_ShortIndicators = 1
let g:undotree_DiffpanelHeight = 10
let g:undotree_DiffCommand = "vimdiff"

" Set focus to undo tree when toggling
let g:undotree_SetFocusWhenToggle = 1

if has("persistent_undo")
	let target_path = expand('~/.undodir')

	if !isdirectory(target_path)
		call mkdir(target_path, "p", 0700)
	endif

	let &undodir=target_path
	set undofile

endif
