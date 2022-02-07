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

autocmd BufNewFile,BufEnter,BufRead * highlight MyFuncCall cterm=none ctermfg=06
autocmd BufNewFile,BufEnter,BufRead * highlight MyFuncCall cterm=none ctermfg=74
autocmd BufNewFile,BufEnter,BufRead * highlight MyFuncCall cterm=none ctermfg=none
autocmd BufNewFile,BufEnter,BufRead * highlight MyFuncCall cterm=none ctermfg=14
autocmd BufNewFile,BufEnter,BufRead * highlight MyFuncCall cterm=none ctermfg=81

autocmd BufNewFile,BufEnter,BufRead * highlight! link Identifier MyFuncCall
autocmd BufNewFile,BufEnter,BufRead * highlight! link Function MyFuncCall

autocmd BufNewFile,BufEnter,BufRead *.py,*.rs,*.c,*.cpp,*.h syntax match MyFuncCall "\w\(\w\)*("he=e-1,me=e-1
autocmd BufNewFile,BufEnter,BufRead *.py,*.rs,*.c,*.cpp,*.h syntax match MyFuncCall "\w\(\w\)*::<"he=e-3,me=e-3 " foo::<T>();
autocmd BufNewFile,BufEnter,BufRead *.py,*.rs,*.c,*.cpp,*.h syntax match MyFuncCall "\w\(\w\)*)("he=e-2,me=e-2 " (foo)();

autocmd BufNewFile,BufEnter,BufRead * highlight Builtin cterm=none ctermfg=123
autocmd BufNewFile,BufEnter,BufRead * highlight Builtin cterm=none ctermfg=159
autocmd BufNewFile,BufEnter,BufRead * highlight! link pythonBuiltin Builtin

autocmd BufNewFile,BufEnter,BufRead *.c,*.cpp,*.h highlight MyType cterm=none ctermfg=74
autocmd BufNewFile,BufEnter,BufRead *.c,*.cpp,*.h highlight! link Type MyType

autocmd BufNewFile,BufEnter,BufRead *.c,*.cpp,*.h,*.rs,*.py highlight MyFloat ctermbg=236
"set winhighlight=Normal:MyFloat,NormalNC:MyFloat
"highlight Normal ctermbg=none

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlight Current Word
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Initialize of HighlightCurrentWord
" ==================================
source $VIMRUNTIME/macros/matchit.vim
function! s:InitHighlightCurrentWord()
  if !exists("w:current_match")
   let w:current_match = ""
  endif
  if !exists("w:current_matchit")
   let w:current_matchit = ""
  endif
  if !exists("w:current_cword")
   let w:current_cword = ""
  endif
  if !exists("w:current_matchit1")
   let w:current_matchit1 = ""
  endif
  if !exists("w:current_matchit2")
   let w:current_matchit2 = ""
  endif
  if !exists("w:current_matchit3")
   let w:current_matchit3 = ""
  endif
  if !exists("w:current_matchit4")
   let w:current_matchit4 = ""
  endif
endfunction

" Get Matchit Pattern
" ===================
function! s:GetMatchitPattern(cwd)
  if !exists('b:match_words')
    return ''
  endif
  if !exists('b:mw')
    call s:InitMatchit()
  endif
  for pat in b:mw
    if a:cwd =~# pat
      let l:cmw = pat
      break
    endif
  endfor
  for pat in b:new_mw
    if a:cwd =~# pat
      let l:cmw = pat
    endif
  endfor
  if !exists("l:cmw")
    return ''
  endif

  let lcs = []
  let wsv = winsaveview()
  while 1
    exe 'normal %'
    let lc = {'line': line('.'), 'col': col('.')}
    if len(lcs) > 0
      if (lc.line == lcs[0].line && lc.col == lcs[0].col) || (lc.line == lcs[-1].line && lc.col == lcs[-1].col)
        break
      endif
    endif
    call add(lcs, lc)
  endwhile
  echo lcs
  call winrestview(wsv)
  call map(lcs, '"\\%" . v:val.line . "l\\%" . v:val.col . "c"')
  let lcre = join(lcs, '\|')
  return '.*\%(' . lcre . '\).*\&' .
         \b:new_mwre . '\|' .
         \b:mwre
endfunction

" Initialize of Matchit
" ==================
function! s:InitMatchit()
  if !exists('b:match_words')
    return
  endif
  let b:mw = split(b:match_words, ',\|:')
  let l:mw = filter(b:mw, 'v:val !~ "^[(){}[\\]]$"')
  let mwre = join(l:mw, '\|') . '\)'
  let b:mwre = substitute(mwre, "'", "''", 'g')
  let b:new_mw = ["\\<function\\>", "\\<elseif\\>", "\\<endif\\>", "\\<endfor\\>"]
  let b:new_mwre = "\\%\\(" . join(b:new_mw, '\|')
endfunction

" Highlight Color List
" ====================
highlight CurrentWord term=NONE cterm=bold ctermbg=154 ctermfg=273
highlight CurrentWord term=NONE cterm=bold ctermbg=22 ctermfg=255
highlight CurrentWord term=NONE ctermbg=19 ctermfg=NONE
highlight CurrentWord term=NONE cterm=bold ctermbg=10 ctermfg=273

highlight MatchitWord term=NONE ctermbg=DarkMagenta ctermfg=273 cterm=bold
highlight MatchParen term=NONE ctermbg=DarkMagenta ctermfg=273 cterm=bold
highlight CurrentCword term=NONE ctermbg=14 ctermfg=273 cterm=bold

highlight Matchit1 term=NONE ctermbg=brown ctermfg=273 cterm=bold
highlight Matchit2 term=NONE ctermbg=blue ctermfg=273 cterm=bold
highlight Matchit3 term=NONE ctermbg=100 ctermfg=273 cterm=bold
highlight Matchit4 term=NONE ctermbg=magenta ctermfg=273 cterm=bold

" Escape Text
" ===========
function! s:EscapeText( text )
  return substitute( escape(a:text, '\' . '^$.*[~'), "\n", '\\n', 'ge' )
endfunction

" Get Current Word
" ================
function! s:GetCurrentWord()
  let l:cword = expand('<cWORD>')
  if l:cword[0] == "#"
  else
    let l:cword = expand('<cword>')
  endif
  let l:cchar = getline('.')[col('.')-1]
  if l:cchar == "\("
    let l:cword = "\("
  elseif l:cchar == "\{"
    let l:word = "\{"
  endif
  if !empty(l:cword)
    let l:regexp = s:EscapeText(l:cword)
    if l:cword =~# '^\k\+$'
      let l:regexp = '\<' . l:regexp . '\>'
    endif
    return l:regexp
  else
    return ''
  endif
endfunction

" Delete All Matches
" ==================
function! DeleteAllMatches()
    if exists("w:current_match")
      if w:current_match != ""
        echo w:current_match
        call matchdelete(w:current_match)
        let w:current_match = ""
      endif
    endif
    if exists("w:current_matchit") 
      if w:current_matchit != ""
        call matchdelete(w:current_matchit)
        let w:current_matchit = ""
      endif
    endif
    if exists("w:current_cword") 
      if w:current_cword != ""
        call matchdelete(w:current_cword)
        let w:current_cword = ""
      endif
    endif
endfunction

" Highlight Current Word (Main Function)
" ======================================
function! s:HighlightCurrentWord()
  let l:word = s:GetCurrentWord()
  if !empty(l:word)
    call DeleteAllMatches()
    let w:current_match = matchadd('CurrentWord', l:word, 0)
  endif
  let l:matchit_word = s:GetMatchitPattern(l:word) " getline('.') is better but it's heavy
  if !empty(l:matchit_word)
    let w:current_matchit = matchadd('MatchitWord', l:matchit_word, 0)
  endif
  if !empty(l:word)
    let l:current_cword = '\w*\%' . line('.') . 'l\%' . col('.') . 'c\w*\&\%\(' . l:word .'\)'
    let w:current_cword = matchadd('CurrentCword', l:current_cword, 0)
  endif
endfunction

" Autocmd for Highlight Current Word
" ==================================
augroup cwh
  autocmd!
  autocmd BufNewFile,BufEnter *.vim,*.py,*.rs,*.c,*.cpp,*.h call s:InitHighlightCurrentWord()
  "autocmd BufNewFile,BufEnter *.vim,*.py,*.rs,*.c,*.cpp,*.h call DeleteAllMatches()
  autocmd CursorMoved,CursorMovedI *.vim,*.py,*.rs,*.c,*.cpp,*.h call s:HighlightCurrentWord()
augroup END


" HighlightMatchit1
" =================
command! -nargs=? HighlightMatchit1 call HighlightMatchit1()
function! HighlightMatchit1()
  let l:word = s:GetCurrentWord()
  if !empty(l:word)
    call DeleteAllMatches()
  endif
  let l:matchit_word = s:GetMatchitPattern(l:word) " getline('.') is better but it's heavy
  if !empty(l:matchit_word)
    let w:current_matchit1 = matchadd('Matchit1', l:matchit_word, 0)
  endif
endfunction
command! -nargs=? H1 call HighlightMatchit1()

" DeleteHighlightMatchit1
" =======================
command! -nargs=? DeleteHighlightMatchit1 call DeleteHighlightMatchit1()
function! DeleteHighlightMatchit1()
  if !empty(w:current_matchit1)
    call matchdelete(w:current_matchit1)
    let w:current_matchit1 = ""
  endif
endfunction
command! -nargs=? D1 call DeleteHighlightMatchit1()

" HighlightMatchit2
" =================
command! -nargs=? HighlightMatchit2 call HighlightMatchit2()
function! HighlightMatchit2()
  let l:word = s:GetCurrentWord()
  if !empty(l:word)
    call DeleteAllMatches()
  endif
  let l:matchit_word = s:GetMatchitPattern(l:word) " getline('.') is better but it's heavy
  if !empty(l:matchit_word)
    let w:current_matchit2 = matchadd('Matchit2', l:matchit_word, 0)
  endif
endfunction
command! -nargs=? H2 call HighlightMatchit2()

" DeleteHighlightMatchit2
" =======================
command! -nargs=? DeleteHighlightMatchit2 call DeleteHighlightMatchit2()
function! DeleteHighlightMatchit2()
  if !empty(w:current_matchit2)
    call matchdelete(w:current_matchit2)
    let w:current_matchit2 = ""
  endif
endfunction
command! -nargs=? D2 call DeleteHighlightMatchit2()

" HighlightMatchit3
" =================
command! -nargs=? HighlightMatchit3 call HighlightMatchit3()
function! HighlightMatchit3()
  let l:word = s:GetCurrentWord()
  if !empty(l:word)
    call DeleteAllMatches()
  endif
  let l:matchit_word = s:GetMatchitPattern(l:word) " getline('.') is better but it's heavy
  if !empty(l:matchit_word)
    let w:current_matchit3 = matchadd('Matchit3', l:matchit_word, 0)
  endif
endfunction
command! -nargs=? H3 call HighlightMatchit3()

" DeleteHighlightMatchit3
" =======================
command! -nargs=? DeleteHighlightMatchit3 call DeleteHighlightMatchit3()
function! DeleteHighlightMatchit3()
  if !empty(w:current_matchit3)
    call matchdelete(w:current_matchit3)
    let w:current_matchit3 = ""
  endif
endfunction
command! -nargs=? D3 call DeleteHighlightMatchit3()

" HighlightMatchit4
" =================
command! -nargs=? HighlightMatchit4 call HighlightMatchit4()
function! HighlightMatchit4()
  let l:word = s:GetCurrentWord()
  if !empty(l:word)
    call DeleteAllMatches()
  endif
  let l:matchit_word = s:GetMatchitPattern(l:word) " getline('.') is better but it's heavy
  if !empty(l:matchit_word)
    let w:current_matchit4 = matchadd('Matchit4', l:matchit_word, 0)
  endif
endfunction
command! -nargs=? H4 call HighlightMatchit4()

" DeleteHighlightMatchit4
" =======================
command! -nargs=? DeleteHighlightMatchit4 call DeleteHighlightMatchit4()
function! DeleteHighlightMatchit4()
  if !empty(w:current_matchit4)
    call matchdelete(w:current_matchit4)
    let w:current_matchit4 = ""
  endif
endfunction
command! -nargs=? D4 call DeleteHighlightMatchit4()

" DeleteHighlightMatchitAll
" =========================
command! -nargs=? DeleteHighlightMatchitAll call DeleteHighlightMatchitAll()
function! DeleteHighlightMatchitAll()
  call DeleteHighlightMatchit1()
  call DeleteHighlightMatchit2()
  call DeleteHighlightMatchit3()
  call DeleteHighlightMatchit4()
endfunction
command! -nargs=? Da call DeleteHighlightMatchitAll()
