"最後のカーソル位置を記憶
"=========================
augroup vimrcEx
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") |
    \ exe "normal g`\"" | endif
    au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
    \ exe "normal g`\"" | endif
augroup END

"autocmd! TermClose * call s:termexit()

autocmd BufLeave * if exists('b:term_title') && exists('b:terminal_job_pid') | execute ":file term" . b:terminal_job_pid . "/" . b:term_title

autocmd BufNewFile,BufRead *.crs setf rust
autocmd BufNewFile,BufRead *.rs  let g:quickrun_config.rust = {'command': 'cargo run', 'exec' : '%C --bin %S:t:r -- %a'}
autocmd BufNewFile,BufRead *.crs let g:quickrun_config.rust = {'command': 'cargo script', 'exec' : '%C %S -- %a'}
autocmd BufNewFile,BufRead *.rs  let g:quickrun_config.test = {'command': 'cargo test', 'exec' : '%C --bin %S:t:r -- %a'}

"autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
"autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!
autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/
autocmd BufWrite *.rs :silent exec "!rusty-tags vi --start-dir=" . expand('%:p:h') . "&"
