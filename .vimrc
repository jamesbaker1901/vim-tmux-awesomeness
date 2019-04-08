set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=/Users/jaybaker/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required

Plugin 'VundleVim/Vundle.vim'

"status line
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

"Language Support
Plugin 'fatih/vim-go'
Plugin 'rust-lang/rust.vim'

"Coding help
Plugin 'AndrewRadev/splitjoin.vim' "turn single line into multiline code
Plugin 'Raimondi/delimitMate' "auto-close delimiters
Plugin 'tpope/vim-fugitive' "git helper
Plugin 'kien/ctrlp.vim' "fuzzy finder
Plugin 'nvie/vim-flake8' "python syntax & style checker
Plugin 'scrooloose/syntastic' "multi lang syntax checker
Plugin 'scrooloose/nerdtree' "file browswer
Plugin 'Valloric/YouCompleteMe'
"Plugin 'airblade/vim-gitgutter' "show git diff in gutter
Plugin 'jpalardy/vim-slime' "send commands to tmux

"General
Plugin '907th/vim-auto-save'
Plugin 'tpope/vim-obsession' "save vim session
Plugin 'tmux-plugins/vim-tmux-focus-events' "fixes FocusGained and FocusLost events
Plugin 'farmergreg/vim-lastplace.git' "saves cursor position
Plugin 'mattn/webapi-vim' "make http calls from vim

"Editing
Plugin 'jeffkreeftmeijer/vim-numbertoggle' "toggles relative or static line nums

"DSLs
Plugin 'hashivim/vim-terraform'
Plugin 'hashivim/vim-consul'
Plugin 'hashivim/vim-nomadproject'
Plugin 'cespare/vim-toml'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'plasticboy/vim-markdown'

"Themes
Plugin 'Marfisc/vorange'
Plugin 'reedes/vim-thematic'
Plugin 'ntk148v/vim-horizon'
Plugin 'morhetz/gruvbox'
Plugin 'agude/vim-eldar'
Plugin 'Nequo/vim-allomancer'
Plugin 'sainnhe/vim-color-forest-night'
Plugin 'tomasr/molokai'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"general options
syntax on
set encoding=utf-8
set number
set t_Co=256
set term=xterm-256color
set ttyfast                     " Indicate fast terminal conn for faster redraw
set ttymouse=xterm2             " Indicate terminal type for mouse codes
set mouse=a			" enable mouse
set ttyscroll=3                 " Speedup scrolling
set laststatus=2                " Show status line always
set encoding=utf-8              " Set default encoding to UTF-8
set autoread                    " Automatically read changed files
set autoindent                  " Enabile Autoindent
set backspace=indent,eol,start  " Makes backspace key more powerful.
set incsearch                   " Shows the match while typing
set hlsearch                    " Highlight found searches
set noerrorbells                " No beeps
set number                      " Show line numbers
set showcmd                     " Show me what I'm typing
set noswapfile                  " Don't use swapfile
set nobackup                    " Don't create annoying backup files
set splitright                  " Vertical windows should be split to right
set splitbelow                  " Horizontal windows should split to bottom
set autowrite                   " Automatically save before :next, :make etc.
set hidden                      " Buffer should still exist if window is closed
set fileformats=unix,dos,mac    " Prefer Unix over Windows over OS 9 formats
set noshowmatch                 " Do not show matching brackets by flickering
set noshowmode                  " We show the mode with airline or lightline
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not it begins with upper case
set completeopt=menu,menuone    " Show popup menu, even if there is one entry
set pumheight=10                " Completion window max size
set nocursorcolumn              " Do not highlight column (speeds up highlighting)
set nocursorline                " Do not highlight cursor (speeds up highlighting)
set lazyredraw                  " Wait to redraw
set clipboard=unnamed 		"use system clipboard
set nofoldenable		"turn off folding
let mapleader = ","		"remap leader to ,
 
" go stuff
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
"let g:go_fmt_command = "goimports"

"slime send to tmux stuff
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}

" sends ctrl+c to the right pane in tmux
nmap <c-c> :!tmux send-keys -t right C-c<CR><CR>
" sends ctrl+l for clear to the right pane in tmux
nmap <c-l> :SlimeSend0 "<c-l>"<CR>
" send ll, shortcut for 'exa -bghHliS'
"nmap <buffer> <c-l> :SlimeSend1 ll<CR>


"file type dependent key mappings
"go

"when opening a .go file, call SlimeSend first so we can hit enter twice to
"set the default pane
autocmd VimEnter *.go SlimeSend0 "clear" <CR>
autocmd FileType go nmap <c-u> :SlimeSend1 go build<CR>
"requires you to create the hidden file .run.sh with the command to run the
"program
autocmd FileType go nmap <c-r> :SlimeSend1 go build && ./.run.sh<CR>
autocmd FileType go nmap <c-t>t :SlimeSend1 go test<CR>

"rust
autocmd FileType rust nmap <buffer> <leader>b :SlimeSend1 cargo build<CR>
autocmd FileType rust nmap <buffer> <leader>r :SlimeSend1 cargo build && ./.run.sh<CR>
autocmd FileType rust nmap <buffer> <leader>t :SlimeSend1 cargo test<CR>


" Airline options
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
map <C-n> :NERDTreeToggle<CR>

" Syntax checking
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

au BufNewFile,BufRead *.go
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix|

au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"configure airline
let g:airline_theme="simple"
let g:airline_powerline_fonts = 1

"general tweaks
set cursorline "highligh the current line

"general remaps
imap ;; <esc>
"next buffer
noremap <C-j> :bn<CR> 
"previous buffer
noremap <C-k> :bp<CR>
"close buffer
noremap <C-d> :bd<CR>
"exit normal mode
imap <RightMouse> <Esc>
"enter insert mode
nmap <RightMouse> i<LeftMouse>

"choose theme
colorscheme molokai
