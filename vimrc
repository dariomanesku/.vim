" ========================================================================
" Plugins not to be loaded
" ========================================================================
let g:pathogen_disabled = []
call add(g:pathogen_disabled, "supertab")
call add(g:pathogen_disabled, "0scan")
call add(g:pathogen_disabled, "minibufexpl")
call add(g:pathogen_disabled, "showmarks")
" ========================================================================

" ========================================================================
" Startup Pathogen
" ========================================================================
call pathogen#infect()
call pathogen#helptags()
" ========================================================================

" ========================================================================
" Common settings
" ========================================================================
syntax on
filetype plugin indent on
colorscheme xoria256
let mapleader = ","

set number       " show line numbers
set ic           " ignore case
set hidden       " enable unsaved buffers (be careful)
set title
set noerrorbells
set showmatch    " show matching braces
set nocompatible

set ignorecase
set smartcase

set cindent
set smartindent

"customize identation
set tabstop=4 
set softtabstop=4
set shiftwidth=4 
set noexpandtab
set autoindent
set copyindent
set smarttab

"current directory is always matching the content of the active window
set autochdir
set autoread "auto reload file contents on external change

"use console dialogs instead of popup dialogs for simple choices
set guioptions+=c "TODO:<<< test

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"use hlsearch but don't enable it by default
set hlsearch
nohlsearch
nmap <silent> <leader>, :silent :nohlsearch<CR>

set virtualedit=all "enable cursor navigation in virtual space

"use English language for spell checking but don't enable it by default
set spl=en spell
set nospell

set wildmenu                   " use wildmenu
set wildmode=list:longest,full " shell like behavior

"disable preview scratch window
set completeopt=menu,menuone,longest

"make default clipboard
set clipboard=unnamedplus

"remap ` to ' (it's more useful this way)
nnoremap ' `
nnoremap ` '

"don't accidently hit this when using visual line selection
map K k 

"insert timestamp (TODO: output some different time format)
nmap <F9> a<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>
imap <F9> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>

"make folding/unfolding easier and faster
set foldmethod=syntax
set foldnestmax=1
set foldlevel=1
nnoremap <space> za

"store temporary files in a central folder 
set backupdir=~/.vim/tmp
set directory=~/.vim/tmp 
" ========================================================================

" ========================================================================
" CScope
" ========================================================================
if has("cscope")
"use cscope by default
set cscopetag
set csto=0 "check scope first, then ctags
"set cscopeverbose

" add any cscope database in current directory
if filereadable("cscope.out")
    cs add cscope.out  
" else add the database pointed to by environment variable 
elseif $CSCOPE_DB != ""
    cs add $CSCOPE_DB
endif

"change this if it gets slow
function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction
au BufEnter /* call LoadCscope()

endif
" ========================================================================

" ========================================================================
" Ctags
" ========================================================================
set tags=./tags;/ "search for tags up to / (change this if it gets slow)
" ========================================================================

" ========================================================================
" Persistant undo
" ========================================================================
au BufWritePre /tmp/* setlocal noundofile
set undodir=~/.vim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload
" ======================================================================== 
         
" ========================================================================
" Buftabs
" ========================================================================
set laststatus=2
"let g:buftabs_in_statusline = 1
let g:buftabs_only_basename = 1
" ======================================================================== 

" ========================================================================
" Status line
" ========================================================================
set statusline=
"set statusline +=%{buftabs#statusline()} 
set statusline +=%-2.3n		 " buffer number
set statusline +=%t          " filename
set statusline +=%m          " modified
set statusline +=%r          " read-only
set statusline +=%=          " delimiter
set statusline +=%p%%        " percent
set statusline +=%=%5l%*     " current line
set statusline +=/%L%*       " total lines
set statusline +=%4c\ %*     " column number
set statusline +=0x%04B\%*\  " character under cursor
" ========================================================================

" ========================================================================
" Custom keyboard shortcuts
" ========================================================================
set pastetoggle=<F5> "TODO: this is just temporary. Remember to change this.

"show non-visual chars
set listchars=tab:>-,trail:',eol:$
nmap <silent> <leader>n :set nolist!<CR> 

nmap <silent> ,ev :e $MYVIMRC<cr>
nmap <silent> ,sv :so $MYVIMRC<cr>
" ========================================================================

" ========================================================================
" Frequent plugin shortcuts
" ========================================================================
silent! nnoremap <silent> <F2> :TlistToggle<CR> 
"silent! nnoremap <silent> <F2> :TlistUpdate<CR> 
silent! nnoremap <silent> <F3> :NERDTreeToggle<CR> 
silent! nnoremap <silent> <F4> :GundoToggle<CR> 
"silent! nnoremap <silent> <leader>ff :CommandT<CR> 
"silent! nnoremap <silent> <leader>bb :CommandTBuffer<CR> 
silent! nnoremap <silent> <leader>jj :FufJumpList<CR> 
silent! nnoremap <silent> <leader>cf :call g:ClangUpdateQuickFix()<CR> 
silent! nmap <silent> <leader>cc :cclose<CR>
" ========================================================================

" ========================================================================
" Clang_complete settings 
" ========================================================================
let g:clang_complete_auto = 1 
let g:clang_complete_copen = 1
let g:clang_hl_errors = 1
let g:clang_periodic_quickfix = 0
let g:clang_snippets = 1
let g:clang_conceral_snippets = 1
let g:clang_user_options = '-I/usr/include/c++/4.6/x86_64-linux-gnu/. -I/usr/include/c++/4.6/backward -I/usr/lib/gcc/x86_64-linux-gnu/4.6.1/include -I/usr/local/include -I/usr/lib/gcc/x86_64-linux-gnu/4.6.1/include-fixed -I/usr/include/x86_64-linux-gnu'
" ======================================================================== 

" ========================================================================
" Gundo settings
" ========================================================================
let g:gundo_width = 60
let g:gundo_preview_height = 40
let g:gundo_right = 1
let g:gundo_close_on_revert = 0 "set this to 1 to automatically close the Gundo windows when reverting.
"let g:gundo_preview_bottom = 1
" ======================================================================== 

" ========================================================================
" Command-t settings
" ========================================================================
let g:CommadTMaxFiles = 90000
let g:CommandTMaxDepth = 20
let g:CommmandTCancelMap = ['<C-c>', '<Esc>']
let g:CommandTMaxHeight = 30
" ========================================================================

" ========================================================================
" NERDTree settings
" ========================================================================
" Store the bookmarks file
" let NERDTreeBookmarksFile=expand("~/.vim/NERDTreeBookmarks")
"
" " Don't display these kinds of files
" let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$',
"             \ '\.o$', '\.so$', '\.egg$', '^\.git$', '\.os$', '\.dylib$',
"             '\.a$' ]
"
" let NERDTreeShowBookmarks=1       " Show the bookmarks table on startup
" let NERDTreeShowFiles=1           " Show hidden files, too
" let NERDTreeShowHidden=1
" let NERDTreeQuitOnOpen=1          " Quit on opening files from the tree
" let NERDTreeHighlightCursorline=1 " Highlight the selected entry in the tree
let NERDTreeWinPos='right'
let NERDTreeWinSize=30 
" ========================================================================

" ======================================================================== 
" Taglist (Tlist)
" ======================================================================== 
let g:Tlist_Use_Right_Window = 0
let g:Tlist_Enable_Fold_Column = 0
let g:Tlist_WinWidth = 35
" ======================================================================== 

" ========================================================================
" Source Explorer
" ========================================================================
" // The switch of the Source Explorer 
nmap <F8> :SrcExplToggle<CR> 
" // Set the height of Source Explorer window 
let g:SrcExpl_winHeight = 14
" // Set 100 ms for refreshing the Source Explorer 
let g:SrcExpl_refreshTime = 100 
" // Set "Enter" key to jump into the exact definition context 
" let g:SrcExpl_jumpKey = "<ENTER>"   
" // Set "Space" key for back from the definition context 
let g:SrcExpl_gobackKey = "<SPACE>" 
" // In order to Avoid conflicts, the Source Explorer should know what plugins 
" // are using buffers. And you need add their bufname into the list below 
" // according to the command ":buffers!" 
let g:SrcExpl_pluginList = [ 
        \ "__Tag_List__", 
        \ "_NERD_tree_", 
        \ "Source_Explorer",
		\ "MinBufExplorer"
    \ ] 
" // Enable/Disable the local definition searching, and note that this is not 
" // guaranteed to work, the Source Explorer doesn't check the syntax for now. 
" // It only searches for a match with the keyword according to command 'gd' 
let g:SrcExpl_searchLocalDef = 1 
" // Do not let the Source Explorer update the tags file when opening 
let g:SrcExpl_isUpdateTags = 0 
" // Use 'Exuberant Ctags' with '--sort=foldcase -R .' or '-L cscope.files' to 
" //  create/update a tags file 
let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase -R ." 
" // Set "<F12>" key for updating the tags file artificially 
let g:SrcExpl_updateTagsKey = "<F12>" 
"======================================================================== 
