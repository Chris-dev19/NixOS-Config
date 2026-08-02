{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # =====================
  # Dconf (Nécessaire pour les thèmes GTK & Home Manager)
  # =====================
  programs.dconf.enable = true;

  # Polkit pour l'authentification sous un Window Manager
  security.polkit.enable = true;


  # =====================
  # XDG Desktop Portal (Fix pour les apps comme Flameshot, OBS, etc.)
  # =====================
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };


  # =====================
  # Nix Helper
  # =====================
  programs.nh = {
    enable = true;
    flake = "/etc/nixos";
  };


  # =====================
  # Yazi File Manager
  # =====================
  programs.yazi.enable = true;


  # =====================
  # Home Manager
  # =====================
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;

    backupFileExtension = "backup";

    users.jose = import ./home.nix;
  };


  # =====================
  # Boot
  # =====================
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  # =====================
  # Réseau
  # =====================
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;


  # =====================
  # Localisation
  # =====================
  time.timeZone = "Africa/Brazzaville";

  i18n.defaultLocale = "fr_FR.UTF-8";

  console.keyMap = "fr";


  # =====================
  # Serveur X11 & OXWM
  # =====================
  services.xserver = {
    enable = true;
    xkb.layout = "fr";
    displayManager.lightdm.enable = true;
    windowManager.oxwm.enable = true;
  };

  # Syntaxe mise à jour pour le Display Manager
  services.displayManager.defaultSession = "oxwm";


  # =====================
  # Audio
  # =====================
  services.pulseaudio.enable = false;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };


  # =====================
  # Impression
  # =====================
  services.printing.enable = false;


  # =====================
  # Utilisateur
  # =====================
  users.users.jose = {
    isNormalUser = true;

    description = "José";

    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "vboxusers"
    ];
  };


  # =====================
  # Programmes & Dépendances
  # =====================
  programs.firefox.enable = false;
  virtualisation.virtualbox.host.enable = true;
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    go
    git
    python3
    figlet
    rustc
    cargo
    rustfmt
    opencode-desktop
    clippy
    rofi
    networkmanager
    maim
    gcc
    pkg-config
    dunst
    picom
    xwallpaper
    brightnessctl
    pamixer
    networkmanager_dmenu
    trash-cli
    fastfetch
    zig
    ruby
    htop
    # Outils pour session X11
    xterm
  ];


  # =====================
  # Flakes
  # =====================
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];


  system.stateVersion = "26.05";
}
