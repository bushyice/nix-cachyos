{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "makano";
  home.homeDirectory = "/home/makano";

  imports = [
    ./home/programs
    ./home/desktop
    ./home/theme.nix
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    (writeShellScriptBin "almighty-push" ''
      git add .
      git commit -m "$2"
      git push -u origin $1 $3
    '')
    (writeShellScriptBin "batp" ''
      POWER_PATH="/sys/class/power_supply"

      for device in "$POWER_PATH"/*; do
        name=$(basename "$device")
        
        # Check if capacity and status files exist
        if [ -f "$device/capacity" ] && [ -f "$device/status" ]; then
          capacity=$(cat "$device/capacity")
          status=$(cat "$device/status")
          echo "$name: $capacity% ($status)"
        fi
      done
    '')
    (writeShellScriptBin "dl" ''
      url=$1
      ddirname=""

      if [[ $url == *.iso ]];
      then
        ddirname="Archives/iso"
      elif [[ $url == *.tar.* ]]; then
        ddirname="Archives/tar"
      elif [[ $url == *.rar ]]; then
        ddirname="Archives/rar"
      elif [[ $url == *.zip ]]; then
        ddirname="Archives/zip"
      else
        ddirname="Misc"
      fi

      maindir=~/Downloads

      if [[ $2 ]];
      then
        maindir=$2
      fi

      echo Downloading $url at $ddirname

      ${curl}/bin/curl -L -O --output-dir $maindir/$ddirname --retry 999 --retry-max-time 0 -C - $url

    '')
    (writeShellScriptBin "srch" ''
      exclude_folders=""
      verbose=false

      while getopts ":i:v" opt; do
          case $opt in
              i)
                  exclude_folders="$OPTARG"
                  ;;
              v)
                  verbose=true
                  ;;
              \?)
                  echo "Invalid option: -$OPTARG"
                  exit 1
                  ;;
          esac
      done
      shift $((OPTIND - 1))

      if [ $# -ne 3 ]; then
          echo "Usage: $0 [-i <exclude_folders>] [-v] <name|content> <search_string> <folder_path>"
          exit 1
      fi

      mode="$1"
      search_string="$2"
      folder_path="$3"

      if [ "$mode" = "name" ]; then
          if [ "$verbose" = true ]; then
            echo "Verbose is on"
              find "$folder_path" -type f \( ! -path "*/$exclude_folders/*" \) -name "$search_string"
          else
              find "$folder_path" -type f \( ! -path "*/$exclude_folders/*" \) -name "$search_string" -print0 | xargs -0 echo
          fi
      elif [ "$mode" = "content" ]; then
          if [ "$verbose" = true ]; then
            echo "Verbose is on"
              grep -rl "$search_string" "$folder_path" $(printf -- '--exclude-dir=%s ' $(echo "$exclude_folders" | tr ',' ' '))
          else
              grep -rl "$search_string" "$folder_path" $(printf -- '--exclude-dir=%s ' $(echo "$exclude_folders" | tr ',' ' ')) | xargs -I {} echo "Results: {}"
          fi
      else
          echo "Invalid mode. Use 'name' or 'content'."
      fi

    '')
    (writeShellScriptBin "repeat-0" ''
      if [ $# -eq 0 ]; then
        echo "Usage: $0 <command>"
        exit 1
      fi

      # Command to run
      COMMAND="$@"

      # Infinite loop
      while :
      do
        # Run the command
        $COMMAND
        
        # Check the exit status
        if [ $? -eq 0 ]; then
          # If the exit status is 0 (success), break out of the loop
          echo "Command succeeded. Exiting loop."
          break
        else
          # If the exit status is non-zero (failure), print a message and continue the loop
          echo "Command failed. Retrying..."
        fi

        # Add a delay before retrying (adjust as needed)
        sleep 1
      done

    '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/makano/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
