# Ozoku's Nix Config

My Nix Config

## Steps

1. `nixos-install --flake .#titan` or `sudo nixos-rebuild --flake .#titan`
2. `reboot`
3. `rustup default stable`
4. `opam init`
5. `opam install dune merlin ocaml-lsp-server odoc ocamlformat utop dune-release`
6. `sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo`
7. `flatpak install flathub com.google.Chrome`
8. `flatpak install flathub com.microsoft.Edge`
9. `flatpak install flathub org.prismlauncher.PrismLauncher`
10. `reboot`
