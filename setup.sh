sudo -v

curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm
curl -fsSL https://get.jetify.com/devbox | FORCE=1 bash

devbox run task setup
