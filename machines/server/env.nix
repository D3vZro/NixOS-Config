{
  nixpkgs.config.allowUnfree = true;
  programs.direnv.enable = true;
  environment.pathsToLink = [ "/share/zsh" ];
  programs.nh.enable = true;

  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    histSize = 2500;

    setOptions = [
      "AUTO_CD"
    ];
  };

  environment.shellAliases = {
    sudo = "sudo ";

    g-cl = "git clone";
    g-d = "git diff";
    g-p = "git pull";
    g-ca = "git commit -a";

    fl-update = "git pull && nix flake update";
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
}
