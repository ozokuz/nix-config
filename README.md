# Ozoku's Nix Config

My Nix Config

## Steps

1. `nixos-install --flake .#saturn` or `sudo nixos-rebuild --flake .#saturn`
2. `reboot`
3. `rustup default stable`
4. `opam init`
5. `opam install dune merlin ocaml-lsp-server odoc ocamlformat utop dune-release`
6. `sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo`
7. `sudo flatpak install com.discordapp.Discord`
8. `reboot`
