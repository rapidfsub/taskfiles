sudo -v

curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm
nix --extra-experimental-features "nix-command flakes" run nix-darwin -- switch --flake ~/taskfiles/nix-darwin/.#simple

task setup
