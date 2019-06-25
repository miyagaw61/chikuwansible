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
alias sd="{{alias_sd}}"
alias ac="{{alias_ac}}"
alias vim_plugins_update="{{alias_vim_plugins_update}}"
alias ej="{{alias_ej}}"
alias je="{{alias_je}}"
alias no_alphanumeric="{{alias_no_alphanumeric}}"
alias naln="no_alphanumeric"
alias ipa="{{alias_ipa}}"
alias f="{{alias_f}}"
alias gp="{{alias_gp}}"
alias dg="{{alias_dg}}"
alias dgp="{{alias_dgp}}"
alias op="{{alias_op}}"
alias d="{{alias_d}}"
alias mg="{{alias_mg}}"

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
alias glf="{{alias_glf}}"
alias glr="{{alias_glr}}"
alias gl="{{alias_gl}}"

# alias git
# ====================================
alias g="{{alias_g}}"

# alias dret
# ====================================
alias dret="{{alias_dret}}"

# alias rusgit
# ====================================
alias add="{{alias_add}}"
alias rem="{{alias_rem}}"
alias ch="{{alias_ch}}"
alias imp="{{alias_imp}}"
alias sup="{{alias_sup}}"
alias fix="{{alias_fix}}"
alias use="{{alias_use}}"
alias upd="{{alias_upd}}"
alias allow="{{alias_allow}}"
alias avoid="{{alias_avoid}}"
alias refactor="{{alias_refactor}}"

# alias cd
# ====================================
alias da="pushd .. > /dev/null"

# alias syntax-highlight
# ====================================
alias lcat="source-highlight-esc.sh"

# alias vim-cd
# ====================================
alias vd="{{alias_vd}}"
