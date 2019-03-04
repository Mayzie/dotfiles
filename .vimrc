set t_Co=256			" Force 256 colour support
set shell=/bin/bash		"
set nocompatible		" Use Vim defaults instead of 100% vi compatibility
set backspace=indent,eol,start	" more powerful backspacing

set ruler
set relativenumber
set bg=dark

set colorcolumn=110
set cursorcolumn
set cursorline

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast

set ignorecase
set smartcase

highlight CursorColumn cterm=NONE ctermbg=233
highlight CursorLine cterm=NONE ctermbg=233
" ctermfg=white
highlight ColorColumn ctermbg=darkgrey
highlight HiTab ctermfg=234

match HiTab /\t/

set list
set listchars=tab:>-
set hidden

set autoread
set mousemodel=popup

augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync fromstart
augroup END

"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

augroup vimrc-wrapping
  autocmd!
  autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

filetype plugin indent on
syntax enable

call plug#begin('~/.vim/plugged')
" Load ViM plugins here.

"" Core plugins
Plug 'scrooloose/nerdtree' | Plug 'Xuyuanp/nerdtree-git-plugin' | Plug 'jistr/vim-nerdtree-tabs'	" NERD Tree + Git support.
Plug 'scrooloose/nerdcommenter'	" NERD Commenter.
"Plug 'scrooloose/syntastic', {'for': ['python', 'sql', 'json', 'javascript']}
Plug 'bling/vim-airline'	" Airline. Better interface.
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'majutsushi/tagbar', {'for': ['python', 'c', 'cpp', 'html', 'javascript', 'sql']}
Plug 'godlygeek/tabular'
Plug 'Valloric/YouCompleteMe', {'do': './install.py --clang-completer --system-libclang --system-boost --tern-completer', 'for': ['python', 'c', 'cpp', 'javascript', 'sql']}
"Plug 'klen/python-mode', {'for': ['python']}
Plug 'hdima/python-syntax', {'for': ['python']}
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'w0rp/ale', {'for': ['python', 'javascript', 'sql']}
Plug 'mbbill/undotree'

Plug 'dart-lang/dart-vim-plugin', {'for': ['dart']}
Plug 'reisub0/hot-reload.vim', {'for': ['dart']}

call plug#end()

" Permanent settings

let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1


if has('python')
py << EOF
import sys
import os
if 'VIRTUAL_ENV' in os.environ:
    sys.path.insert(0, os.environ['VIRTUAL_ENV'] + '/lib/python3.6')
EOF
endif

"" Automatically show NERDTree when ViM starts up
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p	" Switch focus to the main window.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:nerdtree_tabs_open_on_console_startup = 1
let g:nerdtree_tabs_smart_startup_focus = 1
let g:nerdtree_tabs_open_on_new_tab = 1

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline_theme = 'bubblegum'

nmap <leader>T :enew<CR>
nmap <leader>l :bnext<CR>
nmap <leader>p :bprevious<CR>
nmap <leader>q :bp <BAR> bd #<CR>

set guifont=InconsolataForPowerline\ Nerd\ Font\ 9

let g:tagbar_autopreview = 1

"" YouCompleteMe settings
let g:ycm_show_diagnostics_ui = 1
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_enable_diagnostic_highlighting = 1
let g:ycm_goto_buffer_command = 'same-buffer'
let g:ycm_python_binary_path = 'python'

nmap <leader>d :YcmCompleter GoTo<CR>

"" Syntastic settings
"""set statusline+=%#warningmsg#
"""set statusline+=%{SyntasticStatuslineFlag()}
"""set statusline+=%*
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_python_checkers = ['pylint']
let g:syntastic_python_pylint_exec = 'python'
let g:syntastic_python_pylint_args = ['/usr/lib/python3.10/site-packages/pylint/lint.py']
let g:syntastic_json_checkers = ['jsonlint']

let g:syntastic_always_populate_loc_list=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'
let g:syntastic_auto_loc_list=1
let g:syntastic_aggregate_errors = 1

" Python settings
let python_highlight_all = 1
"let g:pymode_python = 'python3'
"let g:pymode_virtualenv_path = $VIRTUAL_ENV

let g:airline#extensions#ale#enabled = 1
let g:ale_open_list = 1
"let g:ale_set_quickfix = 1

" UndoTree settings
nmap <leader>u :NERDTreeToggle<CR>:UndotreeToggle<CR>

set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//
