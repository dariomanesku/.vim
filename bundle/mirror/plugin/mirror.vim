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
nmap <silent> <leader>ml :MirrorRight<CR>
nmap <silent> <leader>mL :MirrorSplitRight<CR>
nmap <silent> <leader>mh :MirrorLeft<CR>
nmap <silent> <leader>mH :MirrorSplitLeft<CR>
nmap <silent> <leader>mk :MirrorAbove<CR>
nmap <silent> <leader>mK :MirrorSplitAbove<CR>
nmap <silent> <leader>mj :MirrorBelow<CR>
nmap <silent> <leader>mJ :MirrorSplitBelow<CR>
" ======================================================================== 
