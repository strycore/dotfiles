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
" F4:  Available
" F5:  Previous buffer
" F6:  Next buffer
" F7:  Toggle paste mode
" F8:  Run Linter (Flake8, CoffeeLint, …)
" F9:  Toggle semantic highlighting
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
" <Leader>f  format the current file with ALEFix
" <Leader>tr Wrap selection in Django 'trans' templatetag
" <Leader>%  Wrap selection in generic {%  %} templatetag
" <Leader>{  Wrap selection in generic {{  }} templatetag
" <Leader>'  Transform a 2-column text line to a dict like syntax
" <Leader>ad Transform function arguments to dict syntax
" <Leader>da Transform dict syntax to function argument syntax
" :w!! save file with sudo
"
call plug#begin('~/.vim/plugged')

Plug 'alvan/vim-closetag'
Plug 'chazy/cscope_maps'
Plug 'Valloric/MatchTagAlways'

Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1

" Syntax plugins
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['javascript']

" Lenguage support
Plug 'othree/html5.vim'  " HTML 5
Plug 'nvie/vim-flake8'  " Python
Plug 'larsbs/vim-xmll'  " XML
Plug 'jelera/vim-javascript-syntax'  " JavaScript
Plug 'pangloss/vim-javascript' " JavaScript
Plug 'marijnh/tern_for_vim'  " JavaScript
Plug 'cakebaker/scss-syntax.vim'  " SASS
Plug 'heavenshell/vim-jsdoc'  " JSDoc
Plug 'JulesWang/css.vim'  " CSS
Plug 'genoma/vim-less'  " LessCSS
Plug 'kchmck/vim-coffee-script' " CoffeeScript
Plug 'Quramy/tsuquyomi'  " TypeScript
Plug 'tpope/vim-rails'  " Ruby on rails

Plug 'mattn/emmet-vim'
Plug 'rking/ag.vim'
map <C-f> <esc>:Ag<space>

Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-bundler'

Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<c-s>"
Plug 'tomtom/tlib_vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'honza/vim-snippets'
Plug 'reinh/vim-makegreen'

Plug 'larsbs/vimtom'
Plug 'tomasr/molokai'
Plug 'freeo/vim-kalisi'

Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'
Plug 'jaxbot/semantic-highlight.vim'
let g:semanticPersistCache=1
Plug 'junegunn/goyo.vim'
Plug 'Raimondi/delimitMate'

Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_guide_size = 4

Plug 'ctrlpvim/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
let g:ctrlp_working_path_mode = 2
let g:ctrlp_extensions = ['funky']
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/]node_modules$'
  \ }
nnoremap <A-p> :CtrlPFunky<Cr>

Plug 'majutsushi/tagbar'
nmap <F4> :TagbarToggle<CR>

Plug 'scrooloose/nerdtree'
let g:NERDTreeWinSize = 25
let g:NERDTreeIgnore = ['^tags$', '^PYSMELLTAGS', '\.pyc$', '__pycache__', 'htmlcov', '.*\.egg-info']

Plug 'w0rp/ale'
let g:ale_sign_error = '💥'
let g:ale_sign_warning = '🚫'
highlight clear ALEErrorSign

let g:ale_fixers = {
\   'vue': ['prettier'],
\   'javascript': ['prettier'],
\   'css': ['prettier'],
\   'html': ['prettier'],
\}
nmap <silent> <Leader>f :ALEFix<CR>

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

Plug 'vim-airline/vim-airline'
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1

Plug 'ryanoasis/vim-devicons'
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_enable_airline = 1
let g:webdevicons_enable_ctrlp = 1
let g:WebDevIconsUnicodeDecorateFileNodes = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1

Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
let g:NERDTreeHighlightFolders = 1

Plug 'Quramy/vim-js-pretty-template'

call plug#end()

filetype plugin indent on
syntax on

call jspretmpl#register_tag('html', 'html')
autocmd FileType javascript JsPreTmpl html
autocmd FileType javascript.jsx JsPreTmpl html

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
set exrc                            " Enable project specific vimrc files
set secure                          " Disable dangerous commands in project specific vimrc
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

set wildmenu
set wildmode=longest:full,list
set wildignore+=*/tmp/*,*.bak,*.class,*.aux,*.out,*.toc,*.jpg,*.bmp,*.gif,*.png,*.luac
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.pyc,*.spl,*.sw?,*/htmlcov/*,*/build/*

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
map <leader>p "+gp
map <leader>v "+gp

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
command W w
command Q q
command WQ wq
command Wq wq

" Stuff to piss off vim purists
inoremap <silent> <C-Backspace> <C-w>
inoremap <silent> <C-z> <Esc>:undo<CR>i
inoremap <S-Left> <C-Left>
inoremap <S-Right> <C-Right>

set formatoptions-=t " Don't do automatic linebreaks
map <leader>w :set formatoptions+=t<CR>

" Add support for fakegir (https://github.com/strycore/fakegir/)
if filereadable(expand("~/.cache/fakegir/gi/__init__.py"))
    let $PYTHONPATH = expand("~/.cache/fakegir/")
endif

" Add the virtualenv's site-packages to vim path
if has('python')
py << EOF
import os.path
import sys
import vim
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

set complete-=i  " Testing this setting, if not the desired behavior, make this exclusive to FASTVIM
set completeopt=menu,longest,preview
set omnifunc=syntaxcomplete#Complete

autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab "Makefiles require hard tabs
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType php setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType xhtml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType html setlocal indentkeys-=*<Return>

autocmd FileType sh nmap <F10> :!. %<CR>

autocmd FileType c set omnifunc=ccomplete#Complete
autocmd Filetype c nmap <F8> :YcmDiags<CR>

autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags

augroup polymer
    autocmd!
    if filereadable('./polymer.json')
        autocmd FileType html set makeprg=polymer\ lint\ %
        map <silent> <F8> :w<CR>:make<CR>:cw<CR>
    endif

augroup end

augroup invisible_chars "{{{
    autocmd!

    " Show invisible characters in all of these files
    autocmd filetype vim setlocal list
    autocmd filetype python,rst setlocal list
    autocmd filetype ruby setlocal list
augroup end "}}}

augroup ruby_files
    autocmd!
    autocmd BufWritePre *.rb :%s/\s\+$//e " Remove trailing whitespace on save
    autocmd BufRead,BufNewFile *.rb SemanticHighlight
augroup end

augroup vim_files "{{{
    au!
    " Bind <F1> to show the keyword under cursor
    " general help can still be entered manually, with :h
    autocmd filetype vim noremap <buffer> <F1> <Esc>:help <C-r><C-w><CR>
    autocmd filetype vim noremap! <buffer> <F1> <Esc>:help <C-r><C-w><CR>
augroup end "}}}

augroup python_files
    autocmd!

    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd BufRead,BufNewFile *.py  set autoindent sw=4 sts=4 expandtab
    autocmd BufRead,BufNewFile *.wsgi setfiletype python
    autocmd BufRead *.py SemanticHighlightToggle

    autocmd BufWritePre *.py :%s/\s\+$//e " Remove trailing whitespace on save
    autocmd BufRead *.py set errorformat=%f:%l:\ %m
    autocmd FileType python map <buffer> <F8> :call Flake8()<CR>
    " Filetype was set to python.django only for django projects but files
    " with the python filetype wouldn't get proper autocompletion. I'm
    " suspecting a bug in YouCompleteMe. In the meantime, setting the
    " filetype to python.django provide better results for every Python file.
    autocmd FileType python set ft=python.django " For SnipMate
    if filereadable('./manage.py')
        autocmd FileType html set ft=javascript.htmldjango.html " For SnipMate
        autocmd BufRead,BufNewFile *.html SemanticHighlight
    else
        autocmd BufNewFile,BufRead *.py compiler pyunit
        nmap <Leader>t :call MakeGreen("%")<CR>
        nmap <Leader>T :call MakeGreen(".")<CR>
    endif
augroup end


augroup rst_files "{{{
    autocmd!
    " Auto-wrap text around 74 chars
    autocmd filetype rst setlocal formatoptions+=nqt
augroup end " }}}

augroup javascript_files
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    "autocmd FileType javascript map <buffer> <F8> :w<CR>:JSHint<CR>
    autocmd FileType javascript nmap <silent> <leader>j ?function<cr>:noh<cr>:JsDoc<cr>
    autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType typescript setlocal ts=2 sts=2 sw=2 expandtab
    autocmd BufRead *.js set makeprg=eslint\ %
    autocmd filetype javascript,css setlocal list
    autocmd FileType javascript setlocal iskeyword+=$
    autocmd BufRead,BufNewFile *.js SemanticHighlight
augroup end

autocmd FileType htmldjango setlocal ts=2 sts=2 sw=2 expandtab

autocmd BufNewFile,BufRead *.coffee setfiletype coffee
autocmd BufRead *.coffee setfiletype coffee
autocmd FileType coffee setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType coffee set omnifunc=javascriptcomplete#CompleteJS

autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType html set equalprg=tidy\ -config\ ~/.tidy.conf\ -indent\ -quiet

autocmd FileType html nmap <F10> :!firefox %<CR>

autocmd BufNewFile,BufRead *.rss setfiletype xml

" CSS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType css set equalprg=csstidy
autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
autocmd BufWritePre *.css :%s/\s\+$//e
autocmd BufWritePre *.less :%s/\s\+$//e
autocmd BufWritePre *.html :%s/\s\+$//e

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
    set guifont=mononoki\ Nerd\ Font\ Regular\ 14
    set background=dark
    autocmd GUIEnter * set visualbell t_vb=
    colorscheme vimtom
    set guioptions-=T
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R
    set guioptions-=m
    set guioptions-=M
endif

if has("gui_macvim")
    set guifont=mononoki\ Nerd\ Font:h16
endif


" Highlight long lines
if exists('+colorcolumn')
    set colorcolumn=120
    highlight ColorColumn ctermbg=darkgray guibg=#4E4E4E
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>91v.\+', -1)
endif
highlight WhitespaceEOL ctermbg=red guibg=red

" Makes a nice vertical separator
set fillchars+=vert:▕

" Invisible characters
set listchars=tab:→\ ,trail:␣,extends:…,eol:⏎
nmap <leader>l :set list!<CR>

map <Leader>s :SemanticHighlightToggle<CR>
map <F9> :SemanticHighlightToggle<CR>

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

" Jump to  prev/next word with Ctrl+right/left
inoremap <C-Right> <C-o>B
inoremap <C-Left> <C-o>W

noremap <silent> <C-Down> <C-T>     " Jump to tag
noremap <silent> <C-Up> <C-]>       " Jump back from tag

noremap <C-PageUp> gT
noremap <C-pageDown> gt

" json formating
map <leader>jt  <Esc>:%!json_xs -f json -t json-pretty<CR>

" Toggle NerdTree
map <silent> <F2> :bdelete<CR>
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
  if has("gui_running")
    let fontname = substitute(&guifont, s:pattern, '\1', '')
    let cursize = substitute(&guifont, s:pattern, '\2', '')
    let newsize = cursize + a:amount
    if (newsize >= s:minfontsize) && (newsize <= s:maxfontsize)
      let newfont = fontname . newsize
      let &guifont = newfont
    endif
  else
    echoerr "You need to run the GUI version of Vim to use this function."
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
