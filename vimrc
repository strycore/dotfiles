"
" Mathieu Comandon's vimrc
"
" This file is under a WTFPL License :
" http://sam.zoy.org/wtfpl/
"
" You can get the latest version of this file at:
" http://github.com/strycore/scripts/blob/master/vimrc
"
" One day this vimrc file will be the best vimrc EVAR!
" Right now it just needs a lot of work done.
"
" This vimrc is optimised for :
" - PHP and symfony
" - Javascript, CSS, HTML
" - Python
" - Bash
"
" Inspirations:
" How I boosted my Vim (nvie)
" http://nvie.com/posts/how-i-boosted-my-vim/
" http://github.com/nvie/vimrc/blob/master/vimrc
"
" Hacking Vim – The Ultimate Vimrc
" http://www.jonlee.ca/hacking-vim-the-ultimate-vimrc/
"

" Python and vim: Make your own IDE
" http://dancingpenguinsoflight.com/2009/02/python-and-vim-make-your-own-ide/

" Vim as a Python IDE
" http://code.google.com/p/trespams-vim/

" Howto setup vim ide for php development from @hameedullah
" http://hameedullah.com/howto-setup-vim-ide-for-php-development.html

" gmarik's vimrc
" https://github.com/gmarik/vimfiles/blob/master/vimrc

" Rick Harding (mitechie)
" https://github.com/mitechie/pyvim

"
" Plugins
" -------
" For automatic plugin installation, see the vim-setup script
"
" NERDTree
" ack-grep
"
"
" Extarnal programs
" -----------------
"
"  These are needed by this vim config
"
"  tidy : apt-get install tidy
"  ctags : apt-get install ctags
"  json_xs : http://search.cpan.org/dist/JSON-XS/
"
"  may include in the near future:
"
"  PHP_Beautifier : pear install PHP_Beautifier-0.1.15
"

" Function keys:
" F1:  Help
" F2:  Close buffer
" F3:  Toggle NERDTree
" F4:  Toggle Tagbar
" F5:  Previous buffer
" F6:  Next buffer
" F7:  Toggle paste mode
" F8:  Run Flake8
" F9:  Reindent whole file
" F10: Run file (currently supported: python, bash, html)
" F11: Reserved for fullscreen switching by WM or Terminal emulator
" F12: Available

" Other shortcuts:
"
" ,/ Remove search highlight
" ,l Toggle invisible characters
" ,t open command-t filesearch
" :w!! save file with sudo
" "+y  copy to system clipboard
" <Shift>Ins paste from system clipboard
"
" TODO List
"
" Better autocompletion
" Better help system


" == General & interface

set nocompatible
set history=1000
set undolevels=1000
set clipboard+=unnamed

set showcmd
set showmode
set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ (%p%%)]
set viminfo='100,f1,:1000,/1000,%  " big viminfo :)
set mouse=a
set cmdheight=2     " Make command line 2 lines high
set laststatus=2    " always show status line
set scrolloff=3     " Keep 3 lines below and above the cursor
set matchpairs+=<:> " Show matching <> as well
set showmatch

syntax on

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Color scheme
set t_Co=256
set background=dark
colorscheme molokai


" == Identation and tabs
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
set backspace=indent,eol,start

set linespace=4
set ruler
set hidden     "don't whine when trying to move away from an unsaved buffer

" Searching
set ignorecase "ignore case when searching
set smartcase  " ignore case if search pattern is all lowercase,
               " case-sensitive otherwise
set hlsearch   " highlight search terms
nmap <silent> ,/ :nohlsearch<CR>
set incsearch

set foldmethod=marker foldopen=all,insert foldclose=all
set foldlevelstart=99
set nowrap
set gdefault  " Search all occurrences by default
" Enable enhanced command line completion.
set wildmenu
set wildmode=longest:full,list
" Ignore these filenames during enhanced command line completion.
set wildignore+=*.bak,*.class
set wildignore+=*.aux,*.out,*.toc " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png " binary images
set wildignore+=*.luac " Lua byte code
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.pyc " Python byte code
set wildignore+=*.spl " compiled spelling word lists
set wildignore+=*.sw? " Vim swap files
set title
set novisualbell  " No blinking
set noerrorbells  " No noise
set nobackup    " Backup files are sooo 90's
set noswapfile  " Swap files are very annoying
set lazyredraw
set guioptions+=b

set cursorline
set number
set numberwidth=1
set shortmess+=a
set report=0
set confirm
set encoding=utf8
set showfulltag

" don't outdent hashes
inoremap # #

let mapleader=","
let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
let g:showmarks_enable = 1

let g:Powerline_symbols = 'fancy'

" Copy to clipboard
map <leader>y "+y

" Paste from clipboard
map <leader>p "+gP


" Highlight long lines
if exists('+colorcolumn')
    set colorcolumn=80
    highlight ColorColumn ctermbg=darkgray guibg=#4E4E4E
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" ,v brings up my .vimrc
" ,V reloads it -- making all changes active (have to save first)
map <leader>v :sp ~/.vimrc<CR><C-W>_
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

highlight BadWhitespace ctermbg=red guibg=red
let python_highlight_builtin_funcs = 1
let python_print_as_function = 1
let python_highlight_builtin_objs = 1
let python_highlight_doctests = 1
let python_highlight_string_templates = 1

let g:pylint_onwrite = 1
let g:pylint_show_rate = 1
let g:pylint_cwindow = 1


let php_sql_query=1
let php_htmlInStrings=1
let g:php_folding=2

map <silent> <S-F8> :w<CR>:make<CR>:cw<CR>
" let g:molokai_original=1

" Rope configuration
map <leader>j :RopeGotoDefinition<CR>
map <leader>r :RopeRename<CR>

" CtrlP configuration
let g:ctrlp_working_path_mode = 2

""" Keybindings

" Disable ex mode
map Q <Nop>
" Map :w< to :w because my fingers slip
map :w<<CR> :w<CR>

" Stuff to piss off vim purists
inoremap <silent> <C-Backspace> <C-w>
inoremap <silent> <C-z> <Esc>:undo<CR>i

filetype plugin on
filetype indent on


set completeopt=menuone,longest,preview

set omnifunc=syntaxcomplete#Complete
if has('autocmd')
    autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab "Makefiles require hard tabs
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType php setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab

    autocmd FileType sh nmap <F10> :!. %<CR>

    autocmd FileType c set omnifunc=ccomplete#Complete

    autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags

    if filereadable('./PYSMELLTAGS')
        autocmd FileType python setlocal omnifunc=pysmell#Complete
    else
        autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    endif
    autocmd BufRead,BufNewFile *.py  set ai sw=4 sts=4 et
    autocmd BufRead,BufNewFile *.wsgi setfiletype python

    " Remove trailing whitespace on save
    autocmd BufWritePre *.py :%s/\s\+$//e
    if !empty($VIRTUAL_ENV)
        autocmd BufRead *.py set makeprg=pylint\ --init-hook=\"import\ os;execfile(os.environ[\'VIRTUAL_ENV']+\'/bin/activate_this.py\'\,\ dict(__file__=os.environ[\'VIRTUAL_ENV\']+\'/bin/activate_this.py\'))\"\ --reports=n\ --output-format=parseable\ %:p
    else
        autocmd BufRead *.py set makeprg=pylint\ --reports=n\ --output-format=parseable\ %:p
    endif
    autocmd BufRead *.py set errorformat=%f:%l:\ %m
    autocmd FileType python map <buffer> <F8> :call Flake8()<CR>
    "autocmd BufWritePost *.py call Flake8()
    autocmd BufRead *.py nmap <F10> :!python %<CR>
    autocmd BufRead *.js set makeprg=jshint\ %
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType javascript map <buffer> <F8> :w<CR>:JSHint<CR>
    autocmd BufNewFile,BufRead *.coffee setfiletype coffee

    autocmd BufRead *.coffee setfiletype coffee


    autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType html set equalprg=tidy\ -i\ -q

    autocmd FileType html nmap <F10> :!firefox %<CR>

    autocmd BufNewFile,BufRead *.rss setfiletype xml

    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
    autocmd FileType css set equalprg=csstidy
    autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab

    autocmd FileType less set omnifunc=csscomplete#CompleteCSS
    autocmd BufNewFile,BufRead *.less setfiletype less
    autocmd FileType less setlocal ts=2 sts=2 sw=2 expandtab
    "autocmd BufWritePost *.less silent exe  '!lessc ' . shellescape(expand('<afile>')) . ' ' . shellescape(expand('<afile>:r')) . '.css'

    autocmd FileType php set omnifunc=phpcomplete#CompletePHP
    autocmd FileType php set ft=php.html
    autocmd FileType php set equalprg=php_beautifier\ -l\ \"Pear()\ ArrayNested()\"\ -s2

    autocmd FileType php noremap <C-M> :w!<CR>:!php %<CR> " Run script with php-cli
    autocmd FileType php noremap <S-F8> :!php -l %<CR> " php syntax check
    autocmd FileType php noremap <F8> :!phpcs %<CR>  " php CodeSniffer

    " Shortcuts to php-docs
    autocmd FileType php inoremap <C-D> <ESC>:call PhpDocSingle()<CR>i
    autocmd FileType php nnoremap <C-D> :call PhpDocSingle()<CR>
    autocmd FileType php vnoremap <C-D> :call PhpDocRange()<CR>

    autocmd BufRead *.vala set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
    autocmd BufRead *.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
    autocmd BufRead,BufNewFile *.vala setfiletype vala
    autocmd BufRead,BufNewFile *.vapi setfiletype vala
    if filereadable('./manage.py')
        autocmd FileType python set ft=python.django " For SnipMate
        autocmd FileType html set ft=htmldjango.html " For SnipMate
    endif
    autocmd BufRead,BufNewFile *.twig setfiletype htmldjango.html
    autocmd FileType htmldjango setlocal ts=2 sts=2 sw=2 expandtab
    " Closes the Omni-Completion tip window when a selection is made
    autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
    autocmd InsertLeave * if pumvisible() == 0|pclose|endif
endif

if has("gui_running")
    highlight SpellBad term=underline gui=undercurl guisp=Orange
    set guifont=Monaco\ for\ Powerline\ 9
    set guioptions=ecmg "console dialogs, do not show menu and toolbar
    set showtabline=2
    set lines=65
    set columns=120
    set background=dark
    colorscheme molokai
endif

" Invisible characters
set listchars=tab:▸\ ,trail:.,extends:#,nbsp:.,eol:¬
nmap <leader>l :set list!<CR>

" Detect filetype shortcut
nmap <leader>f :filetype detect<CR>

" I think this part remove useless trailing spaces
autocmd BufRead * silent! %s/[\r \t]\+$//
autocmd BufEnter *.php :%s/[ \t\r]\+$//e

map <silent> <A-Right> :tabnext<CR>
map <silent> <A-Left> :tabprevious<CR>
noremap <silent> <C-Left> <C-T>
noremap <silent> <C-Right> <C-]>

noremap <C-S-PageUp> gt
noremap <C-S-pageDown> gT

map <kPlus> <C-W>+
map <kMinus> <C-W>-
map <kDivide> <c-w>>
map <kMultiply> <c-w><

" Allow moving in insert mode with home row keys
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

" Remap autocompletion to Ctrl-Space
inoremap <Nul> <C-x><C-o>
imap <C-space> <C-x><C-o>

" Tagbar configuration
map <silent> <F4> :TagbarToggle<CR>

let g:NERDTreeWinSize = 25
let g:NERDTreeIgnore = ['^tags$', '^PYSMELLTAGS']


" SnipMate config
let g:snips_author = 'Mathieu Comandon'

" Supertab configuration
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

" Syntastic configuration
let g:syntastic_check_on_open=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_auto_jump=0

" json formating
" map <leader>jt  <Esc>:%!json_xs -f json -t json-pretty<CR>

" Toggle NerdTree
map <silent> <F2> :bd<CR>
map <silent> <F3> :NERDTreeToggle<CR>

" Move between buffers
map <silent> <F5> :bprevious<CR>
map <silent> <F6> :bnext<CR>

" Toggle paste mode
set pastetoggle=<F7>

" Lusty juggler config
let g:LustyJugglerKeyboardLayout = "azerty"
let g:LustyJugglerAltTabMode = 1
noremap <silent> <Leader>s :LustyJuggler<CR>

let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

"Shortcut to auto indent entire file
nmap <F9> 1G=G
imap <F9> <ESC>1G=Ga

" Save file with sudo
cmap w!! w !sudo tee % > /dev/null

set path=$PWD/**

command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
map <Leader>d :DiffOrig<CR>

if has('python')
    python << EOF
import os
import sys
import vim
for p in sys.path:
    if os.path.isdir(p):
        vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
EOF
endif
