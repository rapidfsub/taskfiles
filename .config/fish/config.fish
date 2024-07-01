# fish_add_path /usr/local/bin
fish_add_path ~/.ghcup/bin

if test "$(arch)" = arm64
    /opt/homebrew/bin/brew shellenv | source
else
    /usr/local/bin/brew shellenv | source
end

source /opt/homebrew/opt/asdf/libexec/asdf.fish

direnv hook fish | source
starship init fish | source
zoxide init fish | source

if status is-interactive
    # phoenix
    alias im "iex --sname n --cookie c -S mix"
    alias mps "mix phx.server"
    alias mt "ASSERT_VALUE_ACCEPT_DIFFS=n mix test"

    # Commands to run in interactive sessions can go here
    alias cat bat
    alias dig doggo
    alias ls eza
    alias ll "ls -al"
    alias lg lazygit
    alias ps procs
    alias smd "export MIX_ENV=dev"
    alias smt "export MIX_ENV=test"
    alias tl tldr

    function cd
        z $argv
    end
end
