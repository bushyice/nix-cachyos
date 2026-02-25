{ config, pkgs, lib, ... }:

{
  imports = [
    ./nushell.nix
    # ./fzf.nix
    ./tmux.nix
    ./starship.nix
  ];
}
