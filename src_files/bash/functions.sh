emp() {
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
    if [ "$1" = "-h" ] ;then
        echo "Usage: repobase PATH"
    else
        base="$(echo $1 | sed -E "s@~@/home/miyagaw61@g")"
        base="$(echo $base | sed -E "s@/mnt/c/Users/miyagaw61/home@/home/miyagaw61@g")"
        base="$(echo $base | sed -E "s@/home/miyagaw61/src/github.com/([^/]*)/([^/]*).*@\1/\2@g")"
        echo /home/miyagaw61/src/github.com/${base}
    fi
}

cdrepobase() {
    if [ "$1" = "-h" ] ;then
        echo "Usage: cdrepobase PATH"
    else
        base="$(repobase $1)"
        cd $base
    fi
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

#h_func() {
#    cd $HOME/$1
#}
#h_completion() {
#    local cur prev cword opts
#    _get_comp_words_by_ref -n : cur prev cword
#    COMPREPLY=( $(compgen -W "$(ls -F $HOME/ | rg '(.*)/$' -r '$1')" -- "${cur}") )
#}
#complete -F h_completion h_func
#complete -F h_completion h
#
#r_func() {
#    cd $MY_REPOS/$1
#}
#r_completion() {
#    local cur prev cword opts
#    _get_comp_words_by_ref -n : cur prev cword
#    COMPREPLY=( $(compgen -W "$(ls -F $MY_REPOS | rg '(.*)/$' -r '$1')" -- "${cur}") )
#}
#complete -F r_completion r_func
#complete -F r_completion r
#
#e_func() {
#    cd $HOME/events/$1
#}
#e_completion() {
#    local cur prev cword opts
#    _get_comp_words_by_ref -n : cur prev cword
#    COMPREPLY=( $(compgen -W "$(ls -F $HOME/events/ | rg '(.*)/$' -r '$1')" -- "${cur}") )
#}
#complete -F e_completion e_func
#complete -F e_completion e
#
#d_func() {
#    cd $HOME/docs/$1
#}
#d_completion() {
#    local cur prev cword opts
#    _get_comp_words_by_ref -n : cur prev cword
#    COMPREPLY=( $(compgen -W "$(ls -F $HOME/docs/ | rg '(.*)/$' -r '$1')" -- "${cur}") )
#}
#complete -F d_completion d_func
#complete -F d_completion d

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
        sed -E "s@FILE_NAME@$1@g" -i $1/Cargo.toml
        sed -E "s@FILE_NAME@$1@g" -i $1/src/main.rs
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

da_func() {
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

title() { echo -ne "\e]2;$@\a\e]1;$@\a"; }

rep() {
    if [ "$1" = "-h" ] ;then
        echo "Usage: rep REGEXP [OPTIONS]"
    else
        regexp=$1
        tmp_file=".rep.tmp"
        if [ $# -gt 1 ] ;then
            rg "$regexp" "${@:2}" -n --line-number-width=7 | sed -E "s@^\-\-\$@___________________________________________________________________________________________________________________________________\n===================================================================================================================================\n@g" > $tmp_file
            cat $tmp_file | sed -E "s@(^ *)([0123456789]+)(.*)@\1\x1b[0;32m\2\x1b[0m\3@g" | sed -E "s@($regexp)@\x1b[1;37;46m\1\x1b[0m@g"
        else
            rg "$regexp" -n --line-number-width=7 | sed -E "s@(^ *)([0123456789]+)(.*)@\1\x1b[0;32m\2\x1b[0m\3@g" | sed -E "s@($regexp)@\x1b[1;37;46m\1\x1b[0m@g"
        fi
        rm -rf $tmp_file
    fi
}

frep() {
    if [ "$1" = "-h" ] ;then
        echo "Usage: frep PATH REGEXP [OPTIONS]"
    else
        regexp=$2
        path=$1
        before_path="$(echo $path | sed -E "s@(.*/)([^/]*)@\1@g")"
        after_path="$(echo $path | sed -E "s@(.*/)([^/]*)@\2@g")"
        tmp_file=${before_path}/frep_${after_path}
        source-highlight-esc.sh $path > $tmp_file 2> /dev/null
        if [ $# -gt 2 ] ;then
            if [ -s $tmp_file ] ;then
                source-highlight-esc.sh $path | rep "$regexp" "${@:3}"
            else
                cat $path | rep "$regexp" "${@:3}"
            fi
        else
            if [ -s $tmp_file ] ;then
                source-highlight-esc.sh $path | rep "$regexp"
            else
                cat $path | rep "$regexp"
            fi
        fi
        rm -rf $tmp_file
    fi
}

repl() {
    if [ "$1" = "-h" ] ;then
        echo "Usage: repl REGEXP [OPTIONS]"
    else
        rep "$@" --color=ansi | less -iMSR
    fi
}

frepl() {
    if [ "$1" = "-h" ] ;then
        echo "Usage: frepl PATH REGEXP [OPTIONS]"
    else
        frep "$@" --color=ansi | less -iMSR
    fi
}

mysync() {
    if [ "$1" = "-h" ] ;then
        echo "mysync - rsync from host to remote & rsync from remote to host"
        echo "Usage: mysync SSH_INFO DIRECTORY_PATH"
    else
        if [ $# -eq 2 ] ;then
            ssh_info="$1"
            directory_path="$2"
            rsync -auv ${directory_path}/* ${ssh_info}:${directory_path}
            rsync -auv ${ssh_info}:${directory_path}/* ${directory_path}
        fi
    fi
}

rps() {
    find $REPOS -maxdepth 2 -type d | sed -E "s@$REPOS/@@g" | grep -v "$REPOS" | grep -v '^[^/]*$' | grep -v '^\.$' | sed -E 's@^\./@@g' | sed -E 's@^([^/]*)/(.*)@\1/\x1b[32;1m\2\x1b[m@g'
}

rpd() {
    cd $REPOS/$1
}

rust() {
    # $ rust hoge.rs
    # $ rust +nightly hoge.rs
    # $ rust -e '1 + 1'
    # $ cat /etc/passwd | rust -l '|line| print!("{}", line)'
    local toolchain=+stable

    if [[ "$1" =~ "\+.+" ]]; then
        toolchain="$1"
        shift
    fi
    cargo "$toolchain" script "$@"
}

v() {
    jobs -l > /tmp/jobs
    job_spec="$(rg NVIM_LISTEN_ADDRESS /tmp/jobs | head -1 | awk '{print $1}' | sed -E 's@.*\[(.*)\].*@\1@g')"
    if [ $# -eq 0 ] ;then
        if [ "$(echo $VIM)" ] ;then
            #socket="$(echo /tmp/nvim*/0)"
            #NVIM_LISTEN_ADDRESS=$socket nvr -c "Denite buffer"
            NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvr -c "Denite buffer"
        else
            if [ $job_spec ] ;then
                fg $job_spec
            else
                rm -rf /tmp/nvimsocket
                NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvim
            fi
        fi
    elif [ $# -eq 1 ] ;then
        if [ "$(echo $VIM)" ] ;then
            #socket="$(echo /tmp/nvim*/0)"
            #NVIM_LISTEN_ADDRESS=$socket nvr -c "e "$(realpath $1)
            NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvr -c "e "$(realpath $1)
        else
            old_dir="$PWD"
            if [ "$1" = "/" ] ;then
                base_dir="/"
                cd "$base_dir"
                echo -n "$base_dir" > /tmp/viming_path
                lf -a -tf | fzf2nd >> /tmp/viming_path
                cd -
            elif [ "$1" = "." ] ;then
                base_dir="$HOME"
                cd "$base_dir"
                echo -n "$base_dir/" > /tmp/viming_path
                lf -a -tf | fzf2nd >> /tmp/viming_path
                cd -
            elif [ "$1" = "d" ] ;then
                base_dir="$HOME/docs"
                cd "$base_dir"
                echo -n "$base_dir/" > /tmp/viming_path
                lf -a -tf | fzf2nd >> /tmp/viming_path
                cd -
            elif [ "$1" = "v" ] ;then
                base_dir="$HOME/docs/config_files/nvim/"
                cd "$base_dir"
                echo -n "$base_dir/" > /tmp/viming_path
                lf -a -tf | fzf2nd >> /tmp/viming_path
                cd -
            elif [ "$1" = "b" ] ;then
                base_dir="$HOME/docs/config_files/bash"
                cd "$base_dir"
                echo -n "$base_dir/" > /tmp/viming_path
                lf -a -tf | fzf2nd >> /tmp/viming_path
                cd -
            elif [ "$1" = "s" ] ;then
                base_dir="$HOME/src"
                cd "$base_dir"
                echo -n "$base_dir/" > /tmp/viming_path
                lf -a -tf | fzf2nd >> /tmp/viming_path
                cd -
            elif [ "$1" = "g" ] ;then
                base_dir="$HOME/src/github.com"
                cd "$base_dir"
                echo -n "$base_dir/" > /tmp/viming_path
                lf -a -tf | fzf2nd >> /tmp/viming_path
                cd -
            elif [ "$1" = "m" ] ;then
                base_dir="$HOME/src/github.com/miyagaw61"
                cd "$base_dir"
                echo -n "$base_dir/" > /tmp/viming_path
                lf -a -tf | fzf2nd >> /tmp/viming_path
                cd -
            elif [ "$1" = "t" ] ;then
                base_dir="$HOME/tmp"
                cd "$base_dir"
                echo -n "$base_dir/" > /tmp/viming_path
                lf -a -tf | fzf2nd >> /tmp/viming_path
                cd -
            else
                echo "$(realpath "$1")" > /tmp/viming_path
            fi
            if [ -d "$(cat /tmp/viming_path)" ] ;then
                echo "" > /tmp/viming_path
            else
                if [ $job_spec ] ;then
                    fg $job_spec
                else
                    rm -rf /tmp/nvimsocket
                    NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvim "$(cat /tmp/viming_path)"
                fi
            fi
        fi
    else
        rm -rf /tmp/viming_path
        for x in $@ ;do
            echo "$(realpath "$x")" >> /tmp/viming_path
        done
        if [ "$(echo $VIM)" ] ;then
            #socket="$(echo /tmp/nvim*/0)"
            #NVIM_LISTEN_ADDRESS=$socket nvr -c "Denite buffer"
            NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvr -c "Denite buffer"
        else
            if [ $job_spec ] ;then
                fg $job_spec
            else
                rm -rf /tmp/nvimsocket
                NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvim
            fi
        fi
    fi
}

middle() {
    head -n $2 | tail -n $(($2 - $1 + 1))
}

mktmp() {
    if [ -e "./tmp.py" ] ;then
        echo tmp.py: already exists
    else
        cp -a $HOME/bin/tmp.py .
    fi
}

greparse() {
    if [ "$1" = "-p" ] ;then
        cat /tmp/greparse_result | less -iSMR -#5
    else
        if [ -p /dev/stdin ]; then
            __str=`cat -`
        else
            __str=$@
        fi
        #echo "$__str" | sed -E "s@(^[^:]+):([^:]+):(.*)@\3 GREPARSE_FILE_IS:[ \1 : \2 ]@g" | sed -E "s@^\s+@@g" | rg -v "^if\s*\(" | rg -v "^for\s*\(" | rg -v "^while\s*\(" > /tmp/greparse_org # First Version
        #echo "$__str" | sed -E "s@(^[^:]+):([^:]+):(.*)@\3 GREPARSE_FILE_IS:[ \1 : \2 ]@g" | sed -E "s@^\s+@@g" > /tmp/greparse_org # Use sed -E "s@^\s+@@g"
        #echo "$__str" | sed -E "s@^\s*([^:]+):([^:]+):(.*)@\3 GREPARSE_FILE_IS:[ \1 : \2 ]@g" > /tmp/greparse_org # Use s@^\s*
        echo "$__str" | sed -E "s@(^[^:]+):([^:]+):(.*)@\3 GREPARSE_FILE_IS:[ \1 : \2 ]@g" > /tmp/greparse_org # Use no sed -E "s@^\s+@@g" or s@^\s*
        cat /tmp/greparse_org | sed -E "s@^.*GREPARSE_FILE_IS:@@g" > /tmp/greparse_file_names_org
        cat /tmp/greparse_org | sed -E "s@ GREPARSE_FILE_IS:.*@@g" > /tmp/greparse_code_lines_org
        cp -a /tmp/greparse_file_names_org /tmp/greparse_file_names_org.bak
        rm -rf /tmp/greparse_file_names
        rm -rf /tmp/greparse_code_lines
        cat /tmp/greparse_file_names_org | while read line ;do
            n="$(echo $line | wc -m)"
            n=$(($n - 1))
            if [ $n -le 50 ] ;then
                printf "\033[1;34m%50s\033[0m\n" "$line" >> /tmp/greparse_file_names
            else
                printf "\033[1;34m%80s\033[0m\n" "$line" >> /tmp/greparse_file_names
            fi
        done
        sed -E 's@\\@\\\\@g' -i /tmp/greparse_code_lines_org
        cat /tmp/greparse_code_lines_org | while read line ;do
            printf "\033[33;01;41m%s\033[0m\n" "$line" >> /tmp/greparse_code_lines
        done
        paste /tmp/greparse_file_names /tmp/greparse_code_lines > /tmp/greparse_result
        if [ $# -eq 1 ] ;then
            cat /tmp/greparse_result | rg --color=always "$1" | less -iSMR -#5
        else
            cat /tmp/greparse_result | less -iSMR -#5
        fi
    fi
}

defgrep() {
    if [ -p /dev/stdin ]; then
        __str=`cat -`
    else
        __str=$@
    fi
    if [ $# -eq 1 ] ;then
        echo "$__str" | rg -v "\d:\s*if\s*\(" | rg -v "\d:\s*for\s*\(" | rg -v "\d:\s*while\s*\(" | rg -v ";$" | rg -v "\d:\s*$1" | rg "\s+$1"
    else
        echo "$__str" | rg -v "\d:\s*if\s*\(" | rg -v "\d:\s*for\s*\(" | rg -v "\d:\s*while\s*\(" | rg -v ";$"
    fi
}

defgreparse() {
        if [ "$1" = "-p" ] ;then
            cat /tmp/greparse_result | less -iSMR -#5
        else
            if [ -p /dev/stdin ]; then
                __str=`cat -`
            else
                __str=$@
            fi
            if [ $# -eq 1 ] ;then
                echo "$__str" | defgrep "$1" | rg --color=always "$1" | greparse
            else
                echo "$__str" | defgrep | greparse
            fi
        fi
}

mgp() {
    if [ $# -eq 1 ] ;then
        rg -n $1 | gp
    fi
}

mdgp() {
    if [ $# -eq 1 ] ;then
        rg -n $1 | dgp $1
    fi
}

x() {
    touch /tmp/gdb.loop
    touch /tmp/gdb.pause
    nohup ./x &
    sleep 2
    gdb -p $(cat /tmp/gdb.pid)
    rm -rf /tmp/gdb.loop
}

at() {
    gdb -p $(cat /tmp/gdb.pid)
}

fzfd() {
    if [ $# -eq 1 ] ;then
        old_dir=$PWD
        if [ "$1" = "h" ] ;then
            base_dir="$HOME"
        elif [ "$1" = "." ] ;then
            base_dir="$HOME"
        elif [ "$1" = "/" ] ;then
            base_dir="/"
        elif [ "$1" = "s" ] ;then
            base_dir="$HOME/src"
        elif [ "$1" = "g" ] ;then
            base_dir="$HOME/src/github.com"
        elif [ "$1" = "m" ] ;then
            base_dir="$HOME/src/github.com/miyagaw61"
        elif [ "$1" = "l" ] ;then
            base_dir="$HOME/src/github.com/torvalds"
        elif [ "$1" = "d" ] ;then
            base_dir="$HOME/docs"
        elif [ "$1" = "v" ] ;then
            base_dir="$HOME/docs/config_files/nvim"
        elif [ "$1" = "b" ] ;then
            base_dir="$HOME/docs/config_files/bash"
        elif [ "$1" = "t" ] ;then
            base_dir="$HOME/tmp"
        else
            base_dir="$1"
        fi
        cd "$base_dir"
		if [ "$1" = "l" ] ;then
			dir="$(ls -1 | fzf2nd)"
		else
			dir="$(lf -a -td | fzf2nd)"
		fi
        cd "$old_dir"
        if [ "$dir" ] ;then
            cd "$base_dir/$dir"
        else
            cd "$base_dir"
        fi
    else
        dir="$(lf -a -td | fzf2nd)"
        if [ "$dir" ] ;then
            cd "$dir"
        fi
    fi
}

lind() {
	v=$1
	if [[ -z $v ]] ;then
		echo "Usage: lind <linux_version>"
	else
		cd $REPOS/torvalds/v${v}
	fi
}

repod() {
    dir="$(ghq list | rg -v gist.github.com | fzf2nd)"
    if [ "$dir" ] ;then
        cd "$HOME/src/$dir"
    fi
}

gistd() {
    file="$(ghq list | rg gist.github.com | while read line; do echo $HOME/src/$line/* ;done | fzf2nd)"
    if [ "$file" ] ;then
        dir="$(echo "$file" | sed -E 's@/[^/]*$@@g')"
        cd "$dir"
    fi
}

mygists() {
    cd $HOME/src/gist.github.com/miyagaw61
}

knowledges() {
    ghq list | rg gist.github.com | while read line ;do
        echo /home/miyagaw61/src/$line/knowledge* | sed -E 's@ @\\ @g'
    done
}

parse_python() {
    rg -o -e "^ *[^#]*class.*" -e "^ *[^#]*def.*" $1
}

xready() {
    cp -a $MY_REPOS/ctf/exploit.py ./
    if [ "$1" ] ;then
        sed -E "s@target=\"./target\"@target=\"./$1\"@g" -i exploit.py
    fi
}
