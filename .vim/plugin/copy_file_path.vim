function! g:CopyFilePath()
  let @* = expand("%:p")
  echo @*
endfunction

command! CopyFilePath :call g:CopyFilePath()
