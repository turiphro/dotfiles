"vimrc - Martijn van der Veen

set nocompatible

"indentation
set tabstop=4
set shiftwidth=4
set expandtab
set number
set autoindent
set smartindent

"layout and search
set hlsearch
set incsearch
set smartcase
"set foldmethod=syntax
set foldlevelstart=1
set wildmenu
set wildmode=list:longest,full
set ignorecase
set cursorline
syntax enable
set term=screen-256color

"divers
set mouse=a
set scrolloff=5 "autoscroll when approaching bottom/top
set shell=bash  "only used by vim
set spell spelllang=en_gb "]s for next, z= for suggestions, zg/zw for add/rm to dict
set undofile    "persistent undo after re-opening vim
set undodir=~/.vimundo
if !isdirectory($HOME."/.vimundo")
    call mkdir($HOME."/.vimundo", "", 0700)
endif
set dir=/tmp/   "save tmp files outside of normal directories
                "(solves Java Checkstyle issue); will get cleaned on boot
"copy/paste clipboard
map \y "+y
map \Y "+p

"shortcuts
command! W w
command! Q q
command! WQ wq  " :X already bound
command! Wq wq
"nav windows
nmap \s :sp<CR>
nmap \v :vsp<CR>
set splitbelow  "open split screens bottom and right
set splitright
map <c-l> <c-w>l
map <c-h> <c-w>h
map <c-k> <c-w>k
map <c-j> <c-w>j
imap <M-S-Right> <ESC><c-w>l
imap <M-S-Left> <ESC><c-w>h
imap <M-S-Up> <ESC><c-w>k
imap <M-S-Down> <ESC><c-w>j
"nav tabs and buffers
nmap <C-b> :bnext<CR>
nmap <C-e> :bprev<CR>
map <C-S-Right> :tabn<CR>
imap <C-S-Right> <ESC>:tabn<CR>
map <C-S-Left> :tabp<CR>
imap <C-S-Left> <ESC>:tabp<CR>
nmap \t :tabe 
"other
nmap \p :set paste!<CR>
nmap \P :set nopaste!<CR>
nmap \n :setlocal number!<CR>
nmap \q :nohlsearch<CR>  " unhighlight search
nmap \w :setlocal wrap!<CR>:setlocal wrap?<CR>

"does not work due to terminal blocking c-s:
"nmap <C-s> :w<CR>
"imap <C-s> <Esc>:w<CR>



" Plugins
execute pathogen#infect()

" set the runtime path to include Vundle and initialize
" let Vundle manage Vundle, required
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
"Plugin 'scrooloose/syntastic'
"call vundle#end()            " required

" Theme
set background=dark "automatic light/dark when starting
" Toggle theme
nmap \b :let &background = ( &background == "dark"? "light" : "dark" )<CR>
"let g:solarized_termcolors = 256  # changes team to fallback to 256 colours
colorscheme solarized "solarized, primary (google), ..


" Status bar
set laststatus=2
let g:airline_theme = 'luna'  "luna/molokai/papercolor
let g:airline_powerline_fonts = 1
"let g:airline#extensions#tabline#enabled = 1 "show buffers when no tabs open

" Plugins with side bars
"NERDTreeToggle doesn't highlight current file; needs conditional
map <expr> <C-n> g:NERDTree.IsOpen() ? ":NERDTreeClose<CR>" : ":NERDTreeFind<CR>"
nnoremap <C-u> :UndotreeToggle<cr>
let g:rooter_manual_only = 1  "stop vim-rooter changing directory to root automatically

" Autocomplete
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neosnippet#disable_runtime_snippets={'_': 1}
let g:SuperTabDefaultCompletionType = "<c-n>"  "scroll top to bottom
"nmap <F5> <Plug>(JavaComplete-Imports-Add)
"nmap <F6> <Plug>(JavaComplete-Imports-AddMissing)
"nmap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
"more tips: https://github.com/artur-shaik/vim-javacomplete2

" Rope
"nnoremap <C-S-o> :RopeOrganizeImports<CR>0<CR><CR>
"nnoremap <C-S-i> :RopeAutoImport<CR>
"let ropevim_vim_completion = 1
"let ropevim_extended_complete = 1
"imap <c-space> <C-R>=RopeCodeAssistInsertMode()<CR>

"Pymode
let g:pymode_rope = 1
let g:pymode_rope_autoimport = 1
let g:pymode_rope_autoimport_import_after_complete = 1
let g:pymode_rope_goto_definition_bind = '<C-c>b'
let g:pymode_rope_goto_definition_cmd = 'tabe'
let g:pymode_rope_autoimport_modules = ["os.*","traceback","django.*","lxml.etree","lxml.*","cv2.*","cv2"]

filetype plugin indent on    " required
set tags=./.tags;./tags;/,tags;/
"save: 1=first tagfile seen in $tags or global, 2=first item in $tags
let g:easytags_dynamic_files = 1
let g:easytags_async = 1
let g:easytags_auto_highlight = 0
let g:easytags_include_members = 1
let g:easytags_events = ['BufWritePost']

let g:go_version_warning = 0

autocmd FileType python setlocal completeopt-=preview
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete  "needs +python
autocmd FileType text,markdown nested NeoCompleteLock
"autocmd FileType java setlocal omnifunc=javacomplete#Complete
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" Note: ACP plugin conflicts with Jedi (chooses first menu option
" automatically), don't install!
" Note: also look at Eclim for Java files
set completeopt=longest,menuone
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<Up>"
"without plugin/autoclose.vim, this breaks arrow keys in edit mode:
""inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
" Python
let g:syntastic_python_python_exec='python3'
let g:syntastic_python_checkers=['py3kwarn', 'flake8', 'mypy'] 
"'compile', 'frosted', 'prospector', 'mypy', 'pyflakes', 'pylama', 'pylint']
let g:syntastic_python_flake8_args="--ignore=E113,E22,E26,E401,E501,E702,F40,W3"
"note: for debugging in Python, look at the Vdebug or vebugger or pyclewn plugins
"(all need some work)
" C++
let g:syntastic_cpp_checkers=['clang_check', 'gcc']
let g:syntastic_cpp_compiler='g++' " g++, clang
let g:syntastic_cpp_compiler_options='-Wall -std=c++17'
let g:syntastic_cpp_check_header=1
let g:syntastic_cpp_config_file='.syntastic_cpp_config'

let g:UltiSnipsExpandTrigger="<tab>"
"warning codes:
"http://pep8.readthedocs.org/en/latest/intro.html#error-codes

" Search
"nmap ; :CtrlPBuffer<CR>
let g:ctrlp_map = '<c-p>'
nnoremap <C-t> :CtrlPTag<CR>
