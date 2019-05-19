set background=dark
highlight clear

if exists("syntax on")
	syntax reset
endif
let g:colors_name="kantum"

" Errors less agressive
hi	ErrorMsg ctermfg=1 ctermbg=0 guifg=Black guibg=Red

" SetNumber color
hi  LineNr ctermfg=12

" Statement color
hi  Statement ctermfg=13

" Constant color
hi	Constant ctermfg=37

" ColorColumn at 80 characters
hi	ColorColumn ctermbg=darkblue

" Set the folds to not be backgrounded
hi	Folded ctermbg=NONE

" Set invisisble split separators
hi VertSplit cterm=NONE
set fillchars=""

" Set tabs colors

" Unselected tab
hi Tabline ctermbg=NONE
hi Tabline ctermfg=grey

" Selected tab
hi TablineSel ctermfg=magenta
hi TablineSel ctermbg=NONE
hi TabLinefill cterm=NONE

" Set transparent airline
hi StatusLine cterm=NONE
hi StatusLineNC ctermbg=NONE

" Set gui basic
hi Normal guibg=#323237
hi Normal guifg=white
