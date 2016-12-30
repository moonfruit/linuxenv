" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup		" do not keep a backup file, use versions instead
set history=50		" keep 50 lines of command line history
set ruler			" show the cursor position all the time
set showcmd			" display incomplete commands
set incsearch		" do incremental searching

" about fold
set foldenable
set foldmethod=marker
" set foldlevel=99

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  augroup redhat
  au!
  augroup END

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 80 characters.
  autocmd FileType text setlocal textwidth=80

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" if !exists(":DiffOrig")
"   command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
" 		  \ | wincmd p | diffthis
" endif

" My Vimrc
set magic
set tabstop=4
set shiftwidth=4
set display=lastline

" colorscheme molokai

set tags=tags;
set fileencodings=ucs-bom,utf-8,cp936,default
set title
set titlelen=32
" set titleold

set wildmenu
set shortmess=atI
set report=0
set fillchars=vert:\
set showmatch

" map F2 to switch off highlighting for search
nmap <silent> <F2> :nohlsearch<CR>

" map space to control folding
nnoremap <silent> <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" map arrow keys
noremap! <M-k> <Up>
noremap! <M-j> <Down>
noremap! <M-h> <left>
noremap! <M-l> <Right>

if has("unix")
  let s:uname = substitute(system("uname"), '\n\+$', '', '')
endif

if s:uname == "AIX"
  set encoding=utf-8
endif

" statusline
" set laststatus=2
highlight User1 term=inverse,bold cterm=inverse,bold ctermfg=red
set statusline=%f\ %1*%m%*%<%h%w%r%y%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%=%-9.([%03b]%)%-10.([0x%02B]%)%-19.(%-13.(%l,%c%V%)\ %P%)

command W w !sudo tee %

" pathgen
execute pathogen#infect()

" taglist
if s:uname != "AIX" && executable("ctags") && ! &diff
  let Tlist_Auto_Open=0
endif
let Tlist_Ctags_Cmd="ctags"
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_Right_Window=1
let Tlist_WinWidth=34
let Tlist_Inc_Winwidth=0
let Tlist_Enable_Fold_Column=0
