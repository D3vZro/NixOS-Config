{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs = {
    nix-index-database.comma.enable = true;
    fzf.fuzzyCompletion = true;
    fzf.keybindings = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
      loadInNixShell = true;
    };

    bash.promptInit = ''
      eval "$(starship init bash)"
      eval "$(fzf --bash)"
    '';

    zsh = {
      enable = true;
      enableCompletion = true;
      enableLsColors = true;
      syntaxHighlighting.enable = true;
      histSize = 2500;

      autosuggestions = {
        enable = true;
        async = true;
        strategy = [
          "history"
          "completion"
        ];
      };

      promptInit = ''
        eval "$(starship init zsh)"

        source <(fzf --zsh)
        export FZF_COMPLETION_PATH_OPTS='--walker file,dir,follow'

        export FZF_CTRL_T_OPTS="
          --walker-skip .git,node_modules,target
          --walker file,dir,follow
          --preview 'bat -n --color=always {}'
          --bind 'ctrl-/:change-preview-window(down|hidden|)'"

        export FZF_ALT_C_OPTS="
          --walker-skip .git,node_modules,target
          --walker dir,follow
          --preview 'tree -C {}'"

        _fzf_compgen_path() {
          fd --follow . "$1"
        }

        _fzf_compgen_dir() {
          fd --type d --follow . "$1"
        }

        zstyle ':completion:*' matcher-list ''' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
      '';

      shellInit = ''
        export MANPAGER='nvim +Man!'

        if [ "$XDG_SESSION_DESKTOP" = "sway" ] ; then
            # https://github.com/swaywm/sway/issues/595
            export _JAVA_AWT_WM_NONREPARENTING=1
        fi
      '';

      setOptions = [
        "AUTO_CD"
      ];
    };
  };

  environment = {
    pathsToLink = [ "/share/zsh" ];

    variables = {
      EDITOR = "nvim";
      TERM = "alacritty";
      WALLPAPER = "${../../wallpapers}";
    };

    shellAliases = {
      sudo = "sudo ";

      os-lsgen = "nix-env --list-generations --profile /nix/var/nix/profiles/system";
      os-off = "systemctl poweroff";
      os-suspend = "systemctl suspend";
      os-up = "powerprofilesctl set performance";
      os-mid = "powerprofilesctl set balanced";
      os-down = "powerprofilesctl set power-saver";

      audio-switch = "pactl set-default-sink";

      vim = "nvim";

      ":q" = "exit";
    };
  };
}
