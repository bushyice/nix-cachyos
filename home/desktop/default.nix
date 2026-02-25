{ config, pkgs, lib, ... }:

{
  imports = [
    ./waybar.nix
    ./sway.nix
    ./niri.nix
  ];
}
