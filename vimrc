set nocompatible
filetype off

if has("unix")
    set runtimepath+=~/.vim/bundle/vundle/
	call vundle#rc()
elseif has("win32")
    set runtimepath+=~\vimfiles\bundle\vundle
	call vundle#rc('$HOME/vimfiles/bundle')
endif

Bundle 'https://github.com/gmarik/vundle'

Bundle 'https://github.com/kien/ctrlp.vim'
Bundle 'https://github.com/mileszs/ack.vim'
Bundle 'https://github.com/vim-scripts/grep.vim'
Bundle 'https://github.com/sjl/gundo.vim'
Bundle 'https://github.com/vim-scripts/mru.vim'
Bundle 'https://github.com/vim-scripts/glsl.vim'
Bundle 'https://github.com/derekwyatt/vim-fswitch'
Bundle 'https://github.com/vim-scripts/VisIncr'
Bundle 'https://github.com/vim-scripts/Align'
Bundle 'https://github.com/vim-scripts/undo_tags'
Bundle 'https://github.com/tomtom/tcomment_vim'
Bundle 'https://github.com/ntpeters/vim-better-whitespace'
Bundle 'https://github.com/luochen1990/rainbow'
Bundle 'https://github.com/vim-scripts/listmaps.vim'
Bundle 'https://github.com/vim-scripts/ScrollColors'

filetype plugin indent on

syntax on
let mapleader = ","
nmap <silent> ,ev :e $MYVIMRC<cr>
nmap <silent> ,sv :so $MYVIMRC<cr>

set hidden       " enable unsaved buffers
set title
set showmatch    " show matching braces
set nocursorline

"no error bells
set noeb vb t_vb=
autocmd GUIEnter * set vb t_vb=
autocmd VimEnter * set vb t_vb=

set encoding=utf8
set fileencoding=utf8
" set encoding=latin1
" set fileencoding=latin1

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

"tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set smarttab

"identation
set cino=g0

set autoindent
set smartindent
set cindent
"set indentexpr "TODO !

set copyindent

set backspace=2

"chdir settings
set autochdir
" autocmd BufEnter * silent! lcd %:p:h
" map <leader>cd :lcd %:h<CR>

set autoread "auto reload file contents on external change

"set showfulltag "doesn't work well with longest
set completeopt=menu,longest
set complete-=i "do not search include files (seach by will with Ctrl-X Ctrl-I)
set complete-=t "do not search tags (completeopt doesn't work well with some generated tags that begin with space...)

"gVim
if has("gui_running")
	let &guioptions="racg"
	if has("win32")
		set guifont=Lucida\ Console
		winsize 190 70
	endif
endif

function! ToggleGUI()
	let l:guiopt_windows = "gmrLtT"
	let l:guiopt_linux   = "agimrLtT"
	let l:guiopt_plain   = "racg"

	if &guioptions == l:guiopt_plain
		if has("unix")
			let &guioptions = l:guiopt_linux
		elseif has("win32")
			let &guioptions = l:guiopt_windows
		else
			echo "Unknown system."
		endif
	else
        let &guioptions = l:guiopt_plain
	endif
endfunc

" Easy window navigation
" map <C-h> <C-w>h
" map <C-j> <C-w>j
" map <C-k> <C-w>k
" map <C-l> <C-w>l

" up/down movement on wrapped lines
nnoremap j gj
nnoremap k gk

" show this sign at the beginning of each wrapped line
set showbreak=°°

set display=""
set display+=lastline "show as much as possible
set display+=uhex     "show unprintable characters as hex

set mouse=""

set splitbelow
set splitright

"use hlsearch but don't enable it by default
set hlsearch
nohlsearch
nmap <silent> <leader>, :silent :nohlsearch<CR>
vmap <silent> <leader>, <Esc><C-o>:nohlsearch<CR>gv

set virtualedit=all "enable cursor navigation in virtual space

"use English language for spell checking but don't enable it by default
set spelllang=en_us
set nospell
map <F3> :set nospell!<CR>

set wildmenu                   " use wildmenu
set wildmode=list:longest,full " shell like behavior

"avoid the evil 'Ex' mode..
noremap Q <Nop>

map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" makes ctrl+j/k scroll history in command line
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-h> <Home>
cnoremap <C-l> <End>

"remap ` to ' (it's more useful this way)
nnoremap ' `
nnoremap ` '
vnoremap ' `
vnoremap ` '

" In Makefiles, don't expand tabs to spaces, since we need the actual tabs
autocmd FileType make set noexpandtab

"don't accidently hit this when using visual line selection
map K k

"insert timestamp
imap <F10> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>

"temp stuff:
set makeprg=make
set laststatus=2 "always show status line

set shellslash "do I need this?
set mousehide
set scrolloff=8
"use whis for bufers with a few lines
nmap <silent> ,sw :execute ":resize " . line('$')<cr>

autocmd FileType text setlocal textwidth=78

function! Ve()
    :!vim --remote %
endfunc

"test
set lbr " paragraph formatting. do I want this?

" Show numbers only in active buffer
set number
:au WinEnter * :setlocal number
:au WinLeave * :setlocal nonumber
" Automatically resize vertical splits.
":au WinEnter * :set winfixheight


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
if has("unix")
    set backupdir=~/.vim/.tmp
    set directory=~/.vim/.tmp
elseif has("win32")
    set backupdir=~\vimfiles\.tmp
    set directory=~\vimfiles\.tmp
endif

" Force saving files that require root permission
function! SudoWrite()
    :%!sudo tee > /dev/null %
endfun
cmap W!! w !sudo tee % >/dev/null

" TODO: test this: (continous line number: http://i.imgur.com/Td8Jd.png)
" Column scroll-binding on <leader>sb
noremap <silent> <leader>sb :<C-u>let @z=&so<CR>:set so=0 noscb<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>
" ========================================================================

" ========================================================================
" Mirror settings
" ========================================================================
function! Mirror(command)
	let oldpath = expand('%:p')
	let space = ' '
	let escaped = substitute(oldpath,'[,'.space.']\|\\[\,'.space.']\@=','\\&','g')
	execute a:command
	execute 'e ' . escaped
endfunction

com! MirrorRight      : call Mirror('wincmd l')
com! MirrorSplitRight : call Mirror('vsplit | wincmd l')
com! MirrorLeft       : call Mirror('wincmd h')
com! MirrorSplitLeft  : call Mirror('vsplit | wincmd h')
com! MirrorBelow      : call Mirror('wincmd j')
com! MirrorSplitBelow : call Mirror('split | wincmd j')
com! MirrorAbove      : call Mirror('wincmd k')
com! MirrorSplitAbove : call Mirror('split | wincmd k')

" ========================================================================
" Mirror keyboard maps
" ========================================================================
nmap <silent> <leader>ml :MirrorRight<CR>
nmap <silent> <leader>mL :MirrorSplitRight<CR>
nmap <silent> <leader>mh :MirrorLeft<CR>
nmap <silent> <leader>mH :MirrorSplitLeft<CR>
nmap <silent> <leader>mk :MirrorAbove<CR>
nmap <silent> <leader>mK :MirrorSplitAbove<CR>
nmap <silent> <leader>mj :MirrorBelow<CR>
nmap <silent> <leader>mJ :MirrorSplitBelow<CR>
" ========================================================================

" ========================================================================
" Mru settings
" ========================================================================
let MRU_Max_Entries = 1000
let MRU_Exclude_Files = '^/tmp/.*\|^/var/tmp/.*'  " For Unix
let MRU_Window_Height = 25
nmap <leader>mr :MRU<CR>
" ========================================================================

" ========================================================================
" CScope
" ========================================================================
if has("cscope")
    set nocscopetag
    set csto=1
    set cscopeverbose

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
        else
            set nocscopeverbose " suppress 'duplicate connection' error
            cs add $CSCOPE_DB
            set cscopeverbose
        endif
    endfunction

    "DON'T call cscope on BufEnter
    au BufEnter /* call LoadCscope()
endif
" ========================================================================

" ========================================================================
" Ctags
" ========================================================================
set tags=./tags;/
" set tags+=~/.ctags/tags
" set tags+=~/.ctags/cpp
" set tags+=~/.ctags/libc6
" set tags+=~/.ctags/gl
" set tags+=~/.ctags/cl
" set tags+=~/.ctags/sdl
" set tags+=~/.ctags/boost
function! Ctags()
    exec '!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .'
endfunc
" nnoremap <C-[> :pop<CR> << how to fix this?
" ========================================================================

" ========================================================================
" Persistant undo
" ========================================================================
if exists("+undofile")
    au BufWritePre /tmp/* setlocal noundofile
    if has("unix")
        set undodir=~/.vim/.undodir
    elseif has("win32")
        set undodir=~\vimfiles\.undodir
    endif
    set undofile
    set undolevels=1000 "maximum number of changes that can be undone
    set undoreload=10000 "maximum number lines to save for undo on a buffer reload
endif
" ========================================================================

"TEST
func! STL()
    " let stl = '%f [%{(&fenc==""?&enc:&fenc).((exists("+bomb") && &bomb)?",B":"")}%M%R%H%W] %y [%l/%L,%v] [%p%%]'
    let stl = '%f%m #%n >%v %l/%L[%p%%] [%b 0x%B]%=%{getcwd()}'
    let barWidth = &columns - 65 " <-- wild guess
    let barWidth = barWidth < 3 ? 3 : barWidth

    if line('$') > 1
        let progress = (line('.')-1) * (barWidth-1) / (line('$')-1)
    else
        let progress = barWidth/2
    endif

    " line + vcol + %
    let pad = strlen(line('$'))-strlen(line('.')) + 3 - strlen(virtcol('.')) + 3 - strlen(line('.')*100/line('$'))
    let bar = repeat(' ',pad).' [%1*%'.barWidth.'.'.barWidth.'('
                \.repeat('-',progress )
                \.'%2*0%1*'
                \.repeat('-',barWidth - progress - 1).'%0*%)%<]'
    return stl.bar
endfun
" set statusline=%!STL()

" ??
hi def link User1 DiffAdd
hi def link User2 DiffDelete


" ========================================================================
" Status line
" ========================================================================
" set statusline=
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
" set statusline +=%f\%m\ #%n\ >%v\ %l/%L[%p%%]\ [%b\ 0x%B]%=%{getcwd()}

" set titlestring={%{v:servername}} "try this
set titlestring="WHERE DO I SEE THIS?!"

function! GetServerName()
    return v:servername
endfunc
set statusline=#%n\ %f\%m\ >%v\ %l/%L[%p%%]\ [%b\ 0x%B]\ [%{getcwd()}]%=%{GetServerName()}
" ========================================================================

" ========================================================================
" Custom keyboard shortcuts
" ========================================================================
set pastetoggle=<F2> "TODO: this is just temporary. Remember to change this.

"show non-visual chars
set listchars=
if (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8') && version >= 700
    set listchars+=tab:×­
    set listchars+=extends:»
    set listchars+=precedes:«
    set listchars+=nbsp:¬
    "set listchars+=trail:·
    "set listchars+=eol:¶
else
    set listchars+=tab:>_,trail:-,extends:>,precedes:<,eol:;
endif

set list
nmap <leader>li :set list!<CR>

let s:showAllChars = 0

function! ShowAllChars()
	set listchars+=trail:·
	set listchars+=eol:¶
	let s:showAllChars = 1
endfunc

function! HideSpecialChars()
	set listchars-=trail:·
	set listchars-=eol:¶
	let s:showAllChars = 0
endfunc

function! ToggleChars()
	if (s:showAllChars)
		call HideSpecialChars()
	else
		call ShowAllChars()
	endif
endfunc

command! -nargs=0 ToggleChars  :call ToggleChars()
command! -nargs=0 ShowAllChars :call ShowAllChars()
command! -nargs=0 HideChars    :call HideSpecialChars()

"autocmd ColorScheme * highlight SpecialKey  ctermfg=gray
"autocmd ColorScheme * highlight NonText     ctermfg=gray
"autocmd ColorScheme * highlight SpecialKey  guifg=gray
"autocmd ColorScheme * highlight NonText     guifg=gray
"
"autocmd ColorScheme * highlight SpecialKey  ctermfg=238
"autocmd ColorScheme * highlight NonText     ctermfg=238
"autocmd ColorScheme * highlight SpecialKey  guifg=#404040
"autocmd ColorScheme * highlight NonText     guifg=#404040

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
" Frequent shortcuts
" ========================================================================
silent! nnoremap <silent> <leader>qf :call ClangCheck()<CR>
silent! nmap <silent> <leader>cw :cwindow 15<CR>
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
let g:clang_use_library=1
" let g:clang_auto_user_options=1
" let g:clang_complete_macros=1
" let g:clang_complete_patterns=1
let g:clang_user_options = '-std=c++0x -fexceptions -I/usr/include/c++/4.6/x86_64-linux-gnu/. -I/usr/include/c++/4.6/backward -I/usr/lib/gcc/x86_64-linux-gnu/4.6.1/include -I/usr/local/include -I/usr/lib/gcc/x86_64-linux-gnu/4.6.1/include-fixed -I/usr/include/x86_64-linux-gnu -I/usr/include/GL -I/usr/local/include/bullet -I/usr/include/ni/'
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
nmap <silent> ,sf :FSHere<CR>
nmap <silent> ,sl :FSRight<CR>
nmap <silent> ,sL :FSSplitRight<CR>
nmap <silent> ,sh :FSLeft<CR>
nmap <silent> ,sH :FSSplitLeft<CR>
nmap <silent> ,sk :FSAbove<CR>
nmap <silent> ,sK :FSSplitAbove<CR>
nmap <silent> ,sj :FSBelow<CR>
nmap <silent> ,sJ :FSSplitBelow<CR>
" ========================================================================

" ========================================================================
" FuzzyFinder settings
" ========================================================================
let g:fuf_file_exclude = '\v\~$|\.(o|exe|dll|bak|class|meta|lock|orig|jar|swp)$|/test/data\.|(^|[/\\])\.(hg|git|bzr)($|[/\\])'
" nmap <silent> ,ev :FufFile ~/.vim/<cr>
nmap <silent> ,eb :FufBuffer<cr>
nmap <silent> ,ef :FufFile<cr>
nmap <silent> ,ej :FufJumpList<cr>
let g:fuf_keyNextMode = '<C-e>'
let g:fuf_splitPathMatching = 0
let g:fuf_maxMenuWidth = 110
let g:fuf_timeFormat = ''
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
function! OpenNerdTree()
    if exists("t:NERDTreeBufName") == 0
        exec 'NERDTree'
        return
    endif

    if bufwinnr(t:NERDTreeBufName) != -1
        exec 'NERDTreeToggle'
        exec 'NERDTreeToggle'
    else
        exec 'NERDTree'
    endif
endfunction
nmap <leader>nc :NERDTreeClose<CR>
nmap <leader>nh :NERDTreeClose<CR>:NERDTree<CR>
nmap <leader>nn :call OpenNerdTree()<CR>
" ========================================================================

" ========================================================================
" Taglist (Tlist) #deprecated
" ========================================================================
let g:Tlist_Use_Right_Window = 1
let g:Tlist_Enable_Fold_Column = 0
let g:Tlist_WinWidth = 35
" nmap <leader>tl :TlistToggle<cr>
" ========================================================================
"
" ========================================================================
" Tagbar
" ========================================================================
let g:tagbar_width = 70
nmap <leader>tl :TagbarToggle<cr>
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
command! -nargs=0 NumberToggle :call NumberToggle()
nnoremap <C-n> :call NumberToggle()<cr>

function! ChdirToggle()
    if (&autochdir == 1)
        set noautochdir
    else
        set autochdir
    endif
endfun
nnoremap ,ct :call ChdirToggle()<cr>

" set makeef=make.err
set makeprg=make
"TODO: setup this for a generic use case
" if has("unix")
"     nmap ,ee :w<cr>:! ./app<cr>
"     nmap ,rr :w<cr>:execute "!~/.vim/makebg.sh"<cr><cr>
"     nmap ,dd :w<cr>:execute "!~/.vim/makerunbg.sh"<cr><cr>
" endif


" ========================================================================

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
command! -nargs=1 OpenURL :call OpenURL(<args>)
nnoremap <leader>gF :OpenURL <cfile><CR>
nnoremap <leader>gA :OpenURL http://www.answers.com/<cword><CR>
nnoremap <leader>gG :OpenURL http://www.google.com/search?q=<cword><CR>
nnoremap <leader>gW :OpenURL http://en.wikipedia.org/wiki/Special:Search?search=<cword><CR>
nnoremap <leader>gL :call OpenURL(GetLink())<CR>
" vnoremap <leader>gL :call OpenURL(GetMarkedText())<CR>

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
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_max_depth = 4
let g:ctrlp_max_files=10000
let g:ctrlp_show_hidden = 1
let g:ctrlp_follow_symlinks=1
let g:ctrlp_working_path_mode=0
if has("unix")
    let g:ctrlp_cache_dir = '~/.vim/.cache/ctrlp'
elseif has("win32")
    let g:ctrlp_cache_dir = '~\vimfiles\_cache/ctrlp'
endif
let g:ctrlp_max_height = 25
" let g:ctrlp_clear_cache_on_exit=0

let g:ctrlp_map = '<leader>pp'
let g:ctrlp_cmd = 'CtrlPRoot'
" nmap ,pp :CtrlPRoot<cr>
map <leader>pt :CtrlPBufTag<cr>
" let g:ctrlp_custom_ignore = {
"
"   \ 'dir':  '\v[\/]\.(git|hg|svn)$',
"   \ 'file': '\v\.(exe|so|dll|o)$',
"   \ 'link': 'some_bad_symbolic_links',
"   \ }

"Test
let g:showmarks_include="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.'`^<>[]{}()"
let g:showmarks_enable=0
let g:showmarks_ignore_type="hqp"
set updatetime=200

" "Test
" set foldmethod=manual

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
"Set filetype for glsl files
"au BufNewFile,BufRead *.fragmentshader,*.vertexshader,*.frag,*.vert,*.fp,*.vp,*.glsl,*.sc setf glsl
autocmd BufNewFile,BufRead *.vp,*.fp,*.gp,*.vs,*.fs,*.gs,*.tcs,*.tes,*.cs,*.vert,*.frag,*.geom,*.tess,*.shd,*.gls,*.glsl,*.sc set ft=glsl

"TEST
" au WinLeave * set nocursorline nocursorcolumn
" au WinEnter * set cursorline cursorcolumn
" set cursorline cursorcolumn


" ========================================================================
" Mirror keyboard maps
" ========================================================================
nmap <silent> <leader>ml :MirrorRight<CR>
nmap <silent> <leader>mL :MirrorSplitRight<CR>
nmap <silent> <leader>mh :MirrorLeft<CR>
nmap <silent> <leader>mH :MirrorSplitLeft<CR>
nmap <silent> <leader>mk :MirrorAbove<CR>
nmap <silent> <leader>mK :MirrorSplitAbove<CR>
nmap <silent> <leader>mj :MirrorBelow<CR>
nmap <silent> <leader>mJ :MirrorSplitBelow<CR>
" ========================================================================
"
"
"TEST
" let g:netrw_altv           = 1
let g:netrw_fastbrowse     = 2
let g:netrw_keepdir        = 0
let g:netrw_liststyle      = 3
let g:netrw_retmap         = 1
let g:netrw_silent         = 0
let g:netrw_special_syntax = 1

" ========================================================================
" Easymotion
" ========================================================================
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment
let g:EasyMotion_leader_key = 'f'
let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz'
cmap E<cr> Ex<cr>

" " ========================================================================
" " vim-projectroot
" " ========================================================================
" nnoremap <Leader>ack :ProjectRootExe Ack<space>
" let g:rootmarkers = ['.projectroot','.git','.hg','.svn','.bzr','_darcs','Makefile', 'build.xml']
" "TODO: manually specified root dir
" nnoremap <Leader>sr :let g:bookmark_dir=getcwd()<cr>
" nnoremap <Leader>cr :exec 'cd' g:bookmark_dir
" " ========================================================================

"Handy substitution
nnoremap & :'{,'}s/<c-r>=expand('<cword>')<cr>/
vnoremap & "*y<Esc>:<c-u>'{,'}s/<c-r>=substitute(escape(@*, '\/.*$^~[]'), "\n", '\\n', "g")<cr>/

" ========================================================================
" Experimental stuff...
" ========================================================================
function! Preserve(command)
    " preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    execute a:command
    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

function! StripTrailingWhitespace()
    call Preserve("%s/\\s\\+$//e")
endfunction

nmap <leader>fef :call Preserve("normal gg=G")<CR>
nmap <leader>fun :call Preserve("normal gggqG")<CR>
nmap <leader>f$ :call StripTrailingWhitespace()<CR>

" DO I WANT THIS?
" " reselect visual block after indent
" vnoremap < <gv
" vnoremap > >gv

"TRY THIS OUT!
" find current word in quickfix
nnoremap <leader>fw :execute "vimgrep ".expand("<cword>")." %"<cr>:copen<cr>
" find last search in quickfix
nnoremap <leader>fs :execute 'vimgrep /'.@/.'/g %'<cr>:copen<cr>

"GOLDEN RATIO < this is cool...
let g:golden_ratio_autocommand=0
let g:golden_ratio_wrap_ignored=0
map <F4> :GoldenRatioToggle<cr>

"tcomment "TODO: this doesn't work !
let g:tcommentMapLeader1 = '<c-/>'

" ========================================================================

" colorscheme xoria256
" colorscheme zenburn
" colorscheme jellybeans
" colorscheme leo
" colorscheme lucius
if has("win32") && !has("gui_running")
	set term=xterm
	set t_Co=256
	let &t_AB="\e[48;5;%dm"
	let &t_AF="\e[38;5;%dm"
endif

colorscheme lucius_custom
" if !has("gui_running")
" 	if has("win32")
" 		colorscheme default
" 	endif
" endif

" deletes hidden buffers
function! Wipeout()
    " list of *all* buffer numbers
    let l:buffers = range(1, bufnr('$'))

    " what tab page are we in?
    let l:currentTab = tabpagenr()
    try
        " go through all tab pages
        let l:tab = 0
        while l:tab < tabpagenr('$')
            let l:tab += 1

            " go through all windows
            let l:win = 0
            while l:win < winnr('$')
                let l:win += 1
                " whatever buffer is in this window in this tab, remove it from
                " l:buffers list
                let l:thisbuf = winbufnr(l:win)
                call remove(l:buffers, index(l:buffers, l:thisbuf))
            endwhile
        endwhile

        " if there are any buffers left, delete them
        if len(l:buffers)
            execute 'bwipeout' join(l:buffers)
        endif
    finally
        " go back to our original tab page
        execute 'tabnext' l:currentTab
    endtry
endfunction

:command! -range=% -nargs=0 Tab2Space execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'
:command! -range=% -nargs=0 Space2Tab execute '<line1>,<line2>s#^\( \{'.&ts.'\}\)\+#\=repeat("\t", len(submatch(0))/' . &ts . ')'

" TODO: add current dir to path

let g:rainbow_active = 0
