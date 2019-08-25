# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # zsh & oh-my-zsh config
      ./zsh.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices = [
    {
      name = "root";
      device = "/dev/sda2";
      preLVM = true;
    }
  ];
  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
   time.timeZone = "Australia/Brisbane";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # busybox
    cabal-install
    cabal2nix
    acpilight
    firefox
    git
    stack
    htop
    gimp
    neofetch
    nodejs
    termite
    ghc
    konsole
    (import ./vim.nix)
    nix-prefetch-github
    pulseeffects
    wget 
    zsh
    oh-my-zsh
    xmobar
    termonad-with-packages
    irssi
    fzf
    tmux
    tree
    vscode
    xloadimage

    dmenu                    # A menu for use with xmonad
    feh                      # A light-weight image viewer to set backgrounds
    haskellPackages.libmpd   # Shows MPD status in xmobar
    haskellPackages.xmobar   # A Minimalistic Text Based Status Bar
    libnotify                # Notification client for my Xmonad setup
    lxqt.lxqt-notificationd  # The notify daemon itself
    mpc_cli                  # CLI for MPD, called from xmonad
    scrot                    # CLI screen capture utility
    trayer                   # A system tray for use with xmonad
    xbrightness              # X11 brigthness and gamma software control
    xcompmgr                 # X composting manager
    xorg.xrandr              # CLI to X11 RandR extension
    xorg.xbacklight
    xscreensaver             # My preferred screensaver
    xsettingsd               # A lightweight desktop settings server

  ];

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      #corefonts # Microsoft free fonts
      inconsolata # monospaced
      unifont # some international languages
      font-awesome-ttf
      source-code-pro
      freefont_ttf
      opensans-ttf
      liberation_ttf
      liberationsansnarrow
      ttf_bitstream_vera
      libertine
      ubuntu_font_family
      gentium
      symbola
    ];
  };

  programs.dconf.enable = true;
  programs.light.enable = true;
  # programs.git = {
  #   enable = true;
  #   userName  = "m0n4d1";
  #   userEmail = "m0n4d1000@gmail.com";
  # };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  hardware.acpilight.enable = true;
  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  services = {
    xserver = {
      enable = true;
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
        extraPackages = hpkgs: [           # Open configuration for additional Haskell packages.
          hpkgs.xmonad-contrib             # Install xmonad-contrib.
          hpkgs.xmonad-extras              # Install xmonad-extras.
          hpkgs.xmonad                     # Install xmonad itself.
          hpkgs.xmonad-wallpaper
        ];
      };
      desktopManager.default = "none";
      desktopManager.xterm.enable = false;
      windowManager.default = "xmonad";
      libinput.enable = true;
      xkbOptions = "caps:swapescape";
      layout = "us";
    };
    openssh.enable = true;
  };

  # Enable touchpad support.
  #  services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  #  services.xserver.displayManager.sddm.enable = true;
  #  services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.jane = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  # };
  users.extraUsers.m0n4d = {
    createHome = true;
    extraGroups = ["wheel" "video" "audio" "disk" "networkmanager"];
    group = "users";
    home = "/home/m0n4d";
    isNormalUser = true;
    uid = 1000;
    shell = pkgs.zsh;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?

}
