let g:python3_host_prog = "{{host_python3_binary}}"
let g:python_host_prog = "{{host_python2_binary}}"

if has('nvim')
    let $VISUAL = 'nvr -cc split --remote-wait'
endif
