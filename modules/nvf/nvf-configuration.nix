{ pkgs, lib, ... }:

{
  vim = {
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
  };
}
