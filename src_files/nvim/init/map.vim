" :vim <str> %
nnoremap [q :cprevious<CR> " 前へ
nnoremap ]q :cnext<CR> " 次へ
nnoremap [Q :<C-u>cfirst<CR> " 最初へ
nnoremap ]Q :<C-u>clast<CR> " 最後へ

" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

"SET LEADER
let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>
"nnoremap <Leader>b :%!xxd -r<CR>

noremap j gj
noremap k gk
nnoremap gj <C-w>j
nnoremap gk <C-w>k
nnoremap gh <C-w>h
nnoremap gl <C-w>l
nnoremap [Window] <Nop>
nmap s [Window]
nmap <Space> [Space]
inoremap <C-j> <esc>
inoremap <C-a> <home>
inoremap <C-e> <end>
"inoremap <C-h> <left>
"inoremap <C-l> <right>
"nnoremap <leader>vim :set syntax=vim<CR>
"nnoremap <leader>python :set syntax=python<CR>
"nnoremap <leader>clang :set syntax=python<CR>
"nnoremap <leader>md :set syntax=markdown<CR>
"nnoremap <leader>jelly :colorscheme jellybeans<CR>
"nnoremap <leader>molokai :colorscheme molokai<CR>
"nnoremap <leader>kalisi :colorscheme kalisi<CR>:set background=light<CR>
"nnoremap <leader>neodark :colorscheme neodark<CR>
"nnoremap <leader>repos :cd $REPOS<CR>
nnoremap gGCf <C-f>
nnoremap gGCb <C-b>
nnoremap gGCe <C-e>
nnoremap gGCy <C-y>
nnoremap gGCd <C-d>
nnoremap gGCu <C-u>
tnoremap <Esc> <C-\><C-n>
tnoremap <C-j> <C-\><C-n>
nnoremap <Tab> <Nop>
nnoremap [Window]n :tabn<CR>
nnoremap e :cd %:p:h<CR>:e<Space>
vmap # :<BS><BS><BS><BS><BS>let @/ = @"<CR>:'<,'>s/<C-r>///g<Left><Left>
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
vnoremap <C-l> <Esc>

"terminal mapping
nnoremap [Space]d  :!echo "%:p:h" > /tmp/deol_cd.tmp<CR>:b bash<CR>icd $(cat /tmp/deol_cd.tmp);<Space>
nnoremap [Space]rr :MyRustRun<Space>
nnoremap [Space]r :MyRustRun<Space>
nnoremap [Space]t  :Deol<CR>
nnoremap [Space]ga :!rusgit add %:p<CR>
nnoremap [Space]gc :!rusgit ac %:p -m 
nnoremap [Space]gs :GitStatus %:p<CR>
nnoremap [Space]gl :GitLog %:p 
nnoremap [Space]gd :GitDiff %:p 
nnoremap [Space]rc :QuickRun -args<Space>
nnoremap [Space]rp :QuickRun -args<Space>

"cursor moving
inoremap <C-a>a <Esc><Right>fAi
inoremap <C-1>B <Esc><Right>fBi
inoremap <C-1>C <Esc><Right>fCi
inoremap <C-1>D <Esc><Right>fDi
inoremap <C-1>E <Esc><Right>fEi
inoremap <C-1>F <Esc><Right>fFi
inoremap <C-1>G <Esc><Right>fGi
inoremap <C-1>H <Esc><Right>fHi
inoremap <C-1>I <Esc><Right>fIi
inoremap <C-1>J <Esc><Right>fJi
inoremap <C-1>K <Esc><Right>fKi
inoremap <C-1>L <Esc><Right>fLi
inoremap <C-1>M <Esc><Right>fMi
inoremap <C-1>N <Esc><Right>fNi
inoremap <C-1>O <Esc><Right>fOi
inoremap <C-1>P <Esc><Right>fPi
inoremap <C-1>Q <Esc><Right>fQi
inoremap <C-1>R <Esc><Right>fRi
inoremap <C-1>S <Esc><Right>fSi
inoremap <C-1>T <Esc><Right>fTi
inoremap <C-1>U <Esc><Right>fUi
inoremap <C-1>V <Esc><Right>fVi
inoremap <C-1>W <Esc><Right>fWi
inoremap <C-1>X <Esc><Right>fXi
inoremap <C-1>Y <Esc><Right>fYi
inoremap <C-1>Z <Esc><Right>fZi
"inoremap <C-f>[ <Esc><Right>f[i
"inoremap <C-f>\ <Esc><Right>f\i
"inoremap <C-f>] <Esc><Right>f]i
"inoremap <C-f>^ <Esc><Right>f^i
"inoremap <C-f>_ <Esc><Right>f_i
"inoremap <C-f>` <Esc><Right>f`i
inoremap <C-f>a <Esc><Right>fai
inoremap <C-f>b <Esc><Right>fbi
inoremap <C-f>c <Esc><Right>fci
inoremap <C-f>d <Esc><Right>fdi
inoremap <C-f>e <Esc><Right>fei
inoremap <C-f>f <Esc><Right>ffi
inoremap <C-f>g <Esc><Right>fgi
inoremap <C-f>h <Esc><Right>fhi
inoremap <C-f>i <Esc><Right>fii
inoremap <C-f>j <Esc><Right>fji
inoremap <C-f>k <Esc><Right>fki
inoremap <C-f>l <Esc><Right>fli
inoremap <C-f>m <Esc><Right>fmi
inoremap <C-f>n <Esc><Right>fni
inoremap <C-f>o <Esc><Right>foi
inoremap <C-f>p <Esc><Right>fpi
inoremap <C-f>q <Esc><Right>fqi
inoremap <C-f>r <Esc><Right>fri
inoremap <C-f>s <Esc><Right>fsi
inoremap <C-f>t <Esc><Right>fti
inoremap <C-f>u <Esc><Right>fui
inoremap <C-f>v <Esc><Right>fvi
inoremap <C-f>w <Esc><Right>fwi
inoremap <C-f>x <Esc><Right>fxi
inoremap <C-f>y <Esc><Right>fyi
inoremap <C-f>z <Esc><Right>fzi

"test
function! s:set_vsearch()
  silent normal gv"zy
  let @/ = '\V' . substitute(escape(@z, '/\'), '\n', '\\n', 'g')
endfunction
vnoremap <silent> <Space>a mz:call <SID>set_vsearch()<CR>:set hlsearch<CR>`z/<C-r>/<CR>N
"nnoremap [Space]n n
"nnoremap [Space]p N
nnoremap [Space]s mz:call <SID>set_vsearch()<CR>:set hlsearch<CR>`z/<C-r>/<CR>N:%s/<C-r>///g<Left><Left>
nnoremap [Space]o :copen 30<CR>

"clipboard copy paste for tera term
vnoremap <C-c> :'<,'>w !xsel --clipboard --input<CR><CR>:!xsel --clipboard --output<CR>

" grep
nnoremap [Window]g :Frepl %:p 
