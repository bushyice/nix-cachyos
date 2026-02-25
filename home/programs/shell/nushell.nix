{ config, pkgs, lib, ... }:

{
  # programs.fish = {
  #   enable = true;
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
  # };
  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
    # enableZshIntegration = true;
  };
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };
  programs.nushell = {
    enable = true;
    extraConfig = ''
      let carapace_completer = {|spans|
        carapace $spans.0 nushell ...$spans | from json
      }
      
      $env.config = {
       show_banner: false,
       completions: {
         case_sensitive: false
         quick: true
         partial: true
         algorithm: "fuzzy"
         external: {
	       enable: true 
	       max_results: 100 
	       completer: $carapace_completer # check 'carapace_completer' 
	     }
       },
       keybindings: [
         {
           name: backward_kill_word
           modifier: control
           keycode: char_h
           mode: [emacs, vi_insert]
           event: [
             { edit: BackspaceWord }
           ]
         }
       ]
      }

      alias hx = helix;
      
      $env.PATH = ($env.PATH | 
        split row (char esep) |
        prepend /home/makano/exploit/bin |
        prepend /home/makano/.nix-profile/bin |
        prepend /home/makano/.local/bin
      )

      # $env.config.hooks.env_change.PWD = ($env.config.hooks.env_change.PWD? | default [])
      # $env.config.hooks.env_change.PWD ++= [{||
      #   if (which direnv | is-empty) {
      #     return
      #   }
      #   direnv export json | from json | default {} | load-env
      #   # If direnv changes the PATH, convert it to a list
      #   if ($env.PATH | describe | str contains "string") {
      #     $env.PATH = ($env.PATH | split row (char esep))
      #   }
      # }] 
    '';
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
  }; 
}

