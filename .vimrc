set nocompatible    " be iMproved
filetype off        " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" vim-scripts repos
Bundle 'python.vim'

" basic plugins
Bundle 'Auto-Pairs'
Bundle 'The-NERD-Commenter'
Bundle 'The-NERD-tree'
Bundle 'Tagbar'
" Highlight several words in different colors simultaneously. 
Bundle 'Mark--Karkat'
Bundle 'Lokaltog/vim-easymotion'
" surround.vim: quoting/parenthesizing made simple.
Bundle 'tpope/vim-surround'
Bundle 'bling/vim-airline'
" True Sublime Text style multiple selections for Vim.
Bundle 'terryma/vim-multiple-cursors'
Bundle 'Valloric/YouCompleteMe'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/syntastic'
Bundle 'luochen1990/rainbow'
" A vim plugin to display the indention levels with thin vertical lines.
Bundle 'Yggdroot/indentLine'
" Vim plugin that allows you to visually select increasingly larger regions of
" text using the same key combination.
Bundle 'terryma/vim-expand-region'
Bundle 'sjl/gundo.vim'
Bundle 'tpope/vim-fugitive'

" haskell
Bundle 'haskell.vim'
Bundle 'Shougo/context_filetype.vim'
Bundle 'philopon/haskell-indent.vim'

" c/c++
Bundle 'a.vim'

filetype plugin indent on    " required!

" basic settings
" search 
set hlsearch
set incsearch
"
set number
set cursorline
set ruler
set wildmenu
"重启后撤销历史可用 persistent undo
set undofile
set undodir=~/.vim/undodir
set undolevels=1000 "maximum number of changes that can be undone
"the-80-line is diffrent
set cc=80
"display pairs
set showmatch
set matchtime=1
" fold
set foldenable
"history
set history=1000
"display search
set ignorecase
set magic
"syntax
syntax on
syntax enable
"indent
set shiftwidth=2
set tabstop=4
set softtabstop=4
set autoindent
set cindent
set smartindent
"Tab
set expandtab
set smarttab
"keywords
set iskeyword+=_,$,@,%,#,-
set backspace=2
set whichwrap+=<,>,h
"mouse
set mouse=a
set selection=exclusive
set selectmode=mouse,key
"plug-in settings
"ctags
set tags+=tags
set tags+=/usr/include/tags
let Tlist_Sort_Type = "name"
let Tlist_Use_Right_Window = 1
let Tlist_Compart_Format = 1
let Tlist_Exist_OnlyWindow = 1
let Tlist_File_Fold_Auto_Close = 0
let Tlist_Enable_Fold_Column = 0
let Tlist_Show_One_File=1

"TagBar
nnoremap <F4> :TagbarToggle <CR>
let g:tagbar_ctags_bin = '/usr/bin/ctags'
let g:tagbar_width = 23

"auto-close complete-windows
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest

"vim cursor line & column
set cursorline cursorcolumn

"color
set background=dark

"NERDTree
nmap <silent> <F3> :NERDTreeToggle <cr>
let NERDChristmasTree=1
let NERDTreeAutoCenter=1
let NERDTreeMouseMode=2
let NERDTreeShowBookmarks=1
let NERDTreeShowFiles=1
let NERDTreeShowHidden=0
let NERDTreeShowLineNumbers=1
let NERDTreeWinPos='left'
let NERDTreeWinSize=22
let NERDTreeIgnore=['\.vim$', '\~$', '\.o$', '\.d$', '\.a$']

"Haskell
set expandtab
syn cluster hsRegions add=hsImport,hsLineComment,hsBlockComment,hsPragma
syn cluster hsRegions add=cPreCondit,cCppOut,cCppOut2,cCppSkip
syn cluster hsRegions add=cIncluded,cDefine,cPreProc,cComment,cCppString

syn match tab display "\t" containedin=@hsRegions
hi link tab Error
syn match trailingWhite display "[[:space:]]\+$" containedin=@hsRegions
hi link trailingWhite Error

" Haskell.vim
let hs_hightlight_boolean = 1
let hs_hightlight_types = 1
let hs_hightlight_more_types = 1
let hs_hightlight_debug = 1

"Vim-airline
set laststatus=2
set t_Co=256
"let g:Powline_symbols='fancy'

"indentLine
map <leader>il :IndentLinesToggle<CR>

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.o,*.hi,*.class     " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux

" Rainbow
let g:rainbow_active = 1

" Gundo
nnoremap <F5> :GundoToggle<CR>
let g:gundo_width = 40

" ================ Easymotion
let g:EasyMotion_leader_key = 'f'
" Gif config
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

