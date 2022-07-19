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
"autocmd BufNewFile,BufRead *.rs  let g:quickrun_config.rust = {'command': 'cargo run', 'exec' : '%C --bin %S:t:r -- %a'}
"autocmd BufNewFile,BufRead *.crs let g:quickrun_config.rust = {'command': 'cargo script', 'exec' : '%C %S -- %a'}
autocmd BufNewFile,BufRead *.rs let g:quickrun_config.rust = {'exec' : 'mold -run cargo check --color=always', 'hook/sweep/enable' : 0}
autocmd BufNewFile,BufRead *.rs let g:quickrun_config.clippy = {'exec' : 'cargo clippy --color=always', 'hook/sweep/enable' : 0}
autocmd BufNewFile,BufRead *.rs let g:quickrun_config.rust_build = {'exec' : 'mold -run cargo build --color=always', 'hook/sweep/enable' : 0}
autocmd BufNewFile,BufRead *.rs let g:quickrun_config.rust_test = {'exec' : 'mold -run cargo test --color=always -- --nocapture', 'hook/sweep/enable' : 0}
autocmd BufNewFile,BufRead *.rs let g:quickrun_config.rust_test = {'exec' : 'mold -run cargo test --color=always', 'hook/sweep/enable' : 0}
autocmd BufNewFile,BufRead *.rs nnoremap [Space]r :w<CR>:silent !sync<CR>:QuickRun<CR>
autocmd BufNewFile,BufRead *.rs nnoremap [Space]c :w<CR>:silent !sync<CR>:QuickRun -type clippy<CR>
autocmd BufNewFile,BufRead *.rs nnoremap [Space]t :w<CR>:silent !sync<CR>:QuickRun -type rust_test<CR>

autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!
"autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/
"autocmd BufWrite *.rs :silent exec "!rusty-tags vi --start-dir=" . expand('%:p:h') . "&"
