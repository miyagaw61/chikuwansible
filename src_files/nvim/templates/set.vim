" 行番号を表示
set number
"set relativenumber

" ビジュアルモードで選択したテキストが、クリップボードに入るようにする
" set clipboard=autoselect

" 無名レジスタに入るデータを、*レジスタにも入れる。
set clipboard+=unnamed
set clipboard+=unnamedplus

"文字コードをUFT-8に設定
set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 " 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される
set ambiwidth=double " □や○文字が崩れる問題を解決
" バックアップファイルを作らない
" set nobackup
" バックアップファイルを作る
set backupdir=~/tmp/vimbackup
set backup
" スワップファイルを作らない
" set noswapfile
" スワップファイルを作る
set directory=~/tmp/vimswap/
set swapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd
" 行末の1文字先までカーソルを移動できるように
set virtualedit=block
" ビープ音を可視化
"set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" Vimの「%」を拡張する
source $VIMRUNTIME/macros/matchit.vim
" ステータスラインを常に表示
"set laststatus=2
set laststatus=0
" コマンドラインの補完
set wildmode=list:longest
" donot fold
set nowrap

" Tab系
" 不可視文字を可視化(タブが「▸-」と表示される)
"set list listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
" ペーストモードに
set nopaste " XXX: I used paste
" 改行時に前の行のインデントを継続する
set autoindent " set ai/noai
" 改行時に前の行の構文をチェックし次の行のインデントを増減する
set smartindent " set si/nosi
" 直前のインデントをコピー
set copyindent " set ci/noci
" 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
" -1だとshiftwidthに従う
set softtabstop=-1 " set sts=-1
" 行頭でのTab文字の表示幅
" 0だとtabstopに従う
set shiftwidth=0 " set sw=0
" 行頭以外のTab文字の表示幅（スペースいくつ分）
" ここの変更のみでインデントの幅を調整
set tabstop=8 " set ts=8
" Tab文字を半角スペースにする/しない
" ここの変更のみでインデントの種類を調整
set noexpandtab " set et/noet

" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
"バックスペースを、空白、行末、行頭でも使えるようにする
set backspace=indent,eol,start
"クリップボード共有
set clipboard&
set clipboard^=unnamedplus

" カーソルの回り込みができるようになる
set nocompatible
set whichwrap=b,s,h,l,[,],<,>,~


" コマンドモードの補完
set wildmenu
" 保存するコマンド履歴の数
set history=5000

" 現在の行を強調表示
"set cursorline
" 現在の行を強調表示（縦）
"set cursorcolumn
" アンダーラインを引く(gui)
"highlight CursorLine gui=underline guifg=NONE guibg=NONE

set tags+=./GTAGS;
set tags+=./GRTAGS;
set tags+=./GPATH;

"status line
"===========
" ファイル名表示
set statusline=%f
" 変更チェック表示
set statusline+=%m
" 読み込み専用かどうか表示
set statusline+=%r
" ヘルプページなら[HELP]と表示
set statusline+=%h
" プレビューウインドウなら[Prevew]と表示
set statusline+=%w
" これ以降は右寄せ表示
set statusline+=%=
" file encoding
set statusline+=[ENC=%{&fileencoding}]
" 現在行数/全行数
set statusline+=[LOW=%l/%L]
" ステータスラインを常に表示(0:表示しない、1:2つ以上ウィンドウがある時だけ表示)
set laststatus=2

"ビープ音を消す
set visualbell t_vb=

"日本語をスペルチェックの対象から外す
set spelllang=en,cjk

"自動移動
"set autochdir

set runtimepath+={{config_files}}/nvim/repos/github.com/KeitaNakamura/neodark.vim

