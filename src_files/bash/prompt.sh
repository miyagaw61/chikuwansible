force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

usericon='?'
if test $USER = 'root';then
	usericon='#'
else
	usericon='$'
fi

if [ "$color_prompt" = yes ]; then
    function parse_branch(){
        branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's@\* \(.*\)@\1@')
        if test $(($(echo $branch | wc -m)-1)) -gt 1 ;then
            if test $USER = "root" ;then
                echo -ne "\033[01;30m:\033[36;1m${branch}\033[00m"
            else
                echo -ne "\033[01;30m:\033[32;1m${branch}\033[00m"
            fi
        fi
    }

    #function parse_pyenv(){
    #    pyenv=$(pyenv local 2> /dev/null)
    #    if test $(($(echo $pyenv | wc -m)-1)) -gt 3 ;then
    #        if test $USER = "root" ;then
    #            echo -ne "\033[1;31m─\033[1;36m[${pyenv}]"
    #        else
    #            echo -ne "\033[1;36m─\033[1;31m[${pyenv}]"
    #        fi
    #    else
    #        if test $USER = "root" ;then
    #            echo -ne "\033[1;31m─\033[1;36m[None]"
    #        else
    #            echo -ne "\033[1;36m─\033[1;31m[None]"
    #        fi
    #    fi
    #}

    function parse_branch(){
        branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's@\* \(.*\)@\1@')
        if test $(($(echo $branch | wc -m)-1)) -gt 1 ;then
            if test $USER = "root" ;then
                echo -ne "${white}(${yellow}${branch}${white})"
            else
                echo -ne "${white}(${yellow}${branch}${white})"
            fi
        fi
    }

    function parse_path(){
        now=$(pwd)
        base=$(basename $now)
        if test $(echo "$now" | grep "$REPOS/") ;then
            now=$(echo "$now" | sed -E "s@$REPOS/@@g")
            if test ! "$(echo "$now" | grep "/")" ;then
                now=${yellow}github.com${white}/${cyan}$now
            else
                now=$(echo "$now" | sed -E "s@^[^/]*@@g")
                now=$(echo "$now" | sed -E "s@^/@@g")
                repo=$(echo "$now" | sed -E "s@/.*@@g")
                unrepo=$(echo "$now" | sed -E "s@^$repo@@g")
                unrepo=$(echo "$unrepo" | sed -E "s/\/$//g")
                unrepo=$(echo $unrepo | sed -E "s@$base@@g")
                if test "$unrepo" ;then
                    now=${cyan}$repo${white}$unrepo${cyan}$base
                else
                    now=${cyan}$base
                fi
            fi
        elif test $(echo "$now" | grep "$HOME") ;then
            now=$(echo "$now" | sed -E "s@$HOME@~@g")
            now=$(echo "$now" | sed -E "s/\/$//g")
        fi
        echo -ne "$now"
    }

    PS1="\n${cyan}\$(parse_path) \$(parse_branch)\n\[${red}\]>> \[${white}\]"

    if test $USER = "root" ;then
        PS1="\n${cyan}\$(parse_path) \$(parse_branch)\n\[${yellow}\]>>> \[${white}\]"
    fi
fi

unset color_prompt force_color_prompt
