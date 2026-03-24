{ config, pkgs, lib, ... }:

{
  imports = [
    ./helix.nix
    ./yix.nix
  ];
}
