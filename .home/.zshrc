__PATH__=$PATH
eval "$(devbox global shellenv)"
export PATH="$__PATH__:$PATH"
eval "$(mise activate zsh)"
