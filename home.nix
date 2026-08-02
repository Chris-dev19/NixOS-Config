{ config, pkgs, lib, inputs, ... }:

let
  system = pkgs.stdenv.hostPlatform.system;
  spicePkgs = inputs.spicetify-nix.legacyPackages.${system};
in
{
  home.username = "jose";
  home.homeDirectory = "/home/jose";

  home.stateVersion = "26.05";

  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;

    shellAliases = {
      btw = "echo i use nixos btw";
    };
  };

  programs.vscodium = {
    enable = true;
  };

  home.packages = with pkgs; [
    # Développement
    neovim
    zed-editor
    virtualbox
    motrix

    # Terminal
    kitty

    # Polices
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code

    # Internet
    discord
    element-desktop

    #Video Editing
    blender
    obs-studio
    audacity
    vlc

    # Navigateur
    inputs.helium.packages.${system}.default
  ];

  # =====================
  # Thème GTK & Icônes (Maintien moderne)
  # =====================
  gtk = {
    enable = true;

    # Thème sombre moderne compatible avec GTK3/4
    theme = {
      name = "catppuccin-mocha-blue-standard";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "blue" ];
        size = "standard";
        variant = "mocha";
      };
    };

    # Icônes Papirus (contient les variantes sombres Tokyo-friendly)
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  # =====================
  # Configuration dconf (Mode sombre GTK4 / Libadwaita)
  # =====================
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "catppuccin-mocha-blue-standard";
      icon-theme = "Papirus-Dark";
    };
  };

  # =====================
  # Spicetify Tokyo Night
  # =====================
  programs.spicetify = {
    enable = true;

    # Le thème TokyoNight de Spicetify fonctionne toujours parfaitement !
    theme = spicePkgs.themes.tokyoNight;

    enabledExtensions = with spicePkgs.extensions; [
      adblockify
    ];
  };
}
