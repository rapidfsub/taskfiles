set PATH /usr/local/bin:$PATH
set -l __PATH__ $PATH
### https://github.com/jetify-com/devbox/issues/1744#issuecomment-2071809825
devbox global shellenv --init-hook --recompute | sed -e 's/; then/;/' | sed -e 's/^fi/end/' | sed -e 's/hash -r//' | source
# devbox global shellenv --init-hook | source
set PATH __PATH__:$PATH

if test "$(arch)" = arm64
    /opt/homebrew/bin/brew shellenv | source
else
    /usr/local/bin/brew shellenv | source
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    alias asdf=mise
    alias cat=bat
    alias cd=z
    alias ls=eza
    alias ll="ls -al"
    alias lg=lazygit
    alias ps=procs
    alias smd="export MIX_ENV=dev"
    alias smt="export MIX_ENV=test"
    alias tl=tldr
end

direnv hook fish | source
mise activate fish | source
starship init fish | source
zoxide init fish | source
