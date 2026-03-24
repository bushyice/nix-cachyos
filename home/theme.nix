{ config, pkgs, lib, ... }:

let
  bg_wallpaper = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/kevinj045/nixos/refs/heads/main/nixos/assets/wallpaper.png";
    sha256 = "1fya6dpplyjcbwhcn85bhp7irah2sd84ciani7f2c9gi3gnyz6g1";
  };
  in
{
  home.pointerCursor = {
    package = lib.mkForce pkgs.catppuccin-cursors.mochaMauve;
    name = lib.mkForce "catppuccin-mocha-mauve-cursors";
    size = 24;
  };

  catppuccin.flavor = "mocha";
  catppuccin.swaync.enable = true;
  catppuccin.nvim.enable = true;
  catppuccin.ghostty.enable = true;
  # catppuccin.zellij.enable = true;

  stylix = {
    enable = true;

    targets.gnome.enable = false;
    targets.vscode.enable = false;
    targets.hyprpaper.enable = false;
    targets.waybar.enable = false;
    targets.gtk.enable = false;
    targets.neovide.enable = false;
    targets.neovim.enable = false;
    targets.swaync.enable = false;
    polarity = "dark";
    image = bg_wallpaper;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      monospace = {
        package = pkgs.fira-code;
        name = "Fira Code NerdFont";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
  

  xdg.configFile.hyprpaper = {
    target = "hypr/hyprpaper.conf";
    text = ''
      preload = ${bg_wallpaper}
      wallpaper = eDP-1,${bg_wallpaper}
      wallpaper = HDMI-A-1,${bg_wallpaper}
      splash = false
    '';
  };

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        blur-my-shell.extensionUuid
        gsconnect.extensionUuid
      ];
    };
  };
}
