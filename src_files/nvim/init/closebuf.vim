function! CloseBuf()
  if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    :q
  else
    :bd!
  endif
endfunction

nnoremap <Leader>q :up<CR>:silent !sync<CR>:call CloseBuf()<CR>
