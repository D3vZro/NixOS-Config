{ config, pkgs, lib, ... }:

{
  programs = {
    thefuck.enable = true;
    direnv.enable = true;

    bash.promptInit = ''
      eval "$(starship init bash)"
    '';

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      histSize = 2500;

      promptInit = ''
        eval "$(starship init zsh)"
      '';

      shellInit = ''
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

      g-cl = "git clone";
      g-d = "git diff";
      g-p = "git pull";
      g-ca = "git commit -a";

      fl-update= "git pull && nix flake update";
      n-d = "nix develop";

      os-config = "cd ~/.nix/";
      os-update = "nixos-rebuild switch --flake .#$HOST --log-format internal-json -v |& nom --json";
      os-test = "nixos-rebuild dry-activate --flake .#$HOST --verbose";
      os-gc = "nix-collect-garbage";
      os-lsgen = "nix-env --list-generations --profile /nix/var/nix/profiles/system";
      os-gcroots = "nix-store --gc --print-roots";
      os-off = "systemctl poweroff";
      os-suspend = "systemctl suspend";
      os-gamemode = "cpupower frequency-set -g performance";

      vim = "nvim";

      ":q" = "exit";
    };
  };
}
