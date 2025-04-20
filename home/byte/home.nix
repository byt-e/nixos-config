{ config, pkgs, ... }:

{
  home.username = "byte";
  home.homeDirectory = "/home/byte";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  # A few nice defaults
  programs.git.enable = true;

  # We'll add Neovim here next...
}

