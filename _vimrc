" marc's .vimrc file

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

"------------------------------------------------------------------------------
" Set up Vundle
"------------------------------------------------------------------------------

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" Vundle plugins

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"------------------------------------------------------------------------------
" END Set up Vundle
"------------------------------------------------------------------------------

" Fonts
" - font type and size setting.
if has('win32')
    set guifont=Consolas:h12   " Win32.
elseif has('gui_macvim') && has('gui_running')
    set guifont=Monaco:h14     " OSX.
else
    set guifont=Monospace\ 12  " Linux.
endif

if has('gui_macvim') && has('gui_running')
    " Copy by default to the OS X clipboard when yanking
    set clipboard=unnamed
endif

" I don't know what these do or if I need them
" http://vimdoc.sourceforge.net/htmldoc/options.html#'cpoptions'
" set cpoptions-=B
" set cpoptions=ceFs

" set tags=./tags,./../tags,./../../tags,~/tags,~/dev/tags

if has("termguicolors")
    set termguicolors
endif

" colorscheme borland
" colorscheme evening
:silent! colorscheme macvim
set background=dark
syntax on

" Only do case-sensitive search if search has uppercase letter - that's smart
set ignorecase smartcase

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set autoindent		           " always set autoindenting on
set backup		               " keep a backup file
" set colorcolumn=80             " Show colored margin
set history=50		           " keep 50 lines of command line history
set incsearch		           " do incremental searching
set ruler		               " show the cursor position all the time
set showcmd		               " display incomplete commands
set showmode                   " display when in INSERT mode
set ttymouse=xterm             " so vim doesn't hang inside screen and tmux
set mouse=a                    " enable mouse in all modes
set undofile                   " persist undo state across vim restarts

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
" map Q gq

" shortcuts for opening .c and .h files
" map gc :e %:t:r.c<CR>
" map gh :e %:t:r.h<CR>

" This is an alternative that also works in block mode, but the deleted text
" is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
" if &t_Co > 2 || has("gui_running")
"   syntax on
"   set nohlsearch " I hate hlsearch
" endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

endif " has("autocmd")

"------------------------------------------------------------------------------
" key mappings
"------------------------------------------------------------------------------

let mapleader = ","

" Toggle paste mode with <F4>
" Janus does the following:
"     nmap <silent> <F4> :set invpaste<CR>:set paste?<CR>
"     imap <silent> <F4> <ESC>:set invpaste<CR>:set paste?<CR>
" But this seems easier and doesn't write <F4> when in insert paste mode
nnoremap <F4> :set invpaste paste?<CR>
set pastetoggle=<F4>

" Turn on paste and enter insert mode
map <C-p>     :set paste<CR>i

" Underline the current line with '='
nmap <silent> <leader>ul :t.<CR>Vr=

" Toggle line numbering
function! ToggleLineNumbering()
    if !&number && !&relativenumber
        setlocal number
    elseif &number && !&relativenumber
        setlocal relativenumber
    elseif &number || &relativenumber
        setlocal nonumber norelativenumber
    endif
endfunction

" Toggle colorcolumn
function! ToggleColorColumn()
    if &colorcolumn == 0
        setlocal colorcolumn=80
    else
        setlocal colorcolumn=0
    endif
endfunction

nnoremap <leader>N :call ToggleLineNumbering()<CR>
" nnoremap <leader>N :setlocal number!<CR>:setlocal number?<CR>
" nnoremap <leader>R :setlocal relativenumber!<CR>:setlocal relativenumber?<CR>

" Toggle colorcolumn
nnoremap <leader>C :call ToggleColorColumn()<CR>

" Toggle hlsearch with <leader>hs
nmap <leader>hs :set invhlsearch hlsearch?<CR>

" Easy way to exit insert mode
inoremap ii <Esc>

" Indent with Tab and Shift-Tab
nnoremap <Tab> >>
nnoremap <S-Tab> <<
vnoremap <Tab> >>
vnoremap <S-Tab> <<

" Go to line number in normal mode by typing it and <Enter>
" http://vim.wikia.com/wiki/Jump_to_a_line_number
nnoremap <CR> G

" upper/lower word
nmap <leader>uw mQviwU`Q
nmap <leader>lw mQviwu`Q

" Make j and k work the way you'd expect for long lines
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/
nnoremap j gj
nnoremap k gk

" Quickly open ~/.vimrc
nnoremap <leader>ve <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <leader>vs :source $MYVIMRC<cr>:echo "Sourced " .  $MYVIMRC<CR>

" mappings for splits from http://jmcpherson.org/windows.html:
map <C-H> <C-W>h
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l
" set wmh=0

" cd to the directory containing the file in the buffer
nmap <silent> <leader>cd :lcd %:h<CR>

" Create the directory containing the file in the buffer
nmap <silent> <leader>md :!mkdir -p %:p:h<CR>

" reselect the text that was just pasted
nnoremap <leader>v. v`]

map <C-Tab> :bnext<CR>
map <S-C-Tab> :bprevious<CR>
map ,<Left> :bprevious<CR>
map ,<Right> :bnext<CR>
" nnoremap ,,  <C-^>
nnoremap ,,  :bnext<CR>
nnoremap <SPACE> :bnext<CR>
" nnoremap zl :ls!<CR>:buf /
nnoremap <leader>bd :bd<CR>

"------------------------------------------------------------------------------
" END key mappings
"------------------------------------------------------------------------------

"------------------------------------------------------------------------------
" Automatically use paste when pasting in terminal
"------------------------------------------------------------------------------

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

"------------------------------------------------------------------------------
" END Automatically use paste when pasting in terminal
"------------------------------------------------------------------------------

"
" PHP stuff from http://www.schlitt.info/misc/.vimrc
"

" Set standard setting for PEAR coding standards
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Auto expand tabs to spaces
set expandtab

" Auto indent after a {
set autoindent
set smartindent

" Save some info about the session between sessions
set viminfo='50,%,n/tmp/viminfo

if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo")
    call mkdir($HOME."/.vim/undo", "", 0700)
endif

" Where to put various files that vim maintains
" http://stackoverflow.com/a/15317146
set backupdir=~/.vim/backup
" set directory=~/.vim/swap//
set noswapfile
set undodir=~/.vim/undo//

set hidden

"   Wildcard settings
"       What to ignore
set wildignore=*.o,*.so,*~,*/CVS
"       complete to longest common and list the alternatives
set wildmode=list:longest

set <M-c>=c

" Enable vimacs
" let g:VM_Enabled=1

" set wildmenu

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1 
" let g:miniBufExplForceSyntaxEnable = 1
let g:Tb_cTabSwitchBufs = 1


" C formatting stuff from http://pst.corp.p4pnet.net/~pmineiro/.vimrc:
" The following sets up autoindent in the GNU coding style.
set cinoptions=(0,g0,{s,>2s,n-s,^-s,t0
set cindent

" only do that for C code
autocmd BufNewFile,BufRead *.pm,*.pl,*.pm.in,*.pl.in,*.c,*.h set formatoptions= cindent
autocmd BufNewFile,BufRead *.pm,*.pl,*.pm.in,*.pl.in,*.c,*.h set expandtab autoindent
autocmd BufEnter *.pm,*.pl,*.pm.in,*.pl.in set keywordprg=perlmegaman
autocmd BufLeave *.pm,*.pl,*.pm.in,*.pl.in set keywordprg=megaman

