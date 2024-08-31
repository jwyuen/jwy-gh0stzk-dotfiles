{ config, pkgs, ... }:

let
  plugins = pkgs.vimPlugins;
  theme = config.colorScheme.palette;
in {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    globals.mapleader = ","; # Sets the leader key to space
    
    opts = {
      clipboard="unnamedplus";
      number = true;         # Show line numbers
      relativenumber = true; # Show relative line numbers
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;        # Tab width should be 2
      expandtab = true;
      wrap = true;
      swapfile = false;
      backup = false;
      hlsearch = false;
      incsearch = true;
      termguicolors = true;
      scrolloff = 8;
      updatetime = 50;
    };

    colorschemes.base16.enable = true;
    colorschemes.base16.colorscheme = {
      base00 = "#${theme.base00}";
      base01 = "#${theme.base01}";
      base02 = "#${theme.base02}";
      base03 = "#${theme.base03}";
      base04 = "#${theme.base04}";
      base05 = "#${theme.base05}";
      base06 = "#${theme.base06}";
      base07 = "#${theme.base07}";
      base08 = "#${theme.base08}";
      base09 = "#${theme.base09}";
      base0A = "#${theme.base0A}";
      base0B = "#${theme.base0B}";
      base0C = "#${theme.base0C}";
      base0D = "#${theme.base0D}";
      base0E = "#${theme.base0E}";
      base0F = "#${theme.base0F}";
    };
    
    plugins = {
      auto-session = {
        enable = true;
#        autoRestore.enabled = true;
#        autoSave.enabled = true;
        autoSession = {
          enabled = true;
        };
      };
      barbecue.enable = true;
      bufferline.enable = true;
      comment.enable = true;
      cmp = {
	enable = true;
	autoEnableSources = true;
      };
      cmp-buffer.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-path.enable = true;
      conform-nvim.enable = true;
      dashboard.enable = true;
      flash.enable = true;
      friendly-snippets.enable = true;
      gitsigns.enable = true;
      indent-blankline.enable = true;
      lint.enable = true;
      lualine = {
        enable = true;
      };
      luasnip.enable = true;
      lsp = {
	enable = true;
	servers = {
	  bashls.enable = true;
#	  cssls.enable = true;
          docker-compose-language-service.enable = true;
          dockerls.enable = true;
#	  html.enable = true;
#	  jsonls.enable = true;
	  lua-ls.enable = true;
          marksman.enable = true;
          nil-ls.enable = true;
	  nixd.enable = true;
          nginx-language-server.enable = true;
          phpactor.enable = true;
	  pyright.enable = true;
          rust-analyzer = {
	    enable = true;
	    installRustc = true;
	    installCargo = true;
	  };
          sqls.enable = true;
	  tailwindcss.enable = true;
	  tsserver.enable = true;
          yamlls.enable = true;
          zls.enable = true;
	};

      };
      lsp-lines.enable = true;
      mini = {
        enable = true;
        modules = {
          comment = { };
          diff = { };
          files = { };
          hipatterns = { };
          indentscope = { 
            symbol = "|";
            options = {
              try_as_border = true;
            };
          };
          move = { };
          pairs = { };
          surround = { };
          starter = { };
        };
      };
      nix.enable = true;
      noice.enable = true;
      notify.enable = true;
      nvim-colorizer.enable = true;
      nvim-autopairs.enable = true;
      persistence.enable = true;
      startup = { 
	enable = true;
	theme = "dashboard";
      };
      telescope = {
        enable = true;
        keymaps = {
          "<leader>f" = "find_files";
          "<leader>l" = "live_grep";
        };
      };
      tmux-navigator.enable = true;
      todo-comments.enable = true;
      treesitter = {
	enable = true;
	nixGrammars = true;
      };
      treesitter-context.enable = true;
      treesitter-textobjects.enable = true;
      trouble.enable = true;
      ts-autotag.enable = true;
      ts-context-commentstring = {
        enable = true;
        extraOptions = {
          enable_autocmd = false;
        };
      };
      typescript-tools.enable = true;
      which-key.enable = true;
    };

    extraPlugins = [ plugins.telescope-file-browser-nvim ];

    # FOR NEOVIDE
    extraConfigLua = '' 
      vim.opt.guifont = "JetBrainsMono\\ NFM,Noto_Color_Emoji:h14"
      vim.g.neovide_cursor_animation_length = 0.05

      local colors = {
        blue   = '#${theme.base0D}',
        cyan   = '#${theme.base0C}',
        black  = '#${theme.base00}',
        white  = '#${theme.base05}',
        red    = '#${theme.base08}',
        violet = '#${theme.base0E}',
        grey   = '#${theme.base02}',
      }

      local bubbles_theme = {
        normal = {
          a = { fg = colors.black, bg = colors.violet },
          b = { fg = colors.white, bg = colors.grey },
          c = { fg = colors.black, bg = colors.black },
        },

        insert = { a = { fg = colors.black, bg = colors.blue } },
        visual = { a = { fg = colors.black, bg = colors.cyan } },
        replace = { a = { fg = colors.black, bg = colors.red } },

        inactive = {
          a = { fg = colors.white, bg = colors.black },
          b = { fg = colors.white, bg = colors.black },
          c = { fg = colors.black, bg = colors.black },
        },
      }

      require('lualine').setup {
        options = {
          theme = bubbles_theme,
          component_separators = '|',
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = {
            { 'mode', separator = { left = '' }, right_padding = 2 },
          },
          lualine_b = { 'filename', 'branch' },
          lualine_c = { 'fileformat' },
          lualine_x = {},
          lualine_y = { 'filetype', 'progress' },
          lualine_z = {
            { 'location', separator = { right = '' }, left_padding = 2 },
          },
        },
        inactive_sections = {
          lualine_a = { 'filename' },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'location' },
        },
        tabline = {},
        extensions = {},
      }
    '';

    extraConfigVim = ''
      set noshowmode
      inoremap jj <ESC>
    '';

    keymaps = [
      {
        mode = "n";
        key = "<leader>tb";
        action = ":Telescope file_browser<CR>";
        options.noremap = true;
      }
      {
        mode = "n";
        key = "<leader>fb";
        action = ":lua MiniFiles.open()";
        options.noremap = true;
      }
      {
        key = "<Tab>";
        action = ":bnext<CR>";
        options.silent = false;
      }
      {
        key = "<S-Tab>";
        action = ":bprev<CR>";
        options.silent = false;
      }
    ];


  };
 } 
