{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.helix = {
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
  	extraConfig = ''
      [editor.indent-guides]
      render = true
      
      [keys.normal]
      C-z = "@u"
      C-y = "@U"
      C-s = ":write!"
      C-q = ":quit!"
      C-tab = "@ga"
      C-p = ":e ."

      [editor.lsp]
      display-inlay-hints = true
      
      [keys.insert]
      C-z = "@u"
      C-y = "@U"
      C-tab = "@ga"
      C-c = ":clipboard-yank"
      C-v = ":clipboard-paste-replace"
      C-backspace = "@bd"
      C-del = "@wd"
      C-p = ":e ."
      C-s = ":write!"
      C-q = ":quit!"
  	'';
  };

}
