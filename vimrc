" ========================================================================
" Plugins not to be loaded
" ========================================================================
let g:pathogen_disabled = []
"""" call add(g:pathogen_disabled, "CSApprox") "same colors in vim and gvim
call add(g:pathogen_disabled, "0scan")
call add(g:pathogen_disabled, "lusty")
call add(g:pathogen_disabled, "recover")
call add(g:pathogen_disabled, "vim-pad")
" ========================================================================

" ========================================================================
" Startup Pathogen
" ========================================================================
call pathogen#infect()
call pathogen#helptags()
" ========================================================================

" Add xptemplate global personal directory
if has("unix")
    set runtimepath+=~/.vim/xpt-personal
endif

" ========================================================================
" Common settings
" ========================================================================
syntax on
filetype plugin indent on
set term=screen-256color
" colorscheme xoria256
" colorscheme zenburn
" colorscheme jellybeans
let mapleader = ","

set number       " show line numbers
set ic           " ignore case
set hidden       " enable unsaved buffers
set title
set showmatch    " show matching braces
set nocompatible
set lazyredraw

"no error bells
set noeb vb t_vb=

set history=500	   

"TEST (do I like this this way?)
" set notimeout
" set ttimeout

"make :W same as :w
cnoreabbrev W w

set ignorecase
set smartcase

set cindent
set smartindent

"customize identation
set tabstop=4 
set softtabstop=4
set shiftwidth=4 
set expandtab
set autoindent
set copyindent
set smarttab
set backspace=2

"c indentation options
set cino=g0

"chdir settings
set autochdir
autocmd BufEnter * silent! lcd %:p:h
"map <leader>cd :lcd %:h<CR>

set autoread "auto reload file contents on external change

set complete-=i "do not search include files (until we figure out how to make this faster)

"use console dialogs instead of popup dialogs for simple choices
set guioptions+=c "TODO:<<< test

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" up/down movement on wrapped lines
nnoremap j gj
nnoremap k gk

" TEST show wrapped lines
set showbreak=+++
" TEST display
set display=lastline,uhex
" don't use mouse (except in command line mode)
set mouse=c
" TEST
set splitbelow
set splitright

"use hlsearch but don't enable it by default
set hlsearch
nohlsearch
nmap <silent> <leader>, :silent :nohlsearch<CR>

set virtualedit=all "enable cursor navigation in virtual space

"use English language for spell checking but don't enable it by default
set spelllang=en_us
set nospell
map <F4> :set nospell!<CR> 
imap <F4> :set nospell!<CR> 

set wildmenu                   " use wildmenu
set wildmode=list:longest,full " shell like behavior

noremap Q <Nop>

"disable preview scratch window
set completeopt=menuone,longest

"make default clipboard
" set clipboard=unnamed "plus

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" makes ctrl+j/k scroll history in command line and ctrl+a/e -> home/end
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

"remap ` to ' (it's more useful this way)
nnoremap ' `
nnoremap ` '
vnoremap ' `
vnoremap ` '

" In Makefiles, don't expand tabs to spaces, since we need the actual tabs
autocmd FileType make set noexpandtab

"don't accidently hit this when using visual line selection
map K k 

"insert timestamp (TODO: output some different time format)
nmap <F10> a<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>
imap <F10> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>

"make folding/unfolding easier and faster
set foldmethod=syntax
set foldnestmax=1
set foldlevel=1
"nnoremap <space> za

"temp stuff:
set makeprg=make

"experimental: (TODO: decide what to do with these:)
">>>>>>>>>>
set shellslash
set lazyredraw
set mousehide
set scrolloff=8
set showfulltag
"use whis for bufers with a few lines
nmap <silent> ,sw :execute ":resize " . line('$')<cr>

autocmd FileType text setlocal textwidth=78
set showcmd     "show (partial) command in status line
set cmdheight=2 "TODO i want this. move this elsewhere


"don't highliht the line where the cursor is
set nocursorline

"nice :)
" map <Left> :echo "no!"<cr>
" map <Right> :echo "no!"<cr>
" map <Up> :echo "no!"<cr>
" map <Down> :echo "no!"<cr>
">>>>>>>>>>

"test
set lbr " paragraph formatting. do I want this?

"test2
" Always show line numbers, but only in current window.
set number
:au WinEnter * :setlocal number
:au WinLeave * :setlocal nonumber
" Automatically resize vertical splits.
":au WinEnter * :set winfixheight


"TODO: fix this problem with NERD tree.
":au BufEnter * :call AdjustWinHeight()
"function! AdjustWinHeight()
"    echomsg bufname("%")
"    echomsg match(bufname("%"), "NERD_Tree_")
"    if (match(bufname("%"), "NERD_Tree_") == -1)
"        echomsg bufname("%")
"        setlocal nonumber
"        "wincmd =
"    endif
"endfun

"function! ChdirToggle()
"    if (&autochdir == 1)
"        set noautochdir
"    else
"        set autochdir
"    endif
"endfun

"dictionary
set dictionary+=/usr/share/dict/words

"grep settings
set grepprg=grep\ -rnH\ --exclude='.*.swp'\ --exclude='*~'\ --exclude=tags
"set grepprg=grep\ -nH\ $*
command! -nargs=+ Cgrep execute 'lgrep! <args> * -R' | lopen 16
command! Cgrepw execute "lgrep! " . expand("<cword>") . " * -R" | lopen 16

"store temporary files in a central folder 
if isdirectory($HOME . '/.vim/tmp') == 0
    :silent !mkdir -p ~/.vim/tmp > /dev/null 2>&1
endif
set backupdir=~/.vim/tmp
set directory=~/.vim/tmp 

" Force saving files that require root permission
function! SudoWrite()
    :%!sudo tee > /dev/null %
endfun

" TODO: test this: (continous line number: http://i.imgur.com/Td8Jd.png)
" Column scroll-binding on <leader>sb
noremap <silent> <leader>sb :<C-u>let @z=&so<CR>:set so=0 noscb<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>
" ========================================================================

" ========================================================================
" CScope
" ========================================================================
if has("cscope")
"DON'T use cscope by default
set nocscopetag
set csto=1 "check scope first, then ctags (INVERSE)
"set cscopeverbose

"" add any cscope database in current directory
"if filereadable("cscope.out")
"    cs add cscope.out  
"" else add the database pointed to by environment variable 
"elseif $CSCOPE_DB != ""
"    cs add $CSCOPE_DB
"endif

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

"DON'T call cscope on BufEnter
" au BufEnter /* call LoadCscope()

endif
" ========================================================================

" ========================================================================
" Ctags
" ========================================================================
set tags=./tags;/
set tags+=~/.ctags/cpp
set tags+=~/.ctags/libc6
set tags+=~/.ctags/gl
set tags+=~/.ctags/cl
set tags+=~/.ctags/sdl
set tags+=~/.ctags/boost
function! Ctags()
   exec '!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .'
endfunc
" nnoremap <C-[> :pop<CR> << how to fix this?
" ========================================================================

" ========================================================================
" Persistant undo (TODO: is this cross-platform?)
" ========================================================================
if exists("+undofile")
    if isdirectory($HOME . '/.vim/undodir') == 0
        :silent !mkdir -p ~/.vim/undodir > /dev/null 2>&1
    endif
    au BufWritePre /tmp/* setlocal noundofile
    set undodir=~/.vim/undodir
    set undofile
    set undolevels=1000 "maximum number of changes that can be undone
    set undoreload=10000 "maximum number lines to save for undo on a buffer reload
endif
" ========================================================================

" ========================================================================
" Buftabs
" ========================================================================
set laststatus=2
let g:buftabs_in_statusline = 1
" let g:buftabs_only_basename = 1
" ======================================================================== 

" ========================================================================
" Status line
" ========================================================================
set statusline=
"set statusline +=%{buftabs#statusline()} 
"set statusline +=%-2.3n        " buffer number
"set statusline +=%t          " filename
"set statusline +=%m          " modified
"set statusline +=%r          " read-only
"set statusline +=%=          " delimiter
"set statusline +=%p%%        " percent
"set statusline +=%5l%*     " current line
"set statusline +=/%L%*       " total lines
"set statusline +=%4c\ %*     " column number
"set statusline +=0x%04B\%*\  " character under cursor
set statusline +=%f\%m\ #%n\ >%v\ %l/%L[%p%%]\ [%b\ 0x%B]%=%{getcwd()}
" ========================================================================

" ========================================================================
" Custom keyboard shortcuts
" ========================================================================
set pastetoggle=<F3> "TODO: this is just temporary. Remember to change this.

"show non-visual chars
set listchars=tab:>_,trail:-,extends:>,precedes:<,eol:;
"TODO: why this moves cursor one position right after execution?

nmap <leader>li :set list!<CR>
autocmd ColorScheme * highlight SpecialKey ctermfg=gray
autocmd ColorScheme * highlight NonText ctermfg=gray
autocmd ColorScheme * highlight SpecialKey guifg=gray
autocmd ColorScheme * highlight NonText guifg=gray

nmap <silent> ,ev :e $MYVIMRC<cr>
nmap <silent> ,sv :so $MYVIMRC<cr>

" if (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8') && version >= 700
    " let &listchars = "tab:\u21e5\u00b7,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"
" else
" endif

" ========================================================================

" ========================================================================
" Custom functions
" ========================================================================
function! ClangCheck()
    if &ft == "c" || &ft == "cpp" || &ft == "h" || &ft == "hpp"    
       call g:ClangUpdateQuickFix()
    endif
endfunc
" ========================================================================

" ========================================================================
" Frequent plugin shortcuts
" ========================================================================
" silent! map <silent> <F2> :TlistToggle<CR> 
"silent! nnoremap <silent> <F2> :TlistUpdate<CR> 
" silent! map <silent> <F3> :NERDTreeToggle<CR> 
" silent! map <silent> <F4> :GundoToggle<CR> 
nmap <F2> :NERDTreeToggle<CR>
nmap <leader>ft :NERDTreeToggle<CR>
"silent! nnoremap <silent> <leader>ff :CommandT<CR> 
silent! nnoremap <silent> <leader>bb :BufExplorer<CR> 
silent! nnoremap <silent> <leader>jj :FufJumpList<CR>
silent! nnoremap <silent> <leader>qf :call ClangCheck()<CR>
silent! nmap <silent> <leader>cw :cwindow<CR>
silent! nmap <silent> <leader>cl :clist<CR>
silent! nmap <silent> <leader>cc :cclose<CR>
silent! nmap <silent> <leader>lw :lwindow<CR>
silent! nmap <silent> <leader>ll :llist<CR>
silent! nmap <silent> <leader>lc :lclose<CR>
" ========================================================================

" ========================================================================
" Clang_complete settings 
" ========================================================================
let g:clang_auto_select=0
let g:clang_complete_auto = 0 
let g:clang_complete_copen = 1
let g:clang_hl_errors = 0
let g:clang_periodic_quickfix = 0
let g:clang_snippets = 1
let g:clang_snippets_engine = "clang_complete"
let g:clang_conceral_snippets = 1
let g:clang_exec="clang"
let g:clang_library_path="/usr/lib/"
" let g:clang_use_library=1 //TODO: 666 << use it
let g:clang_use_library=0
" let g:clang_auto_user_options=1
" let g:clang_complete_macros=1
" let g:clang_complete_patterns=1
let g:clang_user_options = '-std=c++0x -fexceptions -I/usr/include/c++/4.6/x86_64-linux-gnu/. -I/usr/include/c++/4.6/backward -I/usr/lib/gcc/x86_64-linux-gnu/4.6.1/include -I/usr/local/include -I/usr/lib/gcc/x86_64-linux-gnu/4.6.1/include-fixed -I/usr/include/x86_64-linux-gnu -I/usr/include/GL -I/usr/local/include/bullet -I/usr/include/ni/'
" ======================================================================== 

" ======================================================================== 
" XPTemplate
" ======================================================================== 
let g:xptemplate_vars = "SParg="
let g:xptemplate_bundle = 'cpp_autoimplem'
" ======================================================================== 

" ========================================================================
" Gundo settings
" ========================================================================
let g:gundo_width = 60
let g:gundo_preview_height = 40
let g:gundo_right = 1
let g:gundo_close_on_revert = 0 "set this to 1 to automatically close the Gundo windows when reverting.
"let g:gundo_preview_bottom = 1
map <leader>gt :GundoToggle<cr>
map <leader>gu :GundoToggle<cr>
" ======================================================================== 

" ========================================================================
" Histwin settings
" ========================================================================
map <leader>hw :Histwin<cr>
" ======================================================================== 

" ======================================================================== 
" FSwitch
" ======================================================================== 
nmap <silent> ,ff :FSHere<CR>
nmap <silent> ,fl :FSRight<CR>
nmap <silent> ,fL :FSSplitRight<CR>
nmap <silent> ,fh :FSLeft<CR>
nmap <silent> ,fH :FSSplitLeft<CR>
nmap <silent> ,fk :FSAbove<CR>
nmap <silent> ,fK :FSSplitAbove<CR>
nmap <silent> ,fj :FSBelow<CR>
nmap <silent> ,fJ :FSSplitBelow<CR>
" ======================================================================== 

" ======================================================================== 
" FuzzyFinder settings
" ======================================================================== 
let g:fuf_file_exclude = '\v\~$|\.(o|exe|dll|bak|class|meta|lock|orig|jar|swp)$|/test/data\.|(^|[/\\])\.(hg|git|bzr)($|[/\\])'
" nmap <silent> ,ev :FufFile ~/.vim/<cr>
nmap <silent> ,eb :FufBuffer<cr>
nmap <silent> ,ef :FufFile<cr>
nmap <silent> ,ej :FufJumpList<cr>
nmap <silent> ,ec :FufMruCmd<cr>
nmap <silent> ,em :FufMruFile<cr>
let g:fuf_keyNextMode = '<C-e>'
let g:fuf_splitPathMatching = 0
let g:fuf_maxMenuWidth = 110
let g:fuf_timeFormat = ''
" ======================================================================== 


" ========================================================================
" Command-t settings
" ========================================================================
let g:CommadTMaxFiles = 90000
let g:CommandTMaxDepth = 20
let g:CommmandTCancelMap = ['<C-c>', '<Esc>']
let g:CommandTMaxHeight = 30
" ========================================================================
"
" ========================================================================
" Mru settings
" ========================================================================
let MRU_Max_Entries = 1000 
let MRU_Exclude_Files = '^/tmp/.*\|^/var/tmp/.*'  " For Unix 
let MRU_Window_Height = 25 
nmap <leader>mr :MRU<CR>
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
let NERDTreeShowHidden=1
" let NERDTreeQuitOnOpen=1          " Quit on opening files from the tree
" let NERDTreeHighlightCursorline=1 " Highlight the selected entry in the tree
" let NERDTreeWinPos='right'
 let NERDTreeWinSize=40 
" ========================================================================

" ======================================================================== 
" Taglist (Tlist)
" ======================================================================== 
let g:Tlist_Use_Right_Window = 1
let g:Tlist_Enable_Fold_Column = 0
let g:Tlist_WinWidth = 35
nmap <leader>tl :TlistToggle<cr>
" ======================================================================== 

" ======================================================================== 
" Vim-pad
" ======================================================================== 
let g:pad_dir = "~/notes/"
let g:pad_window_height = 20
" ======================================================================== 

" ======================================================================== 
" Custom functions
" ======================================================================== 
function! CloseHiddenBuffers()
  " figure out which buffers are visible in any tab
  let visible = {}
  for t in range(1, tabpagenr('$'))
    for b in tabpagebuflist(t)
      let visible[b] = 1
    endfor
  endfor
  " close any buffer that's loaded and not visible
  for b in range(1, bufnr('$'))
    if bufloaded(b) && !has_key(visible, b)
      exe 'bd ' . b
    endif
  endfor
endfun

function! NumberToggle()
    if (&relativenumber == 1)
        set number
    else
        set relativenumber
    endif
endfun
nnoremap <C-n> :call NumberToggle()<cr>

function! ChdirToggle()
    if (&autochdir == 1)
        set noautochdir
    else
        set autochdir
    endif
endfun
nnoremap ,ct :call ChdirToggle()<cr>
nmap <silent> ,et :e /home/instructor/.vim/xpt-personal/ftplugin/<cr>
" set makeef=make.err
set makeprg=make
nmap ,ee :w<cr>:make! && ./app<cr>
" ======================================================================== 

colorscheme lucius

"TEST
function! OpenURL(url)
  if has("win32")
    exe "!start cmd /cstart /b ".a:url.""
  elseif $DISPLAY !~ '^\w'
    exe "silent !sensible-browser \"".a:url."\""
  else
    exe "silent !sensible-browser -T \"".a:url."\""
  endif
  redraw!
endfunction


function! GetLink()
    let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;:]*')
    return s:uri
endfunction

function! GetMarkedText()
    try
        let s:a_temp = @a
        normal! gv"ay
        return @a
    finally
        let @a = s:a_temp
    endtry
endfunction

" open URL under cursor in browser
command! -nargs=1 OpenURL :call OpenURL(<q-args>)
nnoremap <leader>gF :OpenURL <cfile><CR>
nnoremap <leader>gA :OpenURL http://www.answers.com/<cword><CR>
nnoremap <leader>gG :OpenURL http://www.google.com/search?q=<cword><CR>
nnoremap <leader>gW :OpenURL http://en.wikipedia.org/wiki/Special:Search?search=<cword><CR>
nnoremap <leader>gL :call OpenURL(GetLink())<CR>
vnoremap <leader>gL :call OpenURL(GetMarkedText())<CR>

" TEST some comment helpers
nnoremap <leader>== yyPv$r=jyypv$r=
nnoremap <leader>** yyPv$r*jyypv$r*
nnoremap <leader>-- yyPv$r-jyypv$r-
nnoremap <leader>=k yyPv$r=
nnoremap <leader>-k yyPv$r-
nnoremap <leader>^k yyPv$r^
nnoremap <leader>"k yyPv$r"
nnoremap <leader>=j yypv$r=
nnoremap <leader>-j yypv$r-
nnoremap <leader>^j yypv$r^
nnoremap <leader>"j yypv$r"

" TEST
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

nmap <leader>cp :let @" = expand("%:p")<CR>

" TEST
" set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
" set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
" let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_max_depth = 4
let g:ctrlp_max_files=100000
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = ''
" let g:ctrlp_max_height = 15
let g:ctrlp_map = '<leader>p'
" let g:ctrlp_custom_ignore = {

"   \ 'dir':  '\v[\/]\.(git|hg|svn)$',
"   \ 'file': '\v\.(exe|so|dll|o)$',
"   \ 'link': 'some_bad_symbolic_links',
"   \ }

"Test
let g:showmarks_include="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.'`^<>[]{}()"
let g:showmarks_enable=0
let g:showmarks_ignore_type="hqp"
set updatetime=200

"Test
set foldmethod=manual

"QuickTask
let g:quicktask_autosave=1

"Yankring
nnoremap <silent> <leader>yr :YRShow<CR>
let g:yankring_window_height = 25

"OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 0 " autocomplete after .
let OmniCpp_MayCompleteArrow = 0 " autocomplete after ->
let OmniCpp_MayCompleteScope = 0 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main

"Set filetype for opencl files
autocmd BufNewFile,BufRead *.cl setf cc
