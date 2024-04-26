__PATH__=$PATH
eval "$(devbox global shellenv)"
export PATH="$__PATH__:$PATH"
eval "$(direnv hook zsh)"
eval "$(mise activate zsh)"
eval "$(starship init zsh)"

alias asdf=mise
alias ls=eza
alias ll="ls -al"
alias lg=lazygit
