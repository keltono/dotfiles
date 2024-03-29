{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "kelton";
  home.homeDirectory = "/home/kelton";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # nixpkgs.overlays = [
  #   (import (builtins.fetchTarball {
  #     url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
  #   }))
  # ]; 
  home.packages = [
    pkgs.neovim
    pkgs.mosh
    pkgs.feh
    pkgs.cmus
    pkgs.gcal
    pkgs.maim
    pkgs.evince
    pkgs.texlive.combined.scheme-full 
    pkgs.fish
    pkgs.fasd
    pkgs.mumble
    pkgs.fzf
    pkgs.foma
    pkgs.nodePackages.pyright
    pkgs.tectonic
    pkgs.graphviz
    pkgs.wasm-pack
    pkgs.rust-analyzer
    pkgs.nix-prefetch-git
    pkgs.cabal2nix
    pkgs.haskellPackages.alex
    pkgs.haskellPackages.happy
    pkgs.youtube-dl
    pkgs.mpv
  ];
}
