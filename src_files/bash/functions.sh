jmp() {
    if test $# -eq 0 ;then
        cat $REPOS/mgtools/conf/jmp.conf
    elif test $1 = "add" ;then
        echo "$2: $(pwd)" >> $REPOS/mgtools/conf/jmp.conf
    else
        cd $(rg "$1: (.*)" -r '$1' -N $REPOS/mgtools/conf/jmp.conf)
    fi
}

recgif(){
    export WINDOWID=$(xdotool getwindowfocus)
    ttyrec /tmp/.gif_record
}

mkgif(){
    export WINDOWID=$(xdotool getwindowfocus)
    ttygif /tmp/.gif_record
    if test $# -ge 1 ;then
        mv tty.gif $1
        echo "[+]mv tty.gif "$1
    fi
    rm -rf /tmp/.gif_record
}

repobase(){
    now=$(pwd)/
    if test "$(echo $now | rg "/mnt/c/Users/miyagaw61/home/")" ;then
        now=$(echo $now | rg "/mnt/c/Users/miyagaw61/home/" -r "/home/miyagaw61/")
    fi
    now=$(echo "$now" | sed -E "s@$REPOS@@g")
    now=$(echo "$now" | sed -E "s@^/@@g")
    repo=$(echo "$now" | sed -E "s@/.*@@g")
    cd $REPOS/$repo
}

nv(){
    if test $# -eq 0 ;then
        nvr -c "Denite buffer"
    fi
    nvr -c "e "$(realpath $1)
}

nd(){
    nvr -c "cd "$(realpath $1)
}

#repos(){
#    var=$(rg --files $REPOS | rsed '[^/]*$' '' | sort | uniq | fzf2nd)
#    if test "$var" ;then
#        cd $var
#    fi
#}
#
red(){ #この関数を作らないとゼロマッチの時に何も出力されない
    arg="$(cat -)"
    echo "$arg" | rg "$1" -r "$2" -C 9999999999999999999
}

#readline_injection() {
#  READLINE_LINE="$READLINE_LINE | hoge"
#  READLINE_POINT=${#READLINE_LINE}
#}
#bind -x '"\C-j":readline_injection'

h_func() {
    cd $HOME/$1
}
h_completion() {
    local cur prev cword opts
    _get_comp_words_by_ref -n : cur prev cword
    COMPREPLY=( $(compgen -W "$(ls -F $HOME/ | rg '(.*)/$' -r '$1')" -- "${cur}") )
}
complete -F h_completion h_func
complete -F h_completion h

r_func() {
    cd $HOME/repos/$1
}
r_completion() {
    local cur prev cword opts
    _get_comp_words_by_ref -n : cur prev cword
    COMPREPLY=( $(compgen -W "$(ls -F $HOME/repos/ | rg '(.*)/$' -r '$1')" -- "${cur}") )
}
complete -F r_completion r_func
complete -F r_completion r

e_func() {
    cd $HOME/events/$1
}
e_completion() {
    local cur prev cword opts
    _get_comp_words_by_ref -n : cur prev cword
    COMPREPLY=( $(compgen -W "$(ls -F $HOME/events/ | rg '(.*)/$' -r '$1')" -- "${cur}") )
}
complete -F e_completion e_func
complete -F e_completion e

d_func() {
    cd $HOME/docs/$1
}
d_completion() {
    local cur prev cword opts
    _get_comp_words_by_ref -n : cur prev cword
    COMPREPLY=( $(compgen -W "$(ls -F $HOME/docs/ | rg '(.*)/$' -r '$1')" -- "${cur}") )
}
complete -F d_completion d_func
complete -F d_completion d

malist() {
	rg --files -g*.exe -g*.bat -g*.scr -g*.rtf -g*.cpl -g*.jar -g*.lnk | while read line ;do cp -a $line $1/$line ;done
}

pd() {
    if test "$1" == "-h" -o "$1" == "--help" -o $# -eq 0 ;then
        echo "pd [file-name] [line-num]"
    else
        cp -a $1 pd_tmp.py
        space_num=$(sed -n ${2}p pd_tmp.py | sed -E "s@(^ *).*@\1@g" | wc -m)
        spaces=""
        if test ${space_num} -gt 1 ;then
            space_num=$((${space_num}-2))
            for i in $(seq 0 ${space_num}) ;do
                spaces="${spaces} "
            done
        fi
        after="${spaces}""import ptpdb; ptpdb.set_trace()"
        sed -E "$((${2}-1))a_PDHOGE_" -i pd_tmp.py
        sed -E "s@_PDHOGE_@""${after}""@g" -i pd_tmp.py
        python pd_tmp.py
        rm -rf pd_tmp.py
    fi
}

getref() {
    url=$1
    title="$(curl -s ${url} | rg ".*<title>(.*)</title>.*" -r '$1')"
    archive="$(curl -s -H "User-Agent:archiveis (https://github.com/pastpages/archiveis)" -X POST http://archive.is/submit/ -d "url=${url}" -i | rg ".*:.*(http://archive.is/.*)" -r '$1' | tr -d '\r')"
    if test "$archive" ;then
        echo "・[${title}](${url}) ( [archive](${archive}) )"
    else
        echo "・[${title}](${url})"
    fi
}

getrefs() {
    cat $1 | while read url ;do
        title="$(curl -s ${url} | rg ".*<title>(.*)</title>.*" -r '$1')"
        archive="$(curl -s -H "User-Agent:archiveis (https://github.com/pastpages/archiveis)" -X POST http://archive.is/submit/ -d "url=${url}" -i | rg ".*:.*(http://archive.is/.*)" -r '$1' | tr -d '\r')"
        if test "$archive" ;then
            echo "・[${title}](${url}) ( [archive](${archive}) )"
        else
            echo "・[${title}](${url})"
        fi
    done
}

cp4sh() {
    if test $# -eq 0 -o "$1" == "-h" ;then
        echo "cp4sh [file_base_name]"
    else
        onefile copy bash $1
    fi
}

mk4sh() {
    if test $# -eq 0 -o "$1" == "-h" ;then
        echo "mk4sh [file_base_name]"
    else
        onefile template bash $1
    fi
}

cp4vi() {
    if test $# -eq 0 -o "$1" == "-h" ;then
        echo "cp4vi [file_base_name]"
    else
        onefile copy nvim $1
    fi
}

mk4vi() {
    if test $# -eq 0 -o "$1" == "-h" ;then
        echo "mk4vi [file_base_name]"
    else
        onefile template nvim $1
    fi
}

onefile() {
    if test $# -lt 3 -o "$1" == "-h" ;then
        echo "onefile [copy|template] [bash|nvim] [file_base_name]"
    else
        mode=""
        type=""
        target=""
        if test "$1" == "copy" ;then
            mode="$1"
            src="$3"
            target="$3"
        elif test "$1" == "template" ;then
            mode="$1"
            src="templates/$3"
            target="$3"
        fi
        if test "$2" == "bash" ;then
            type="$2"
        elif test "$2" == "nvim" ;then
            type="$2"
        fi
        if test "$mode" != "" -a "$type" != "" ;then
            base=$CHIKUWANSIBLE_PATH
            yml_file=$base/tmp_onefile.yml
            cp -a $base/onefile.yml $yml_file
            sed -E "s@COPY_OR_TEMPLATE@$mode@g" -i $yml_file
            sed -E "s@BASH_OR_NVIM@$type@g" -i $yml_file
            sed -E "s@FILE_NAME@$src@g" -i $yml_file
            ansible-playbook $yml_file
            rm -rf $yml_file $base/tmp_onefile.retry
        fi
    fi
}

cargonew() {
    if test $# -eq 0 -o "$1" == "-h" ;then
        echo "cargonew [project-name]"
    else
        cargo new $1
        cp -a $BASH_CONFIG_FILES/for_functions/template.rs $1/src/main.rs
        cp -a $BASH_CONFIG_FILES/for_functions/Cargo.toml $1/Cargo.toml
        cp -a $BASH_CONFIG_FILES/for_functions/rust_template.mk $1/Makefile
        sed -E "s@FILE_NAME@$1@g" -i $1/Makefile
    fi
}

d_func() {
    pushd $1 > /dev/null
}
complete -o nospace -F _cd d_func
complete -o nospace -F _cd d

a_func() {
    popd > /dev/null
}

da() {
    d ..
}

commits() {
    curl https://api.github.com/users/${GIT_NAME}/events | rg "\"created_at\":|\"name\":.*${GIT_NAME}/|\"message\":" | red ".*\"name\": \"miyagaw61/(.*)\"," '[+]$1:' | red ".*\"message\": (.*)" '-> $1' | red ".*\"created_at\": \"\d{4}-\d{2}-(\d{2}).*\"" '_SPACES_($1)_RETURN__RETURN_' | sed -E "/:$/N;s/.*:\n_SPACES_.*/_DELETED_/g" | sed -E "/_RETURN_$/N;s/_RETURN_\n_SPACES_.*/_DELETED_/g" | sed -E "/:$/N;N;s/.*:\n_SPACES_.*/_DELETED_/g" | sed -E "s/_SPACES_/                      /g" | sed -E "s/_RETURN_/\\n/g" | tr -d "_DELETED_" | less
}

w2l() {
    if test $# -eq 0 ;then
        echo "Usage: w2l WIN_PATH"
    else
        path="$(echo $1 | sed -E 's@C:@/mnt/c@g')"
        path="$(echo $path | sed -E 's@\\@/@g')"
        echo $path
    fi
}

l2w() {
    if test $# -eq 0 ;then
        echo "Usage: l2w LINUX_PATH"
    else
        path="$(echo $1 | sed -E 's@/mnt/c@C:@g')"
        path="$(echo $path | sed -E 's@/home/miyagaw61@C:/Users/miyagaw61/home@g')"
        path="$(echo $path | sed -E 's@~@C:/Users/miyagaw61/home@g')"
        path="$(echo $path | sed -E 's@$HOME@C:/Users/miyagaw61/home@g')"
        path="$(echo $path | sed -E 's@/@\\@g')"
        echo $path
    fi
}

lcp() {
    if test $# -eq 0 ;then
        echo "Usage: lcp WIN_PATH [LINUX_PATH]"
    else
        if test $# -eq 1 ;then
            cp -a "$(w2l $1)" ./
        else
            dst=${@:$#}
            if test -d $dst ;then
                for x in ${@:1:$#-1} ;do
                    cp -a "$(w2l $x)" $dst
                done
            else
                echo "lcp: target '$dst' is not a directory"
            fi
        fi
    fi
}

hhs() {
    cmd.exe /c title $1
    ssh $1
    cmd.exe /c title WSL
}

declare_python() {
    lst=$(cat $1 | rg "^def (.*)\(.*\):" -r '$1')
    for x in $lst ;do
        eval $x" () { python $1 "$x "\$@ ; }"
    done
    base=$(basename $1)
    #eval $base" () { echo Usage:; lst=\$(cat "$1" | rg \"^def (.*)\(.*\):\" -r '\$1'); for func in \$lst; do echo \$func ;done ; }"
    eval $base" () { python $1 help ;}"
}

declare_python $BASH_CONFIG_FILES/python/download.py

regren() {
    usage() {
        echo "Usage: regren OLD_FILE_REGEXP NEW_FILE_REGEXP"
        echo "Example:"
        echo """
  $ ls
  hoge.foo.bar fuga.foo.bar
  $ regren '(.*).foo.bar' '~/tmp/\$1.baz'
  $ ls
  $ ls ~/tmp/
  hoge.baz fuga.baz
"""
    }

    if [ "$1" = "-h" -o "$1" = "--help" -o $# -lt 2 ] ;then
        usage
    else
        ls | rg "$1" > regren.tmp
        ls | rg "$1" -r "$2" > regren2.tmp
        cp -a regren.tmp regrenmv.tmp
        sed -E "s/.*/mv/g" -i regrenmv.tmp
        paste -d " " regrenmv.tmp regren.tmp regren2.tmp > regren3.tmp
        source regren3.tmp
        rm -rf regren*.tmp
    fi
}

title() { echo -ne "\e]2;$@\a\e]1;$@\a"; }
