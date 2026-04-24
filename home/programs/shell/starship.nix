{ config, pkgs, lib, ... }:

{
  programs.fish = {
    enable = true;
    # package = pkgs.stdenv.mkDerivation {
    # 	pname = "dummy";
    #   version = "0";
    #   src = null;
    #   dontUnpack = true;
    #   dontBuild = true;
    #   installPhase = ''
    #   mkdir -p $out
    #   '';
    # };
  };
    # , 󰌽, 
  programs.starship = {
    enable = true;
    # package = null;
    enableBashIntegration = true;
    enableFishIntegration = true;
    # enableZshIntegration = true;
    enableNushellIntegration = true;
    settings = {
      format = ''
    $username$localip$directory$git_branch$git_status$fill$rust$cmd_duration
    [◎](fg:magenta) 
  '';

  directory = {
    format = "[](fg:black)[ $path ]($style)[](fg:black) ";
    style = "bg:black fg:white";
    # truncation_length = 3;
    # truncation_symbol = "…/";
  };

  localip = {
    ssh_only = true;
    format = "[](fg:black)[ $localipv4 ]($style)[](fg:black)";
    style = "bg:black fg:white";
    disabled = false;
  };

  fill = {
    style = "fg:white";
    symbol = " ";
  };

  git_branch = {
    format = "[](fg:black)[ $symbol $branch ]($style)[](fg:black) ";
    style = "bg:black fg:orange";
    symbol = "";
  };

  git_status = {
    style = "bg:black fg:red";
    format = "[](fg:black)([$all_status$ahead_behind]($style))[](fg:black) ";

    up_to_date = "[ ✓ ](fg:magenta)";
    untracked = "[?($count)](fg:yellow)";
    modified = "[!($count)](fg:yellow)";
    staged = "[++($count)](fg:green)";
    deleted = "[✘($count)](fg:red)";
    renamed = "[»($count)](fg:magenta)";

    ahead = "[⇡($count)](fg:green)";
    behind = "[⇣($count)](fg:red)";
  };

  cmd_duration = { format = "[](fg:black)[ $duration ](bg:black fg:white)[](fg:black)"; };

  time = {
    format = " [](fg:black)[ $time 󰥔 ]($style)[](fg:black)";
    style = "bg:black fg:magenta";
    time_format = "%R";
    utc_time_offset = "local";
    disabled = false;
  };
 
  username = {
    format = "[](fg:black)[  $user ]($style)[](fg:black) ";
    show_always = false;
    disabled = false;
    style_user = "bg:black fg:magenta";
    style_root = "bg:black fg:red";
  };

  # Languages (fixed: no more pine)

  rust = {
    style = "bg:black fg:red";
    format = " [](fg:black)[ $symbol$version ]($style)[](fg:black)";
    disabled = false;
    symbol = " ";
  };

  nodejs.style = "bg:black fg:green";
  python.style = "bg:black fg:yellow";
  golang.style = "bg:black fg:cyan";
  c.style = "bg:black fg:blue";

 };
 };
}
