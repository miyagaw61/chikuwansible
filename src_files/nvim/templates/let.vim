let g:python3_host_prog = "{{python3_binary}}"
"let g:python3_host_prog = "/usr/bin/python3"
"let g:python_host_prog = "{{python2_binary}}"
let g:python_host_prog = "/usr/bin/python2"

if has('nvim')
    let $VISUAL = 'nvr -cc split --remote-wait'
endif
