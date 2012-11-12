function! Mirror(command)
    let oldpath = expand('%:p')
    execute a:command
    execute 'e ' . oldpath
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
map <silent> ,ml :MirrorRight<CR>
map <silent> ,mL :MirrorSplitRight<CR>
map <silent> ,mh :MirrorLeft<CR>
map <silent> ,mH :MirrorSplitLeft<CR>
map <silent> ,mk :MirrorAbove<CR>
map <silent> ,mK :MirrorSplitAbove<CR>
map <silent> ,mj :MirrorBelow<CR>
map <silent> ,mJ :MirrorSplitBelow<CR>
" ======================================================================== 
