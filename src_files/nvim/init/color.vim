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

highlight Normal ctermbg=none
highlight Comment ctermfg=36

highlight Search ctermfg=15 ctermbg=8 guifg=White guibg=#707070
highlight Search cterm=bold ctermfg=273 ctermbg=214

highlight Statement cterm=none ctermfg=178
highlight Statement cterm=none ctermfg=208
highlight Statement cterm=none ctermfg=172

highlight LineNr cterm=none ctermfg=242
highlight LineNr cterm=bold ctermfg=172
highlight LineNr cterm=none ctermfg=172

highlight Data cterm=none ctermfg=209
highlight Data cterm=none ctermfg=203
highlight Data cterm=none ctermfg=166
highlight Data cterm=none ctermfg=06
highlight Data cterm=none ctermfg=09
highlight Data cterm=none ctermfg=160
highlight Data cterm=none ctermfg=01
highlight Data cterm=none ctermfg=brown
highlight Data cterm=none ctermfg=196
highlight! link Constant Data
highlight! link String Data

highlight PreProc cterm=bold ctermfg=06
highlight PreProc cterm=none ctermfg=140

highlight MyKeyword cterm=none ctermfg=14
autocmd BufNewFile,BufRead *.py,*.rs syntax keyword MyKeyword True
autocmd BufNewFile,BufRead *.py,*.rs syntax keyword MyKeyword False

highlight MyFuncCall cterm=none ctermfg=14
highlight MyFuncCall cterm=none ctermfg=06
highlight MyFuncCall cterm=none ctermfg=74
highlight MyFuncCall cterm=none ctermfg=none
highlight! link Identifier MyFuncCall
highlight! link Function MyFuncCall
autocmd BufNewFile,BufRead *.py,*.rs,*.c syntax match MyFuncCall "\w\(\w\)*("he=e-1,me=e-1
autocmd BufNewFile,BufRead *.py,*.rs,*.c syntax match MyFuncCall "\w\(\w\)*::<"he=e-3,me=e-3 " foo::<T>();

autocmd BufNewFile,BufRead *.c highlight MyType cterm=none ctermfg=74
autocmd BufNewFile,BufRead *.c highlight! link Type MyType

highlight MyFloat ctermbg=236
"set winhighlight=Normal:MyFloat,NormalNC:MyFloat
"highlight Normal ctermbg=none
