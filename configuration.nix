# Help is available in the configuration.nix(5) man page
#nixpkgs and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

let
  custom-typefaces = pkgs.callPackage ./packages/fonts.nix { inherit pkgs; };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "elkTown"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  hardware.pulseaudio.enable = false;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      cups-filters
      cups-browsed
    ];
  };
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;



  xdg.portal.enable = true;
  xdg.portal.wlr.enable = true;
  hardware.bluetooth.enable = true; 
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };
  services.blueman.enable = true;

  i18n.inputMethod = {
    enable = true;
    type  = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-gtk fcitx5-mozc fcitx5-nord fcitx5-chewing fcitx5-chinese-addons kdePackages.fcitx5-qt ];
    fcitx5.waylandFrontend = true;
  };
  services.xserver = {
    xkb.layout = "us,fr";
    xkb.variant = ",";
    xkb.options = "grp:win_space_toggle";
    enable = true;
    displayManager.gdm.enable = true;
  };
  services.xserver.desktopManager.runXdgAutostartIfNone = true;



  nixpkgs.config.allowBroken = true; 
  programs.light.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Indiana/Indianapolis";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kelton = {
    isNormalUser = true;
    description = "kelton";
    extraGroups = [ "networkmanager" "wheel" "adbusers" "audio" "video" "lp" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;



  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    fira-code
    fira-code-symbols
    custom-typefaces

  ];


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.pathsToLink = [ "share/foot" ];
  environment.systemPackages = with pkgs; [
    agda
    neovim 
    grim
    wl-clipboard
    mako
    firefox
    signal-desktop
    wget
    git
    neofetch
    foot
    android-tools
    android-udev-rules
    google-chrome
    kitty
    utillinux
    bubblewrap
    lutris
    wineWowPackages.stable
    wineWowPackages.waylandFull
    usbutils
    pavucontrol
    anki-bin
    bluez 
    bluez-tools
    htop
    killall
    ranger
    spotify
    python3
    libreoffice-fresh
    ocaml
    ocamlPackages.findlib ocamlPackages.camlp5 ocamlPackages.num ocamlPackages.mccs
    gnumake
    opam
    m4
    coq
    coqPackages.equations
    fzf
    zoom-us
    ((emacsPackagesFor emacs).emacsWithPackages (
      epkgs: [ epkgs.vterm epkgs.proof-general epkgs.evil epkgs.gruvbox-theme epkgs.doom ]
    ))
    (agda.withPackages (
      p: [ 
           p.standard-library 
	 ]
    ))
    obsidian
    sioyek
    feh
    mupdf
    #lmms
    slurp
    wl-clipboard
    texlive.combined.scheme-full
    ripgrep
    cabal-install
    ghc
    ghcid
    haskell-language-server
    wdisplays
    mpv
    musescore
    zip
    busybox
    prismlauncher
    audacity
    desmume
    krita
    mosh
    cmus
    discord
    gcc
    wl-mirror
    zathura
    valgrind
    gdb
    tectonic
    pdftk
    haskellPackages.BNFC
    haskellPackages.happy
    haskellPackages.alex
    hpack
    man-pages
    man-pages-posix
  ];
  programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };



	   #(p.agdarsec.overrideAttrs (oldAttrs: {
	  #   version = "0.5.0";
          #   src = fetchFromGitHub {
       	  #     owner = "gallais";
	  #     repo = "agdarsec";
	  #     rev = "v0.5.0";
        #    hash = "sha256-AQ+RJqcbDVWPqmtil8frIisKOTeTQacyY3QV052+t+c=";
        #     };
	#   }))


   services.gnome.gnome-keyring.enable = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

#let
#  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
#in
#{
#  imports = [
#    (import "${home-manager}/nixos")
#  ];
#
#  home-manager.users.my_username = {
#    /* The home.stateVersion option does not have a default and must be set */
#    home.stateVersion = "24.05";
#    /* Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ]; */
#    programs.kitty = {
#        enable = true;
#	settings = {
#	     confirm_os_window_close = 0;
#	     enable_audio_bell = false;
#	};
#    };
#
#  };
#}
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
