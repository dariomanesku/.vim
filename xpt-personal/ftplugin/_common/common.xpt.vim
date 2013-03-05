XPTemplate priority=personal

let s:f = g:XPTfuncs()

fun! s:f.headerSymbol( prefix ) "{{{
  let h = expand('%:t')
  let h = substitute(h, '\.', '_', 'g') " replace . with _
  let h = substitute(h, '.', '\U\0', 'g') " make all characters upper case

  return '__'.a:prefix.'_'.h.'__'
endfunction "}}}
