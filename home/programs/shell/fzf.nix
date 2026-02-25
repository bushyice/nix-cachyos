{ config, pkgs, lib, ... }:

{
  programs.fzf = {
    enable = true;
    package = pkgs.stdenv.mkDerivation {
    	pname = "dummy";
      version = "0";
      src = null;
      dontUnpack = true;
      dontBuild = true;
      installPhase = ''
      mkdir -p $out
      '';
    };
    enableBashIntegration = true;
    # enableZshIntegration = true;
    
  };
}
