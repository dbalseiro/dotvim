autocmd!

au bufreadpost,filereadpost *.drl set ft=drools
au bufreadpost,filereadpost asana_comment.txt set ft=asana


"VUNDLE
set nocompatible
set noshowmode
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'Lokaltog/vim-powerline'
Plugin 'tpope/vim-fugitive'
Plugin 'L9'
Plugin 'wincent/Command-T'
Plugin 'nvie/vim-togglemouse'
Plugin 'ivalkeen/vim-simpledb'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
"Plugin 'mileszs/ack.vim'
Plugin 'rking/ag.vim'
Plugin 'tpope/vim-surround'
" " All of your Plugins must be added before the following line
"Bundle 'altercation/vim-colors-solarized'
Bundle 'morhetz/gruvbox'

call vundle#end()            " required
filetype plugin indent on    " required

let g:Powerline_symbols = 'fancy'
set encoding=utf-8
set fillchars+=stl:\ ,stlnc:\
"set term=xterm-256color
set termencoding=utf-8
set guifont=Menlo\ for\ Powerline

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType java set tags=~/.ctags/gcaba.tags
set nobackup
set noswapfile
set pastetoggle=<F2>
set nowrap "dont like wrapping
set mouse=a

" allow unsaved background buffers and remember marks/undo for them
set hidden
" remember more commands and search history
set history=10000
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set laststatus=2
set showmatch
set incsearch
set hlsearch
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
" highlight current line
set cursorline
set cmdheight=1
set switchbuf=useopen
set showtabline=2
set winwidth=79
" This makes RVM work inside Vim. I have no idea why.
set shell=bash
" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=
" keep more context when scrolling off the end of a buffer
set scrolloff=3
" Store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" display incomplete commands
set showcmd
" Enable highlighting for syntax
syntax on
" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on
" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list
" make tab completion for files/buffers act like bash
set wildmenu
let mapleader=","
" Fix slow O inserts
:set timeout timeoutlen=1000 ttimeoutlen=100

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:set t_Co=256 " 256 colors
:set background=dark
:color gruvbox
let g:gruvbox_contrast_dark="medium"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

" Clear the search buffer when hitting return
function! MapCR()
  nnoremap <leader><cr> :nohlsearch<cr>
endfunction
call MapCR()
nnoremap <leader><leader> <c-^>
nnoremap <leader>. :only<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN FILES IN DIRECTORY OF CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :tabnew\|:edit %%<cr>

"""""""""""""""""""""
" TAB MAPS
""""""""""""""""""""""
noremap <leader>b :tabnew<cr>
noremap <leader>n :tabprevious<cr>
noremap <leader>m :tabnext<cr>

"""""""""""""""""""""
" SPLIT MAPS
""""""""""""""""""""""
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>S :split\|:edit %%<cr>
map <leader>s :vsplit\|:edit %%<cr>
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l
map <C-S> <C-W><S-T>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-x><c-u>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>r :call RenameFile()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUNNING TESTS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>o :w\|:!./%<cr>

set foldmethod=manual
set nofoldenable

""""""""""""""""
" LINE NUMBERS "
""""""""""""""""
set relativenumber
set number
function! ToggleNumbersOn()
    set relativenumber!
    set number
endfunction
function! ToggleRelativeOn()
    set number!
    set relativenumber
    set number
endfunction
autocmd FocusLost * call ToggleNumbersOn()
autocmd FocusGained * call ToggleRelativeOn()
autocmd InsertEnter * call ToggleNumbersOn()
autocmd InsertLeave * call ToggleRelativeOn()

"""""""""""""""""
" ASANA PROJECT "
"""""""""""""""""
map <leader>a :wa\|:make --directory=$ASANA_PATH clean asana<cr>

""""""""""""""""""""""
" EASY EDITING VIMRC "
""""""""""""""""""""""
nnoremap <silent> <leader>ve :e $MYVIMRC<CR>
nnoremap <silent> <leader>vs :w\|so $MYVIMRC<CR>


""""""""
" ECLIM "
"""""""""
map <F1> :ProjectTreeToggle<cr>
map <leader><F1> :ProjectsTree<cr>
nnoremap <leader>js :JavaSearch -s workspace -x declarations<cr>
nnoremap <leader>ja :JavaSearch -s workspace -x references<cr>
nnoremap <leader>jc :JavaCorrect<cr>
nnoremap <leader>jo :JavaImportOrganize<cr>
nnoremap <leader>jg :JavaGetSet<cr>
nnoremap <leader>jb :w\|Mvn! -f ~/git/gcaba-io/source/back-end -Dmaven.test.skip=true clean install<cr>

nnoremap <leader>jds :JavaDebugStart localhost 8787<cr>
nnoremap <F9> :JavaDebugBreakpointToggle<cr>
nnoremap <leader>jdb :JavaDebugBreakpointRemove!<cr>

nnoremap <F7> :JavaDebugStep over<cr>
nnoremap <F8> :JavaDebugStep into<cr>
nnoremap <S-F8> :JavaDebugStep return<cr>

nnoremap <F5> :JavaDebugThreadResumeAll<cr>

nnoremap <leader>pp :ProjectProblems<cr>
nnoremap <leader>pt :ProjectTab 
 
let g:EclimMakeLCD=0

function! Standalone()
    tabnext
    edit ~/jboss-as-7.1.1.Final/standalone/configuration/standalone-io.xml
endfunction
map <F10> :call Standalone()<cr>

"""""""
" GIT "
"""""""
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gh :!tig %<cr>
nnoremap <leader>gv :!tig<cr>
nnoremap <leader>gp :Git push<cr>
nnoremap <leader>gl :Gpull<cr>

""""""""""""
" NERDTree "
""""""""""""
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" map <C-n> :NERDTreeToggle<CR>
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" netrw "
"""""""""
" Toggle Vexplore with ctr-n
function! ToggleVExplorer()
    if exists("t:expl_buf_num")
        let expl_win_num = bufwinnr(t:expl_buf_num)
        if expl_win_num != -1
            let cur_win_nr = winnr()
            "exec expl_win_nr . 'wincmd w'
            close
            exec cur_win_nr . 'wincmd w'
            unlet t:expl_buf_num
        else
            unlet t:expl_buf_num
        endif
    else
        exec '1wincmd w'
        Vexplore
        let t:expl_buf_num = bufnr("%")
    endif
endfunction
map <silent> <c-n> :call ToggleVExplorer()<cr>
"Hit enter in the file browser to open the selected file with vsplit to the
"right of the browser
"let g:netrw_browse_split = 4
"let g:netrw_altv = 1
"default to tree mode
let g:netrw_liststyle = 0
"change directory to the current buffer when opening files
set autochdir

function! OnStart()
    if argc() == 0 && !exists("s:std_in") 
        ProjectTab rule-engine
    endif
endfunction
autocmd VimEnter * call OnStart()

"""""""""""""
" Command-T "
"""""""""""""
let g:CommandTWildIgnore=&wildignore . ",**/target/*"
let g:CommandTEncoding="UTF-8"

""""""
" Ag "
""""""
let g:ag_working_path_mode="r"
nnoremap <leader>f :Ag "\b<C-R><C-W>\b"<CR>:cw<CR>
nnoremap \ :Ag<space>

"""""""""""""
" Syntastic "
"""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"""""""""
" DBExt "
"""""""""
let g:dbext_default_profile_gcba = 'type=PGSQL:user=postgres:host=gcaba-io.cmdb03agwzjb.us-east-1.rds.amazonaws.com:dbname=pruebas'
let g:dbext_default_profile = 'gcba'
