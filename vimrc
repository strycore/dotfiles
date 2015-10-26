" ****************
" Strider's  vimrc
" ****************
"
" 2010-2014 Mathieu Comandon, WTFPL License (http://sam.zoy.org/wtfpl/)
"
" More  vimrcs
" ------------
"
" gmarik
" https://github.com/gmarik/vimfiles/blob/master/vimrc
"
" mitechie
" https://github.com/mitechie/pyvim
"
" matsko
" https://github.com/matsko/.vimrc/blob/master/.vimrc
"
" nvie
" http://github.com/nvie/vimrc/blob/master/vimrc
"
" Funcion keys
" ------------
"
" F1:  Help
" F2:  Close buffer
" F3:  Toggle NERDTree
" F4:  Toggle Tagbar
" F5:  Previous buffer
" F6:  Next buffer
" F7:  Toggle paste mode
" F8:  Run Linter (Flake8, CoffeeLint, …)
" F9:  Toggle folds
" F10: Run file (currently supported: python, bash, html)
" F11: Reserved for fullscreen switching by WM or Terminal emulator
" F12: Available

" Shortcuts
" ---------
"
" <Control>f Search for occurences of a string using :Ag
" <Leader>/ Remove search highlight
" <Leader>l Toggle invisible characters
" <Leader>c  copy to system clipboard
" <Leader>v  paste from system clipboard
" <Leader>e  edit vimrc
" <Leader>E  reload vim configuration
" <Leader>tr Wrap selection in Django 'trans' templatetag
" <Leader>%  Wrap selection in generic {%  %} templatetag
" <Leader>{  Wrap selection in generic {{  }} templatetag
" <Leader>'  Transform a 2-column text line to a dict like syntax
" <Leader>ad Transform function arguments to dict syntax
" <Leader>da Transform dict syntax to function argument syntax
" :w!! save file with sudo
"
set nocompatible
filetype off

" set rtp+=~/.vim/bundle/vundle/
" call vundle#rc()

call plug#begin('~/.vim/plugged')

Plug 'closetag.vim'
Plug 'chazy/cscope_maps'
Plug 'Valloric/MatchTagAlways'

Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --clang-completer' }
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_filetype_blacklist = {'python': 1}
Plug 'othree/html5-syntax.vim'
Plug 'jelera/vim-javascript-syntax'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-surround'
Plug 'rking/ag.vim'
map <C-f> <esc>:Ag<space>
Plug 'gg/python.vim'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-unimpaired'
Plug 'garbas/vim-snipmate'
imap <C-s> <esc>a<Plug>snipMateNextOrTrigger
smap <C-s> <Plug>snipMateNextOrTrigger
Plug 'tomtom/tlib_vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'honza/vim-snippets'
Plug 'majutsushi/tagbar'
Plug 'elzr/vim-json'
Plug 'kchmck/vim-coffee-script'
Plug 'lukaszb/vim-web-indent'
Plug 'reinh/vim-makegreen'
Plug 'strycore/django.vim'
Plug 'tomasr/molokai'
Plug 'freeo/vim-kalisi'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'cakebaker/scss-syntax.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'digitaltoad/vim-jade'
Plug 'marijnh/tern_for_vim'
Plug 'jaxbot/semantic-highlight.vim'
Plug 'tkztmk/vim-vala'

Plug 'nvie/vim-flake8'
Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_guide_size = 4

Plug 'kien/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
let g:ctrlp_working_path_mode = 2
let g:ctrlp_extensions = ['funky']
nnoremap <A-p> :CtrlPFunky<Cr>

Plug 'The-NERD-tree'
let g:NERDTreeWinSize = 25
let g:NERDTreeIgnore = ['^tags$', '^PYSMELLTAGS']

Plug 'scrooloose/syntastic'
let g:syntastic_check_on_open=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_auto_jump=0
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = "--max-line-length=80"
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_rst_checkers = ['rstcheck']

Plug 'bling/vim-airline'
let g:airline_powerline_fonts = 1

Plug 'davidhalter/jedi-vim'
let g:jedi#show_call_signatures = 0
let g:jedi#popup_on_dot = 0

Plug 'junegunn/goyo.vim'

call plug#end()

filetype plugin indent on
syntax on

" == User Interface
set history=1000                    " Keep 1000 lines of history
set undolevels=1000
set clipboard+=unnamed
set ruler
set hidden                          " Don't whine when trying to move away from an unsaved buffer
set showcmd
set showmode
set showmatch                       " Show matching brackets
set nowrap                          " Don't wrap long lines

set matchpairs+=<:>                 " Show matching <> as well
set title
set noerrorbells visualbell t_vb=   " No noise
set cursorline                      " Highlight current line

set mouse=a                         " Enable the mouse for everything
set cmdheight=2                     " Make command line 2 lines high
set laststatus=2                    " always show status line
set scrolloff=3                     " Keep 3 lines below and above the cursor
set autoread                        " Autoreload changed files
set winwidth=85

set t_Co=256
set background=dark
colorscheme kalisi

" == Identation and tabs
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=79
set shiftround
set expandtab
set backspace=indent,eol,start

" == Searching
set ignorecase                      " Ignore case when searching
set smartcase                       " Ignore case if search pattern is all lowercase,
                                    " Case-sensitive otherwise
set hlsearch                        " Highlight search terms
nmap <silent> <Leader>/ :nohlsearch<CR>
set incsearch
set gdefault                        " Search all occurrences by default

set foldmethod=indent               " Indentation based folding
set foldlevelstart=99               " Start editing with no fold closed

inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

set wildmenu
set wildmode=longest:full,list
set wildignore+=*.bak,*.class,*.aux,*.out,*.toc,*.jpg,*.bmp,*.gif,*.png,*.luac
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.pyc,*.spl,*.sw?

set nobackup    " Backup files are sooo 90's
set noswapfile  " Swap files are very annoying

set number
set numberwidth=1
set shortmess+=a
set report=0
set confirm
set encoding=utf8
set showfulltag
set lisp        " Autocomplete words separated with a dash
set iskeyword+=-

" don't outdent hashes
inoremap # #

let mapleader=" "
let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
let g:showmarks_enable = 1

" Copy to clipboard
map <leader>y "+y
map <leader>c "+y

" Paste from clipboard
map <leader>p "+gP
map <leader>v "+gP

" <Leader>e brings up my .vimrc
" <Leader>E reloads it -- making all changes active (have to save first)
map <leader>e :sp ~/.vimrc<CR><C-W>_
map <silent> <leader>E :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

map <leader>g :YcmCompleter GoToDefinition<CR>
map <leader>G :YcmCompleter GoToDeclaration<CR>

highlight BadWhitespace ctermbg=red guibg=red
let python_highlight_builtin_funcs = 1
let python_print_as_function = 1
let python_highlight_builtin_objs = 1
let python_highlight_doctests = 1
let python_highlight_string_templates = 1

let php_sql_query=1
let php_htmlInStrings=1
let g:php_folding=2

map <silent> <S-F8> :w<CR>:make<CR>:cw<CR>
" let g:molokai_original=1

""" Keybindings
" Disable ex mode
map Q <Nop>
map :W<CR> :w<CR>

" Stuff to piss off vim purists
inoremap <silent> <C-Backspace> <C-w>
inoremap <silent> <C-z> <Esc>:undo<CR>i
inoremap <S-Left> <C-Left>
inoremap <S-Right> <C-Right>

filetype indent on
set formatoptions-=t " Don't do automatic linebreaks
map <leader>w :set formatoptions+=t<CR>
"
" Add the virtualenv's site-packages to vim path
if has('python')
py << EOF
import os.path
import sys
import vim
sys.path.insert(0, os.path.expanduser('~/.cache/fakegir'))
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

function! FixVimPythonSysModule()
""" Certain modules which rely on sys.real_prefix to exist will raise
""" AttributeErrors on import, and subsequently fail to be imported
""" correctly. Likewise, pythoncomplete won't work correctly when
""" it fails to import a module for whatever reason. This function
""" monkey-patches the sys module to make sure it has a useful
""" 'real_prefix' attribute.
python << EOL
import os, sys
from distutils.sysconfig import get_python_lib
if not hasattr(sys, 'real_prefix'):
    sys.real_prefix = os.path.dirname(get_python_lib())
EOL
endfunction
call FixVimPythonSysModule()

endif

" Load up virtualenv's vimrc if it exists
if filereadable($VIRTUAL_ENV . '/.vimrc')
    source $VIRTUAL_ENV/.vimrc
endif

set completeopt=menu,longest,preview
set omnifunc=syntaxcomplete#Complete

autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab "Makefiles require hard tabs
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType php setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType html setlocal indentkeys-=*<Return>

autocmd FileType sh nmap <F10> :!. %<CR>

autocmd FileType c set omnifunc=ccomplete#Complete
autocmd Filetype c nmap <F8> :YcmDiags<CR>

autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags

augroup invisible_chars "{{{
    au!

    " Show invisible characters in all of these files
    autocmd filetype vim setlocal list
    autocmd filetype python,rst setlocal list
    autocmd filetype ruby setlocal list
    autocmd filetype javascript,css setlocal list
    autocmd BufRead,BufNewFile *.js SemanticHighlight
augroup end "}}}

augroup vim_files "{{{
    au!

    " Bind <F1> to show the keyword under cursor
    " general help can still be entered manually, with :h
    autocmd filetype vim noremap <buffer> <F1> <Esc>:help <C-r><C-w><CR>
    autocmd filetype vim noremap! <buffer> <F1> <Esc>:help <C-r><C-w><CR>
augroup end "}}}

augroup python_files
    au!

    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd BufRead,BufNewFile *.py  set ai sw=4 sts=4 et
    autocmd BufRead,BufNewFile *.wsgi setfiletype python
    autocmd BufRead,BufNewFile *.py SemanticHighlight

    " Remove trailing whitespace on save
    autocmd BufWritePre *.py :%s/\s\+$//e
    autocmd BufRead *.py set errorformat=%f:%l:\ %m
    autocmd FileType python map <buffer> <F8> :call Flake8()<CR>
    " Filetype was set to python.django only for django projects but files
    " with the python filetype wouldn't get proper autocompletion. I'm
    " suspecting a bug in YouCompleteMe. In the meantime, setting the
    " filetype to python.django provide better results for every Python file.
    autocmd FileType python set ft=python.django " For SnipMate
    if filereadable('./manage.py')
        autocmd FileType html set ft=htmldjango.html " For SnipMate
        autocmd FileType jade set ft=jade.htmldjango " For SnipMate
        " Use django unittest compiler
        autocmd BufNewFile,BufRead *.py compiler django
        " Run unittest with the current editing app
        nmap <Leader>t :call DjangoMakeGreen("%")<CR>
        " Run unittest with whole project
        nmap <Leader>T :call DjangoMakeGreen(".")<CR>
    else
        autocmd BufNewFile,BufRead *.py compiler pyunit
        nmap <Leader>t :call MakeGreen("%")<CR>
        nmap <Leader>T :call MakeGreen(".")<CR>
    endif
augroup end


augroup rst_files "{{{
    au!
    " Auto-wrap text around 74 chars
    autocmd filetype rst setlocal formatoptions+=nqt
augroup end " }}}

autocmd FileType htmldjango setlocal ts=2 sts=2 sw=2 expandtab

autocmd BufRead *.js set makeprg=eslint\ %
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType javascript map <buffer> <F8> :w<CR>:JSHint<CR>
autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab

autocmd BufNewFile,BufRead *.coffee setfiletype coffee
autocmd BufRead *.coffee setfiletype coffee
autocmd FileType coffee setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType coffee set omnifunc=javascriptcomplete#CompleteJS

autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType html set equalprg=tidy\ -i\ -q

autocmd FileType html nmap <F10> :!firefox %<CR>

autocmd BufNewFile,BufRead *.rss setfiletype xml

" CSS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType css set equalprg=csstidy
autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab

" LessCSS
autocmd BufNewFile,BufRead *.less setfiletype css
"autocmd FileType less set omnifunc=csscomplete#CompleteCSS
"autocmd FileType less setlocal ts=2 sts=2 sw=2 expandtab

" SASS / SCSS
autocmd BufRead,BufNewFile *.scss set filetype=scss
autocmd FileType scss setlocal ts=2 sts=2 sw=2 expandtab

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

" Closes the Omni-Completion tip window when a selection is made
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

if has("gui_running")
    highlight SpellBad term=underline gui=undercurl guisp=Orange
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
    set background=dark
    set lines=60 columns=99
    autocmd GUIEnter * set visualbell t_vb=
    colorscheme kalisi
    set guioptions-=T
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R
    set guioptions-=m
    set guioptions-=M
endif

" Highlight long lines
if exists('+colorcolumn')
    set colorcolumn=81
    highlight ColorColumn ctermbg=darkgray guibg=#4E4E4E
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>81v.\+', -1)
endif
highlight WhitespaceEOL ctermbg=red guibg=red

" Invisible characters
set listchars=tab:▸\ ,trail:.,extends:#,nbsp:.,eol:¬
nmap <leader>l :set list!<CR>

map <Leader>s :SemanticHighlightToggle<CR>

" Creating underline/overline headings for markup languages
" Inspired by http://sphinx.pocoo.org/rest.html#sections
nnoremap <leader>1 yyPVr=jyypVr=
nnoremap <leader>2 yyPVr*jyypVr*
nnoremap <leader>3 yypVr=
nnoremap <leader>4 yypVr-
nnoremap <leader>5 yypVr^
nnoremap <leader>6 yypVr"

" Filetype switching
nmap <leader>fa :filetype detect<CR>
nmap <Leader>fd :set ft=htmldjango.html<CR>
nmap <Leader>fj :set ft=javascript<CR>
nmap <Leader>fh :set ft=html<CR>

" Python & Django helpers
" -----------------------

" Arguments to dict
map <Leader>ad :s#\(\w\+\)=#'\1': #<CR>
" And back again
map <Leader>da :s#'\(\w\+\)'\: #\1=#<CR>

vmap <Leader>tr c{% trans "" %}<Esc>hhhhp
vmap <Leader>bt c{% blocktrans %}<CR>{% endblocktrans %}<Esc>kp
vmap <Leader>%  c{%  "" %}<Esc>hhhhpF"hi
vmap <Leader>{  c{{  }}<Esc>hhhpi

map <Leader>' ^i'<Esc>ea':<Esc>wi"<Esc>A",<Esc>
" Subsitute fancy quotes to regular quotes
vmap <Leader>qu :s/’/'/e<CR>gv:s/[“”]/"/e<CR>gv

" I think this part remove useless trailing spaces
autocmd BufRead * silent! %s/[\r \t]\+$//
autocmd BufEnter *.php :%s/[ \t\r]\+$//e

map <silent> <A-Right> :tabnext<CR>
map <silent> <A-Left> :tabprevious<CR>

inoremap <C-Right> <C-o>B
inoremap <C-Left> <C-o>W

noremap <silent> <C-Down> <C-T>     " Jump to tag
noremap <silent> <C-Up> <C-]>       " Jump back from tag

noremap <C-PageUp> gT
noremap <C-pageDown> gt

map <kPlus> <C-W>+
map <kMinus> <C-W>-
map <kDivide> <c-w>>
map <kMultiply> <c-w><

" Allow moving in insert mode with home row keys
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

" Tagbar configuration
map <silent> <F4> :TagbarToggle<CR>

" json formating
map <leader>jt  <Esc>:%!json_xs -f json -t json-pretty<CR>

" Toggle NerdTree
map <silent> <F2> :bd<CR>
map <silent> <F3> :NERDTreeToggle<CR>

" Move between buffers
map <silent> <F5> :bprevious<CR>
map <silent> <F6> :bnext<CR>

" Toggle paste mode
set pastetoggle=<F7>

" Search with Zeal
nnoremap gz :!zeal --query "<cword>"&<CR><CR>

" Save file with sudo
cmap w!! w !sudo tee % > /dev/null

set path=$PWD/**

let s:pattern = '^\(.* \)\([1-9][0-9]*\)$'
let s:minfontsize = 6
let s:maxfontsize = 16
function! AdjustFontSize(amount)
  if has("gui_gtk2") && has("gui_running")
    let fontname = substitute(&guifont, s:pattern, '\1', '')
    let cursize = substitute(&guifont, s:pattern, '\2', '')
    let newsize = cursize + a:amount
    if (newsize >= s:minfontsize) && (newsize <= s:maxfontsize)
      let newfont = fontname . newsize
      let &guifont = newfont
    endif
  else
    echoerr "You need to run the GTK2 version of Vim to use this function."
  endif
endfunction

function! LargerFont()
  call AdjustFontSize(1)
endfunction
command! LargerFont call LargerFont()

function! SmallerFont()
  call AdjustFontSize(-1)
endfunction
command! SmallerFont call SmallerFont()

map <silent> <C-S-Up> :LargerFont<CR>
map <silent> <C-S-Down> :SmallerFont<CR>
