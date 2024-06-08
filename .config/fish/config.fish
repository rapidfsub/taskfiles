# fish_add_path /usr/local/bin
fish_add_path ~/.ghcup/bin

if test "$(arch)" = arm64
    /opt/homebrew/bin/brew shellenv | source
else
    /usr/local/bin/brew shellenv | source
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    alias asdf mise
    alias cat bat
    alias ls eza
    alias ll "ls -al"
    alias lg lazygit
    alias ps procs
    alias smd "export MIX_ENV=dev"
    alias smt "export MIX_ENV=test"
    alias tl tldr
end

direnv hook fish | source
mise activate fish | source
starship init fish | source
zoxide init fish | source
