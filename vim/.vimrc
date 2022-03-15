call plug#begin()

Plug 'vim-syntastic/syntastic'			" Avoid simple mistakes of syntax
"Plug 'ekalinin/Dockerfile.vim'			" syntax for Dockerfiles
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'				" git plugin
Plug 'tpope/vim-commentary'				" Comment plugin
Plug 'junegunn/goyo.vim'				" Distraction free plugin
"Plug 'sheerun/vim-polyglot'				" Better syntax
"Plug 'flazz/vim-colorschemes'			" Colorshchemes collection
Plug 'joshdick/onedark.vim'				" Onedark colorscheme
"Plug 'felixhummel/setcolors.vim'		" Colorshchemes tester
Plug 'itchyny/lightline.vim'			" Airline manager
"Plug 'brookhong/cscope.vim'				" Cscope plugin
"Plug 'pandark/42header.vim'				" 42 Header pk style
Plug 'ap/vim-css-color'					" Css colors show in code
"Plug 'valloric/youcompleteme'			" Autocompletion plugin
"Plug 'lervag/vimtex'					" Latex plugin
"Plug 'mbbill/undotree'					" Undo tree
"Plug 'rhysd/vim-grammarous'             " Autocorrect
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'deoplete-plugins/deoplete-clang'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'airblade/vim-gitgutter'			" Git plugin 
Plug 'posva/vim-vue'					" Vue

Plug 'blindFS/vim-translator', { 'mappings' : '<Plug>Translate' }	" translator
Plug 'jparise/vim-graphql'				" GraphQL syntax
"Plug 'karb94/neoscroll.nvim'			" Smooth scroll
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Initialize plugin system
call plug#end()

filetype plugin indent on    " required

" Use space as <mapleader> key
:let mapleader = " "
nnoremap <space> <nop>

"-------------------------------- AFFICHAGE ----------------------------------

syntax enable		" Active la coloration syntaxique
set mouse=a			" Permet d'utiliser la souris
set title			" Met a jour le titre du terminal
"set number			" Affiche le numero de ligne
set ruler			" Affiche la position actuelle du curseur
set wrap			" Affiche les lignes trop longues sur plusieur lignes
set linebreak		" Ne coupe pas les mots
set scrolloff=5		" Affiche un minimum de 5 lignes autour du curseur
set shiftwidth=4	" Regle les tabulations automatiques sur 4 espaces
set tabstop=4		" Regle l'affichage des tabulations sur 4 espaces
set background=dark	" Utilise des couleurs adaptees pour fond noir
"set splitright		" Ouvre les verticalsplit sur la droite
set laststatus=2	" Affiche la bar de status
set cc=80			" Change la couleur de fond a 80 colonnes
set showcmd			" Affiche les commandes incompletes
set wildmenu		" Show autocompletion possibles
set noshowmode		" Dont show -- INSERT --, -- VISUAL -- whene changing mode
set backspace=2

" Set list set nolist nice caracteres
set listchars=space:.,tab:▸\ ,eol:¬
"set cursorline
"set cursorcolumn

" Set colorscheme
silent! colorscheme onedark
" Make it transparent
hi Normal guibg=NONE ctermbg=NONE

"-------------------------------- RECHERCHE ----------------------------------

set ignorecase		" Ignore la casse lors d'une recherche
set smartcase		" Sauf si la recherche contient une majuscule
set incsearch		" Surligne le resultat pendant la saisie

"---------------------------------- Beep -------------------------------------

set vb t_vb=		" Empeche vim de beeper

" Hide a buffer instead of showing error when opening a new file
set hidden

" Deactivate arrowkeys
"noremap <up> <nop>
"noremap <down> <nop>
"noremap <left> <nop>
"noremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>

" Deactivate backspace
"inoremap <backspace> <nop>
"cnoremap <backspace> <nop>

"------------------------------- FUNCTIONS -----------------------------------

" Raccourci pour passer la numérotation en mode relative "
nnoremap <leader>N :set relativenumber!<cr>
nnoremap <leader>n :set number!<cr>

" Raccourci clavier pour pouvoir coller du code sans problemes
"nnoremap <C-l> :set paste! <cr>

" from 90% without plugins
"set path+=** " not so good idea !

" Shortcut to recursivly make tags
command! Mt !ctags -R .

" Remove all .DS_Store under the current directory
command! Dstore !rm $(find . -name ".DS_Store" 2>/dev/null)

" Do not create swapfiles
:set noswapfile

" Open multiple tab from vim
command! -complete=file -nargs=* Tabe call Tabe(<f-args>)
function! Tabe(...)
	let t = tabpagenr()
	let i = 0
	for f in a:000
		for g in glob(f, 0, 1)
			exe "tabe " . fnameescape(g)
			let i = i + 1
		endfor
	endfor
	if i
		exe "tabn " . (t + 1)
	endif
endfunction

" Macro in visual range
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
	echo "@".getcmdline()
	execute ":'<,'>normal @".nr2char(getchar())
endfunction

"-------------------------------- NETRW --------------------------------------

" Faire de netrw quelquechose de classe (pas au point)
let g:netrw_banner=0		" disable annoying banner
let g:netrw_liststyle=3		" tree view
let g:netrw_winsize=15
let g:netrw_preview=1

nnoremap <leader>l :Lex<cr>

"-------------------------------- AIRLINE -------------------------------------

let g:lightline = {
			\ 'colorscheme': 'darcula',
			\ }

"--------------------------------- GOYO ---------------------------------------

" Goyo shortcut
:nnoremap <leader>g <esc>:Goyo<cr>

let g:goyo_width=120
let g:goyo_height="80%"

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
	silent! colorscheme onedark
	" Make it transparent
	hi Normal guibg=NONE ctermbg=NONE

	" ...
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

"------------------------------- Polyglot -------------------------------------
"let g:polyglot_disabled = ['latex']		" Disable Latex for vimtex

"-------------------------------- Vimtex --------------------------------------
let g:vimtex_compiler_latexmk = {'callback' : 0}
"setlocal keywordprg=texdoc				" Make K work with tex documentation

"-------------------------------- NEOVIM --------------------------------------

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

"--------------------------------- TABS ---------------------------------------

" Use <alt-j> and <alt-k> to change tab
:nnoremap <C-j> gT
:nnoremap <C-k> gt

"------------------------------ VIMSCRIPT -------------------------------------

" Use \\ as <localleader>
:let  maplocalleader = "\\"

" Let Vim say something nice at startup
autocmd VimEnter * echo "'O.O' Ah que coucou !"

" Map Leader-u to set the current word Uppercase
:imap <localleader>u <esc>viw~ea

" Use a shorcut to edit my vimrc
:nnoremap <leader>ev :sp $HOME/.vimrc<cr>

" Use a shorcut to source my vimrc
:nnoremap <leader>sv :so $MYVIMRC<cr>

" Use shorcuts for fzf
:nnoremap <leader>ef :Files<cr>
:nnoremap <leader>rg :Rg<cr>

" Use a shorcut to install plugin
:nnoremap <leader>pi :PlugInstall<cr>
:nnoremap <leader>pu :PlugUpdate<cr>
:nnoremap <leader>pc :PlugClean<cr>


" Abbreviation for main
:iabbrev mainc int		main(int argc, char **argv)<cr>{<cr>}<esc>ko

" Open the previous buffer when delete one
:command! Bd bp\|bd \#

"" Neovim terminal toggle
"let g:term_buf = 0
"let g:term_win = 0
"
"function! Term_toggle(height)
"    if win_gotoid(g:term_win)
"        hide
"    else
"        botright new
"        exec "resize " . a:height * 2
"        try
"            exec "buffer " . g:term_buf
"        catch
"            call termopen($SHELL, {"detach": 0})
"            let g:term_buf = bufnr("")
"        endtry
"        startinsert!
"        let g:term_win = win_getid()
"    endif
"endfunction
"
"if has('nvim')
"	nnoremap <localleader>t :call Term_toggle(10)<cr>
"	tnoremap <localleader>t <C-\><C-n>:call Term_toggle(10)<cr>
"endif

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

"--------------------------------- Cscope -------------------------------------

nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
nnoremap <leader>k :call ToggleLocationList()<CR>

" s: Find this C symbol
nnoremap  <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap  <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap  <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap  <leader>fc :call CscopeFind('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap  <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap  <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap  <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
" i: Find files #including this file

"---------------------------------- 42 ----------------------------------------

" Set formatted comment
set comments=sr:/*,mb:**,ex:*/
nmap <f1> :FortyTwoHeader<CR>

"--------------------------------- Translate -----------------------------------

let g:translate#default_languages = {
			\ 'fr': 'en',
			\ 'en': 'fr'
			\ }

vmap T <Plug>Translate
vmap R <Plug>TranslateReplace
vmap P <Plug>TranslateSpeak

nnoremap <leader>c :set cursorline! cursorcolumn!<cr>

"nnoremap <leader>r :RandomColorScheme<cr>

" Completion
"set omnifunc=syntaxcomplete#Complete

"---------------------------------- Gitgetter ----------------------------------
"Delay to update in millisecond
set updatetime=100

"---------------------------------- Vim-go ----------------------------------
" exe 'vertical resize 84'

" au FileType go nmap <leader>r <Plug>(go-doc-vertical)
let g:go_fmt_command="gopls"
let g:go_gopls_gofumpt=1


"set splitright
"-------------------------------- YOUCOMPLETME ---------------------------------

" Remove <Tab> from the list of keys mapped by YCM.
"let g:ycm_key_list_select_completion = ['<Down>']

"---------------------------------- Neoscroll ----------------------------------

" lua require('neoscroll').setup({
" -- All these keys will be mapped to their corresponding default scrolling animation
" mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
" '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
" hide_cursor = true,          -- Hide cursor while scrolling
" stop_eof = true,             -- Stop at <EOF> when scrolling downwards
" use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
" respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
" cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
" easing_function = nil,       -- Default easing function
" pre_hook = nil,              -- Function to run before the scrolling animation starts
" post_hook = nil,             -- Function to run after the scrolling animation ends
" performance_mode = false,    -- Disable "Performance Mode" on all buffers.
" })

"------------------------------------ RUST -------------------------------------

let g:syntastic_rust_checkers = ['cargo']
let g:rustfmt_autosave = 1
nmap <leader>tb :TagbarToggle<CR>


"------------------------------------ HTML -------------------------------------
" Unset wrap
autocmd FileType html :setlocal nowrap
" Autoindent html files when write/read it
":autocmd BufWritePre,BufRead *.html :normal G=gg

"--------------------------------- JAVASCRIPT ----------------------------------
autocmd FileType javascript set expandtab shiftwidth=2

"------------------------------------ VUE --------------------------------------
autocmd FileType vue set expandtab shiftwidth=2

"------------------------------------- XML -------------------------------------
autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

"----------------------------------- PYTHON ------------------------------------
"autocmd FileType python
"------------------------------------ COC --------------------------------------
"source ~/.vim/plugged/coc.nvim/plugin/coc.vim

" Use <c-space> to trigger completion.
"if has('nvim')
"  inoremap <silent><expr> <c-space> coc#refresh()
"else
"  inoremap <silent><expr> <c-@> coc#refresh()
"endif

" GoTo code navigation.
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
"nnoremap <silent> K :call <SID>show_documentation()<CR>

"let g:coc_global_extensions = [
"			\ 'coc-python',
"			\ 'coc-json',
"			\ 'coc-pairs',
"			\ 'coc-tsserver',
"			\ ]
" Right indentation for yaml files
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Avoid autoindent on comments
:set indentkeys-=0#

autocmd BufNewFile,BufReadPost * if &filetype == "python" | set indentkeys-=0# | endif
autocmd BufNewFile,BufReadPost * if &filetype == "yaml" | set expandtab shiftwidth=2 indentkeys-=0# | endif

