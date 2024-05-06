__PATH__=$PATH
eval "$(devbox global shellenv)"
export PATH="$__PATH__:$PATH"
eval "$(direnv hook zsh)"
eval "$(mise activate zsh)"
eval "$(starship init zsh)"

alias asdf=mise
alias cat=bat
alias ls=eza
alias ll="ls -al"
alias lg=lazygit
alias smd="export MIX_ENV=dev"
alias smt="export MIX_ENV=test"
