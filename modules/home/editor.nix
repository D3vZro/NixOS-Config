{ config, pkgs, lib, ... }:

{
  programs = {
    nixvim = {
      enable = true;
      enableMan = false;

      globals.mapleader = " ";
      clipboard.register = "unnamedplus";

      autoCmd = [
        {
          event = [ "TextYankPost" ];
          callback = { __raw = "function() vim.highlight.on_yank() end"; };
        }
      ];

      keymaps = [
        {
          key = "<C-O>";
          action = "o<Esc>";
        }
        {
          key = "<C-e>";
          action = ":NvimTreeToggle<CR>";
        }
      ];

      extraConfigLua = ''
        local set = vim.opt

        set.conceallevel = 1
        set.expandtab = true
        set.ignorecase = true
        set.mouse = nil
        set.number = true
        set.relativenumber = true
        set.shiftwidth = 2
        set.smartcase = true

        set.title = true
        set.titlelen = 0
        set.titlestring = 'nvim'

        set.foldenable = false
      '';

      colorschemes.nord = {
        enable = true;

        settings = {
          borders = true;
          contrast = true;
        };
      };

      plugins = {
        auto-save.enable = true;
        cursorline.enable = true;
        gitgutter.enable = true;
        luasnip.enable = true;
        nix.enable = true;
        vim-surround.enable = true;
        web-devicons.enable = true;
        which-key.enable = true;

        indent-blankline = {
          enable = true;

          settings = {
            exclude = {
              buftypes = [
                "terminal"
                "quickfix"
              ];

              filetypes = [
                ""
                "checkhealth"
                "help"
                "lspinfo"
                "TelescopePrompt"
                "TelescopeResults"
              ];
            };

            scope = {
              show_start = true;
              show_exact_scope = true;
              show_end = true;
            };
          };
        };

        leap = {
          enable = true;
        };

        treesitter = {
          enable = true;
          settings.indent.enable = true;
          folding = true;
          nixvimInjections = true;
        };

        lsp = {
          enable = true;
          servers.nil-ls.enable = true;

          keymaps = {
            diagnostic = {
              "<leader>j" = "goto_next";
              "<leader>k" = "goto_prev";
            };

            lspBuf = {
              "K" = "hover";
              "gr" = "references";
              "gd" = "definition";
              "gi" = "implementation";
              "gD" = "type_definition";
            };
          };
        };

        cmp = {
          enable = true;

          settings = {
            performance = {
              max_view_entries = 50;
              throttle = 50;
            };

            snippet.expand = ''
              function(args)
                require('luasnip').lsp_expand(args.body)
              end
            '';

            mapping = {
              "<Tab>" = "cmp.mapping.confirm({ select = true })";
              "<C-Space>" = "cmp.mapping.complete()";
              "<C-k>" = "cmp.mapping.select_prev_item()";
              "<C-j>" = "cmp.mapping.select_next_item()";
            };

            sources = [
              { name = "buffer"; }
              { name = "nvim_lsp"; }
              { name = "path"; }
            ];
          };
        };

        telescope = {
          enable = true;
          extensions.fzf-native.enable = true;

          keymaps = {
            "<leader>ff" = "find_files";
            "<leader>fg" = "live_grep";
            "<leader>fb" = "buffers";
            "<leader>fh" = "help_tags";
          };
        };

        lualine = {
          enable = true;

          settings = {
            options = {
              globalstatus = true;
              ignore_focus = [ "NvimTree" ];
              disabled_filetypes.statusline = [ "NvimTree" ];
            };

            sections = {
              lualine_a = ["mode"];
              lualine_b = ["branch" "diff"];
              lualine_c = ["searchcount" "selectioncount"];
              lualine_x = ["filetype"];
              lualine_y = ["progress"];
              lualine_z = ["location" ];
            };

            tabline = {
              lualine_a = ["hostname"];
              lualine_b = ["windows"];
              lualine_c = [];
              lualine_x = [];
              lualine_y = [];
              lualine_z = ["tabs"];
            };
          };
        };

        nvim-tree = {
          enable = true;
          hijackCursor = true;
          openOnSetup = true;

          extraOptions = {
            view = {
              adaptive_size = true;
              side = "right";
              number = true;
              relativenumber = true;
              preserve_window_proportions = true;
            };
          };
        };

        presence-nvim = {
          enable = true;
          editingText = "Editing";
          readingText = "Reading papers";
          fileExplorerText = "Browsing files";
          gitCommitText = "Committing";
          neovimImageText = "Our lord and saviour";
          pluginManagerText = "Managing plugins";
          workspaceText = "Drinking coffee";

          extraOptions = {
            buttons = false;
          };
        };
      };
    };
  };
}
