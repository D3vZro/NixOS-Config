{ config, pkgs, lib, ... }:

{
  programs = {
    nix-index-database.comma.enable = true;

    eza = {
      enable = true;
      git = true;
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;

      settings = {
        add_newline = false;
        command_timeout = 1000;

        right_format = "$time";

        character = {
          success_symbol = "[](bold green)";
          error_symbol = "[](bold red)";
          vicmd_symbol = "[](bold yellow)";
        };

        username = {
          show_always = true;
          format = ''\[[$user]($style)'';
        };

        hostname = {
          ssh_only = false;
          format = ''@[$ssh_symbol$hostname]($style)\]'';
        };

        directory = {
          truncation_length = 6;
          format = ''\[[$path]($style)[$read_only]($read_only_style)\]'';
          read_only = " ";
        };

        git_branch = {
          symbol = " ";
          format = ''\[[$symbol$branch]($style)\]'';
        };

        git_status = {
          format = ''([\[$all_status$ahead_behind\]]($style))'';
        };

        nix_shell = {
          symbol = "󱄅 ";
          format = ''\[[$symbol$state(\($name\))]($style)\]'';
        };

        cmd_duration = {
          format = ''\[[󰅐 $duration]($style)\]'';
        };

        time = {
          disabled = false;
          format = ''\[[$time]($style)\]'';
         };
      };
    };
  };
}
