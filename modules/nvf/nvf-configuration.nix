{ pkgs, lib, ... }:

{
  vim = {
    viAlias = true;
    vimAlias = true;
    preventJunkFiles = true;

    theme = {
      enable = true;
      # https://nvf.notashelf.dev/options.html#option-vim.theme.name
      name = "catppuccin";
      style = "auto";
    };

    options = {
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      list = true;
      listchars = "space:·";
      encoding = "utf-8";
    };

    statusline.lualine.enable = true;

    notes.orgmode = {
      enable = true;
    };

    notes.todo-comments = {
      enable = true;
    };

    telescope = {
      enable = true;
    };

    autocomplete.nvim-cmp = {
      enable = true;
      setupOpts.completion.completeOpt = "menu,menuone,noselect";
      mappings.confirm = "<C-CR>";
      mappings.close = "<Esc>";
    };

    languages = {
      enableTreesitter = true;

      nix.enable = true;
      typescript.enable = true;
      rust.enable = true;
      yaml.enable = true;
      markdown.enable = true;
    };

    diagnostics = {
      nvim-lint = {
        linters_by_ft = {
          plaintex = ["chktex"];
        };
      };
    };

    git = {
      enable = true;
    };

    dashboard = {
      dashboard-nvim = {
        enable = false;
        setupOpts = {
          # adapted from nvf logo (https://github.com/NotAShelf/nvf)
          # under CC-BY (https://creativecommons.org/licenses/by/4.0/)
          config.header = [
            "   🭇🭄🭏🬼          🬿    "
            "  🭊🭁██🭌🬿         █🭏🬼  "
            "  🭥🭒████🭏🬼       ██🭌🬿 "
            "λ  🭢🭕████🭌🬿      ████🭏"
            "VλV  🭥🭒████🭏🬼    █████"
            "λVλVλ 🭢🭕████🭌🬿   █████"
            "VλV󱄅    🭥🭒████🭏🬼 🭕████"
            "λVλVλ    🭢🭕████🭌🬿 🭥🭒██"
            "V󱄅 λV      🭥🭒████🭏🬼🭢🭕🭠"
            "λVλVλ       🭢🭕████🭌🬿  "
            "  VλV         🭥🭒██🭝🭚  "
            "    λ          🭢🭕🭠🭗   "
            ""
          ];
        };
      };
    };

    spellcheck = {
      enable = true;
      languages = ["en" "de_de"];
      ignoredFiletypes = ["qf"];
      programmingWordlist.enable = true;
    };

    visuals = {
      nvim-web-devicons.enable = true;
      nvim-scrollbar.enable = true;
      fidget-nvim.enable = true;
    };

    ui = {
      borders = {
        enable = false;
        plugins = {
          nvim-cmp.style = "none";
        };
      };
      illuminate = {
        enable = true;
        setupOpts = {
          large_file_cutoff = 2000;
          large_file_overrides = {
            providers = [];
          };
        };
      };
      colorizer = {
        enable = true;
        setupOpts = {
          parsers = {
            css = true;
            hex = {
              default = true;
              rrggbbaa = false;
              hash_aarrggbb = true;
              aarrggbb = true;
              no_hash = true;
            };
          };
        };
      };
    };

    lsp.servers = {
      glsl_analyzer = {};
      lua-language-server = {
        settings.Lua = {
          runtime.version = "LuaJIT";
          workspace.library = ["lua" "\${env:VIMRUNTIME}"];
          diagnostic.globals = ["vim"];
        };
      };
    };
  };
}
