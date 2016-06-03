set nocompatible
filetype off

if has("unix")
	set runtimepath+=~/.vim/bundle/vundle/
	set runtimepath+=~/.fzf
	call vundle#rc()
elseif has("win32")
	set runtimepath+=~\vimfiles\bundle\vundle
	" TODO: add fzf for Windows.
	call vundle#rc('$HOME/vimfiles/bundle')
endif

Bundle 'https://github.com/gmarik/vundle'

Bundle 'https://github.com/mileszs/ack.vim'
Bundle 'https://github.com/junegunn/fzf.vim'
Bundle 'https://github.com/vim-scripts/grep.vim'
Bundle 'https://github.com/dbakker/vim-projectroot'
Bundle 'https://github.com/sjl/gundo.vim'
Bundle 'https://github.com/vim-scripts/mru.vim'
Bundle 'https://github.com/vim-scripts/glsl.vim'
Bundle 'https://github.com/derekwyatt/vim-fswitch'
Bundle 'https://github.com/vim-scripts/VisIncr'
Bundle 'https://github.com/vim-scripts/Align'
Bundle 'https://github.com/vim-scripts/undo_tags'
Bundle 'https://github.com/tomtom/tcomment_vim'
Bundle 'https://github.com/ntpeters/vim-better-whitespace'
Bundle 'https://github.com/vim-scripts/listmaps.vim'
Bundle 'https://github.com/vim-scripts/ScrollColors'

"Bundle 'https://github.com/Rip-Rip/clang_complete'
Bundle 'https://github.com/vim-scripts/OmniCppComplete'

filetype plugin indent on

if has("win32") && !has("gui_running")
	set term=xterm
	set t_Co=256
	let &t_AB="\e[48;5;%dm"
	let &t_AF="\e[38;5;%dm"
endif

colorscheme lucius_custom

syntax on
let mapleader = ","
nmap <silent> ,ev :e $MYVIMRC<cr>
nmap <silent> ,sv :so $MYVIMRC<cr>

set hidden       " enable unsaved buffers
set showmatch    " show matching braces

set cursorline
" Highlight only current window.
augroup CursorLine
au!
au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
au WinLeave * setlocal nocursorline
augroup END

" No error bells.
set noeb vb t_vb=
autocmd GUIEnter * set vb t_vb=
autocmd VimEnter * set vb t_vb=

set history=10000

set scrolloff=8

"make :W same as :w
cnoreabbrev W w

" Up/down movement on wrapped lines.
nnoremap j gj
nnoremap k gk

" Prevent a accidentally hitting these:
nnoremap <c-w>o <nop>
nnoremap <c-w><c-o> <nop>
nnoremap <c-l> <nop>

" Insert only one space when joining lines that contain punctuation
set nojoinspaces

set ignorecase "When searching, 'cat' will match both 'CAt' and 'cat'.
set smartcase  "Overrides ignorecase. When searching, 'cat' will match both 'CAt' and 'cat', but 'cAt' will only match 'cAt'.

set virtualedit=all "Enable cursor navigation in virtual space.
set nostartofline "Stay on the same column when moving up/down in visual mode.

set cindent
"set cino=b1,g0,:0,p0,t0,(0,u0,w1 "TODO: this is the old one.
set cino=b1,g0,p0,t0,(0,u0,w1,l1
set smartindent "No effect when cindent is on.

set autoindent  "Copy indent from current line when starging a new line.
set copyindent
set preserveindent

" Tabs.
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab

" Allow backspace over the start of insert.
set backspace=start,indent,eol

" Chdir settings.
set autochdir
"autocmd BufEnter * silent! lcd %:p:h
"map <leader>cd :lcd %:h<CR>

" TODO: this does not appear to work from terminal.
set autoread "auto reload file contents on external change

"set cpoptions+=$ "put a $ sign at the end of range when changing text

set noshowfulltag "because showfulltag doesn't work well with longest completeopt!
set completeopt=menu,longest
set complete-=i "do not search include files (seach by will with Ctrl-X Ctrl-I)
set complete-=t "do not search tags (completeopt doesn't work well with some generated tags that begin with space...)

set laststatus=2 "always show status line

" GVim.
if has("gui_running")
	let &guioptions="racg"
	if has("win32")
		set guifont=Lucida\ Console
		set lines=999 columns=999
	else
		set guifont=Monospace\ 8
		set lines=83 columns=333
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

" Show this sign at the beginning of each wrapped line.
set showbreak=°°

set display=""
set display+=lastline "show as much as possible
set display+=uhex     "show unprintable characters as hex

set mouse=""

set splitbelow
set splitright

" Use hlsearch but don't enable it by default.
set hlsearch
nohlsearch
nmap <silent> <leader>, :silent :nohlsearch<CR>
vmap <silent> <leader>, <Esc><C-o>:nohlsearch<CR>gv

" Use English language for spell checking but don't enable it by default.
set spelllang=en_us
set nospell

set wildmenu                   "Use wildmenu.
set wildmode=list:longest,full "Shell like behavior.

" Avoid the evil 'Ex' mode.
noremap Q <Nop>

map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Makes ctrl+j/k scroll history in command line.
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-h> <Home>
cnoremap <C-l> <End>

" Remap ` to ' (it's more useful this way).
nnoremap ' `
nnoremap ` '
vnoremap ' `
vnoremap ` '

"nnoremap y' y`
"nnoremap y` y'
"vnoremap y' y`
"vnoremap y` y'
"
"nnoremap d' d`
"nnoremap d` d'
"vnoremap d' d`
"vnoremap d` d'
"
"nnoremap c' c`
"nnoremap c` c'
"vnoremap c' c`
"vnoremap c` c'

" In Makefiles, don't expand tabs to spaces.
autocmd FileType make set noexpandtab

" Don't accidently hit this when using visual line selection.
map K k

" Insert timestamp.
imap <F9> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>

" Copy current absolute file path to + register.
nmap <leader>cp :let @+ = expand("%:p")<CR>

set shellslash
set mousehide
" Use whis for bufers with a few lines.
nmap <silent> ,rw :execute ":resize " . line('$')<cr>

" Show numbers only in active buffer
set number
:au WinEnter * :setlocal number
:au WinLeave * :setlocal nonumber

" Dictionary.
set dictionary+=/usr/share/dict/words

" Grep settings.
set grepprg=grep\ -rnH\ --exclude='.*.swp'\ --exclude='*~'\ --exclude=tags
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

" Setup tmp folder.
if has("unix")
	let s:tmpdir = "~/.vim/.tmp"
elseif has("win32")
	let s:tmpdir = "~\\vimfiles\\_tmp"
endif
if !exists("s:tmpdir")
	call mkdir(expand(s:tmpdir))
endif
exec "set backupdir=".expand(s:tmpdir)
exec "set directory=".expand(s:tmpdir)

" Setup undo folder.
if exists("+undofile")
	au BufWritePre /tmp/* setlocal noundofile
	if has("unix")
		let s:undodir="~/.vim/.undodir"
	elseif has("win32")
		let s:undodir="~\\vimfiles\\_undodir"
	endif
	if !exists("s:undodir")
		call mkdir(expand(s:undodir))
	endif
	exec "set undodir=".expand(s:undodir)
	set undofile
	set undolevels=5000 "maximum number of changes that can be undone
	set undoreload=50000 "maximum number lines to save for undo on a buffer reload
endif

" Force saving files that require root permission.
function! SudoWrite()
	:%!sudo tee > /dev/null %
endfun
cmap W!! w !sudo tee % >/dev/null
com! SudoWrite : call SudoWrite()

" Set filetype for opencl files.
autocmd BufNewFile,BufRead *.cl setf cc
" Set filetype for glsl files.
autocmd BufNewFile,BufRead *.vp,*.fp,*.gp,*.vs,*.fs,*.gs,*.tcs,*.tes,*.cs,*.vert,*.frag,*.geom,*.tess,*.shd,*.gls,*.glsl,*.fx,*.hlsl,*.sc,*.shdr set ft=glsl

" ========================================================================
" TODO area
" ========================================================================
" TODO: remove this (continous file editing: http://i.imgur.com/Td8Jd.png)
" noremap <silent> <leader>sb :<C-u>let @z=&so<CR>:set so=0 noscb<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>
" TODO
" set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
" set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

"------- TODO: test this
" Handy substitution.
nnoremap & :'{,'}s/<c-r>=expand('<cword>')<cr>/
vnoremap & "*y<Esc>:<c-u>'{,'}s/<c-r>=substitute(escape(@*, '\/.*$^~[]'), "\n", '\\n', "g")<cr>/
" Find current word in quickfix.
nnoremap <leader>fw :execute "vimgrep ".expand("<cword>")." %"<cr>:copen<cr>
" Find last search in quickfix.
nnoremap <leader>fs :execute 'vimgrep /'.@/.'/g %'<cr>:copen<cr>
"------
" ========================================================================

" ========================================================================
" Mirror settings
" ========================================================================
function! Mirror(command)
	let l:oldpath = expand('%:p')
	let l:escaped = substitute(l:oldpath,'[, ]\|\\[\, ]\@=','\\&','g')
	execute a:command
	execute 'e ' . l:escaped
endfunction

com! MirrorRight      : call Mirror('wincmd l')
com! MirrorSplitRight : call Mirror('vsplit | wincmd l')
com! MirrorLeft       : call Mirror('wincmd h')
com! MirrorSplitLeft  : call Mirror('vsplit | wincmd h')
com! MirrorBelow      : call Mirror('wincmd j')
com! MirrorSplitBelow : call Mirror('split | wincmd j')
com! MirrorAbove      : call Mirror('wincmd k')
com! MirrorSplitAbove : call Mirror('split | wincmd k')

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
" Mru settings
" ========================================================================
let MRU_Max_Entries = 1000
let MRU_Exclude_Files = '^/tmp/.*\|^/var/tmp/.*'  " For Unix
let MRU_Window_Height = 25
nmap <leader>mr :MRU<CR>
" ========================================================================

" ========================================================================
" Fzf
" ========================================================================
let g:fzf_command_prefix = 'Fff'
" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
" ========================================================================

" ========================================================================
" Ctags
" ========================================================================
set tags=./tags;/
function! CtagsHere()
	exec '!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .'
endfunc
function! CtagsRoot()
	:ProjectRootExe call CtagsHere()
endfunc
com! CtagsHere :call CtagsHere()
com! CtagsRoot :call CtagsRoot()
" ========================================================================

" ========================================================================
" ProjectRoot
" ========================================================================
let g:rootmarkers = ['.vim', '.git']
nnoremap <leader>cr    :ProjectRootCD<cr>
nnoremap <leader>grep  :ProjectRootExe grep<space>
nnoremap <leader>vgrep :ProjectRootExe vimgrep<space>
nnoremap <leader>ack   :ProjectRootExe Ack<space>
nnoremap <leader>ag    :ProjectRootExe Ag<space>
nnoremap <leader>pp    :ProjectRootExe FZF<cr>
" ========================================================================

" ========================================================================
" CScope "TODO !
" ========================================================================
"if has("cscope")
"	set nocscopetag
"	set csto=1
"	set cscopeverbose
"
"	"" add any cscope database in current directory
"	"if filereadable("cscope.out")
"	"    cs add cscope.out
"	"" else add the database pointed to by environment variable
"	"elseif $CSCOPE_DB != ""
"	"    cs add $CSCOPE_DB
"	"endif
"
"	"change this if it gets slow
"	function! LoadCscope()
"		let db = findfile("cscope.out", ".;")
"		if (!empty(db))
"			let path = strpart(db, 0, match(db, "/cscope.out$"))
"			set nocscopeverbose " suppress 'duplicate connection' error
"			exe "cs add " . db . " " . path
"			set cscopeverbose
"		else
"			set nocscopeverbose " suppress 'duplicate connection' error
"			cs add $CSCOPE_DB
"			set cscopeverbose
"		endif
"	endfunction
"
"	"DON'T call cscope on BufEnter
"	au BufEnter /* call LoadCscope()
"endif
" ========================================================================

" ========================================================================
" Status line
" ========================================================================

"set statusline=
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

function! GetServerName()
	return v:servername
endfunc
set statusline=#%n\ %f\%m\ [%p%%]\ >%v\ %l/%L\ [%b\ 0x%B]%=[%{getcwd()}]\ %{GetServerName()}

" Status line with file size visualization (not working properly in split mode).
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
"set statusline=%!STL()
" ========================================================================

" ========================================================================
" List chars
" ========================================================================

" Show non-visual chars.
set listchars=
set encoding=utf-8
if version >= 700
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
" Clang
" ========================================================================
"function! ClangCheck()
"	if &ft == "c" || &ft == "cpp" || &ft == "h" || &ft == "hpp"
"		call g:ClangUpdateQuickFix()
"	endif
"endfunc
"silent! nnoremap <silent> <leader>qf :call ClangCheck()<CR>
"
"if has("unix")
"	let g:clang_auto_select=0
"	let g:clang_complete_auto = 0
"	let g:clang_complete_copen = 1
"	let g:clang_hl_errors = 0
"	let g:clang_periodic_quickfix = 0
"	let g:clang_snippets = 1
"	let g:clang_snippets_engine = "clang_complete"
"	let g:clang_conceral_snippets = 1
"	let g:clang_exec="clang"
"	"let g:clang_library_path="/usr/lib/llvm-3.4/lib/"
"	let g:clang_use_library=0
"	" let g:clang_auto_user_options=1
"	" let g:clang_complete_macros=1
"	" let g:clang_complete_patterns=1
"	" let g:clang_user_options = '-std=c++11 -fexceptions -I /usr/include/c++/4.6/x84_64-linux-gnu/. -I/usr/include/c++/3.6/backward -I/usr/lib/gcc/x86_64-linux-gnu/4.6.1/include -I/usr/local/include -I/usr/lib/gcc/x86_64-linux-gnu/4.6.1/include-fixed -I/usr/include/x86_64-linux-gnu -I/usr/include/GL'
"	let g:clang_user_options = '-std=c++11'
"endif
" ========================================================================

" ========================================================================
" Quickfix and location window/list shortcuts
" ========================================================================
silent! nmap <silent> <leader>cw :cwindow 15<CR>
silent! nmap <silent> <leader>cl :clist<CR>
silent! nmap <silent> <leader>cc :cclose<CR>
silent! nmap <silent> <leader>lw :lwindow<CR>
silent! nmap <silent> <leader>ll :llist<CR>
silent! nmap <silent> <leader>lc :lclose<CR>
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
" Netrw
" ========================================================================
" let g:netrw_altv           = 1
let g:netrw_fastbrowse     = 2
let g:netrw_keepdir        = 0
let g:netrw_liststyle      = 3
let g:netrw_retmap         = 1
let g:netrw_silent         = 0
let g:netrw_special_syntax = 1
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
nnoremap <leader>ln :call NumberToggle()<cr>

" deletes all hidden buffers
function! DeleteHiddenBuffers()
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

:command! -range=% -nargs=0 Tab2Space execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'
:command! -range=% -nargs=0 Space2Tab execute '<line1>,<line2>s#^\( \{'.&ts.'\}\)\+#\=repeat("\t", len(submatch(0))/' . &ts . ')'
" ========================================================================

" ========================================================================
" OmniCppComplete
" ========================================================================
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 0 " autocomplete after .
let OmniCpp_MayCompleteArrow = 0 " autocomplete after ->
let OmniCpp_MayCompleteScope = 0 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main
" ========================================================================

" ========================================================================
" Functions for 'vim --remote-expr'
" ========================================================================
function! PrintBuildSuccessful()
	echo 'Build successful.'
endfunc

function! PrintBuildError()
	echo 'Build Error!'
endfunc

function! CGetFile(filename)
	exec 'cgetfile '.a:filename
endfunc

function! Redraw()
	redraw!
endfunc
" ========================================================================

" ========================================================================
" Path, ide and file switch.
" ========================================================================
set path=.,,**
let s:default_path = &path

let s:currRoot = ''

function! PathFunc()
    " Search for '.vim'.
    let s:vimRoot=findfile(".vimroot", ".;/")
    if exists("s:vimRoot") && filereadable(expand(s:vimRoot))
       exec 'set path-='.s:currRoot
       let s:currRoot = fnamemodify(expand(s:vimRoot), ":p:h").'/**'
       exec 'set path+='.s:currRoot
    else
       " Search for '.git'.
       let s:gitRoot=findfile(".git", ".;/")
       if exists("s:gitRoot") && filereadable(expand(s:gitRoot))
          exec 'set path-='.s:currRoot
          let s:currRoot = fnamemodify(expand(s:gitRoot), ":p:h").'/**'
          exec 'set path+='.s:currRoot
       endif
    endif

    " Find and source '.ide.vim'
    let s:ide=findfile(".ide.vim", ".;/")
    if exists("s:ide") && filereadable(expand(s:ide))
        exec "source ".s:ide
    endif
endfunction

autocmd BufRead * call PathFunc()

" \zs == start match
" \ze == end match
" <f> gets replaced with the matched name
let s:dict = { 'h'   : { '\zs.*\ze_cpp' : ['<f>.h'],
             \           '\zs.*\ze'     : ['<f>_cpp.h', '<f>.cpp' ], },
             \
             \ 'cpp' : { '\zs.*\ze'     : ['<f>.h'] },
             \
             \ 'sc'  : { 'vs_\zs.*\ze' : ['fs_<f>.sc'],
             \           'fs_\zs.*\ze' : ['vs_<f>.sc'], },
             \
             \}

function! FileSwitch()
    let name    = expand('%:r')
    let ext     = expand('%:e')

    let dict = get(s:dict, ext, {0:0})
    if has_key(dict,0)
        return
    endif

    for [pattern,matches] in items(dict)
        let basename = matchstr(name, '\v'.pattern)
        if !empty(basename)
            for item in matches
                let lookFor = substitute(item, '<f>', basename, '')
                let file = findfile(lookFor, &path)
                if exists("file") && filereadable(file)
                    execute "edit " . fnameescape(file)
                    return
                endif
            endfor
            let first = substitute(matches[0], '<f>', basename, '')
            execute "edit " . fnameescape(first)
        endif
    endfor

endfunction

com! FileSwitch :call FileSwitch()
"nmap <silent> ,sf :FileSwitch<CR>
" ========================================================================
