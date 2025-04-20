{ config, pkgs, ... }:

{
  home.username = "byte";
  home.homeDirectory = "/home/byte";
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    neovim ripgrep fzf tmux fd
  ];

  programs.home-manager.enable = true;

  # Program Setup
  programs.git.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        options = {
            tabstop = 4;
            shiftwidth = 4;
            smarttab = true;
            expandtab = true;
        };
      };
      vim.lineNumberMode = "relNumber";

      vim.theme = {
        enable = true;
        name = "catppuccin";
        style = "frappe";
      };
  
      vim.statusline.lualine.enable = true;
      vim.telescope.enable = true;
      vim.autocomplete.nvim-cmp.enable = true;

      vim.languages = {
        enableLSP = true;
        enableTreesitter = true;
       
        nix.enable = true;
        clang.enable = true;
        clang.cHeader = true;
      };
    };

  };
}

