# set default useful options
# ====================================
alias diff="{{alias_diff}}"
alias objdump="{{alias_objdump}}"
alias less="{{alias_less}}"

# be short
# ====================================
alias pbcopy="{{alias_pbcopy}}"
alias pbpaste="{{alias_pbpaste}}"
alias xl="{{alias_xl}}"
alias pt="{{alias_pt}}"
alias all-update="{{alias_all_update}}"
alias op="{{alias_op}}"
alias sd="{{alias_sd}}"

# alias ls
# ====================================
alias ls="{{alias_ls}}"
alias ll="{{alias_ll}}"

# alias source bashrc
# ====================================
alias soba="{{alias_soba}}"

# my config
# ====================================
alias vim="{{alias_vim}}"
alias ns="{{alias_ns}}"
alias sl="{{alias_sl}}"

# alias rusgit
# ====================================
if test "$(which rusgit)" ;then
    {{rusgit_init}}
    alias rs="{{alias_rs}}"
fi

# alias global
# ====================================
alias gf="{{alias_gf}}"
alias gr="{{alias_gr}}"
alias g="{{alias_g}}"

# alias dret
# ====================================
alias dret="{{alias_dret}}"
