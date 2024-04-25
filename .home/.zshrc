__PATH__=$PATH
eval "$(devbox global shellenv)"
export PATH="$__PATH__:$PATH"
eval "$(direnv hook zsh)"
eval "$(mise activate zsh)"
