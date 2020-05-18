syntax on
"set background=light
set t_ut=
"set termguicolors
colorscheme neodark
"set t_AB=[48;2;%lu;%lu;%lum
"set t_Sb=[48;2;%lu;%lu;%lum
"set t_8b=[48;2;%lu;%lu;%lum

"UNDER LINE
"==========
"highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE

"SYNTAX/HIGHLIGHT
"================

autocmd BufNewFile,BufEnter,BufRead * highlight Normal ctermbg=none
autocmd BufNewFile,BufEnter,BufRead * highlight Comment ctermfg=36

autocmd BufNewFile,BufEnter,BufRead * highlight Search ctermfg=15 ctermbg=8 guifg=White guibg=#707070
autocmd BufNewFile,BufEnter,BufRead * highlight Search cterm=bold ctermfg=273 ctermbg=214

autocmd BufNewFile,BufEnter,BufRead * highlight Statement cterm=none ctermfg=178
autocmd BufNewFile,BufEnter,BufRead * highlight Statement cterm=none ctermfg=208
autocmd BufNewFile,BufEnter,BufRead * highlight Statement cterm=none ctermfg=172

autocmd BufNewFile,BufEnter,BufRead * highlight LineNr cterm=none ctermfg=242
autocmd BufNewFile,BufEnter,BufRead * highlight LineNr cterm=bold ctermfg=172
autocmd BufNewFile,BufEnter,BufRead * highlight LineNr cterm=none ctermfg=172

autocmd BufNewFile,BufEnter,BufRead * highlight Data cterm=none ctermfg=209
autocmd BufNewFile,BufEnter,BufRead * highlight Data cterm=none ctermfg=203
autocmd BufNewFile,BufEnter,BufRead * highlight Data cterm=none ctermfg=166
autocmd BufNewFile,BufEnter,BufRead * highlight Data cterm=none ctermfg=06
autocmd BufNewFile,BufEnter,BufRead * highlight Data cterm=none ctermfg=09
autocmd BufNewFile,BufEnter,BufRead * highlight Data cterm=none ctermfg=160
autocmd BufNewFile,BufEnter,BufRead * highlight Data cterm=none ctermfg=01
autocmd BufNewFile,BufEnter,BufRead * highlight Data cterm=none ctermfg=brown
autocmd BufNewFile,BufEnter,BufRead * highlight Data cterm=none ctermfg=196
autocmd BufNewFile,BufEnter,BufRead * highlight! link Constant Data
autocmd BufNewFile,BufEnter,BufRead * highlight! link String Data

autocmd BufNewFile,BufEnter,BufRead * highlight PreProc cterm=bold ctermfg=06
autocmd BufNewFile,BufEnter,BufRead * highlight PreProc cterm=none ctermfg=140

autocmd BufNewFile,BufEnter,BufRead * highlight MyKeyword cterm=none ctermfg=14

autocmd BufNewFile,BufEnter,BufRead *.py,*.rs syntax keyword MyKeyword True
autocmd BufNewFile,BufEnter,BufRead *.py,*.rs syntax keyword MyKeyword False
autocmd BufNewFile,BufEnter,BufRead *.py,*.rs syntax keyword MyKeyword None

autocmd BufNewFile,BufEnter,BufRead * highlight MyFuncCall cterm=none ctermfg=14
autocmd BufNewFile,BufEnter,BufRead * highlight MyFuncCall cterm=none ctermfg=06
autocmd BufNewFile,BufEnter,BufRead * highlight MyFuncCall cterm=none ctermfg=74
autocmd BufNewFile,BufEnter,BufRead * highlight MyFuncCall cterm=none ctermfg=none

autocmd BufNewFile,BufEnter,BufRead * highlight! link Identifier MyFuncCall
autocmd BufNewFile,BufEnter,BufRead * highlight! link Function MyFuncCall

autocmd BufNewFile,BufEnter,BufRead *.py,*.rs,*.c syntax match MyFuncCall "\w\(\w\)*("he=e-1,me=e-1
autocmd BufNewFile,BufEnter,BufRead *.py,*.rs,*.c syntax match MyFuncCall "\w\(\w\)*::<"he=e-3,me=e-3 " foo::<T>();

autocmd BufNewFile,BufEnter,BufRead * highlight Builtin cterm=none ctermfg=123
autocmd BufNewFile,BufEnter,BufRead * highlight Builtin cterm=none ctermfg=159
autocmd BufNewFile,BufEnter,BufRead * highlight! link pythonBuiltin Builtin

autocmd BufNewFile,BufEnter,BufRead *.c highlight MyType cterm=none ctermfg=74
autocmd BufNewFile,BufEnter,BufRead *.c highlight! link Type MyType

autocmd BufNewFile,BufEnter,BufRead *.c,*.cpp,*.h,*.rs,*.py highlight MyFloat ctermbg=236
"set winhighlight=Normal:MyFloat,NormalNC:MyFloat
"highlight Normal ctermbg=none
