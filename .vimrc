" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Vim will load $VIMRUNTIME/defaults.vim if the user does not have a vimrc.
" This happens after /etc/vim/vimrc(.local) are loaded, so it will override
" any settings in these files.
" If you don't want that to happen, uncomment the below line to prevent
" defaults.vim from being loaded.
" let g:skip_defaults_vim = 1

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden		" Hide buffers when they are abandoned
set hlsearch		" Highlight search
set expandtab
set shiftwidth=2
set softtabstop=2
set smarttab
set nowrap
set linebreak
set autoindent
set smartindent
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
set virtualedit=all
set nosol
set wildmenu

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","
let maplocalleader = ","
let g:maplocalleader = ","

" Paste yanked text multiple times
xnoremap p pgvy

" https://stackoverflow.com/a/5563142/52598
" Now a Tab let you go to the next buffer and a Shift-Tab to the previous.
nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>

" Populate the prompt with all loaded buffers and wait for a buffer to select
nnoremap <leader>b :ls<cr>:b<space>
nnoremap <leader>vb :ls<cr>:vert sb <space>

" Avoid the cursor keys when recalling commands from history
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Carriage return
nnoremap <c-cr> i<cr><esc>

" Fast editing and sourcing of the .vimrc
nnoremap <leader>ev :e $VIM/vimrc<cr>
nnoremap <leader>sv :so $VIM/vimrc<cr>

" Smart way to move btw. windows
 noremap <c-j> <c-w>j
 noremap <c-k> <c-w>k
 noremap <c-h> <c-w>h
 noremap <c-l> <c-w>l

" Replace <esc> with kj
inoremap kj <esc>

" Close the current buffer
noremap <leader>bd :Bclose<cr>
" Close all the buffers (No warnings)
noremap <leader>ba :%bd!<cr>

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
  let l:currentBufNum = bufnr("%")
  let l:alternateBufNum = bufnr("#")
  if buflisted(l:alternateBufNum)
    buffer #
  else
    bnext
  endif
  if bufnr("%") == l:currentBufNum
    new
  endif
  if buflisted(l:currentBufNum)
    execute("bdelete! ".l:currentBufNum)
  endif
endfunction
