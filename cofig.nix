# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  background-package = pkgs.stdenvNoCC.mkDerivation {
    name = "background-image";
    src = /home/mrhock99/.local/share/wallpapers;
    dontUnpack = true;
    installPhase = ''
      cp $src/wallpaper.jpg $out
    '';
  };
  
in 
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use the latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  networking.hostName = "nixos"; # Define your hostname.

  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  # services.displayManager.sddm.enable = true;
  services.displayManager.sddm = {
      enable = lib.mkDefault true;
      theme = "breeze";
      wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable Bluetooth
  hardware.bluetooth.enable = true;  # This line may be necessary for some hardware

  #Enable kde-connect
  programs.kdeconnect.enable = true;
  

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

  };
 
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mrhock99 = {
    isNormalUser = true;
    description = "MR. H O C K";
    extraGroups = [ "networkmanager" "wheel" "plugdev" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;
  

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # $ nix search wget
  environment.systemPackages = with pkgs; [

   # custom sddm wallpaper
   (
       pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
         [General]
         background = ${background-package}
       ''
   )

   #browser
   google-chrome

   # social
   zapzap
   discord
   telegram-desktop


   # terminal
   ghostty
   warp-terminal

   #utility
   flatpak
   
   #music and video player
   rhythmbox
   amarok
   vlc
   
   # kde apps
   kdePackages.kdeconnect-kde
   kdePackages.kdeplasma-addons
   kdePackages.kde-cli-tools
   kate
   kdePackages.kdenlive   
   
   # packages for bluetooth
   bluez

   #video and image editor
   gimp
   digikam
   blender
   krita
   drawing
   iotas
   inkscape
   darktable
   rawtherapee
   lorien

   #notes
   joplin-desktop

   #office
   onlyoffice-bin_latest
   libreoffice-qt6-fresh
   localsend
   android-tools
   usbutils

   #code editor
   micro
   neovim
   zed-editor
   vscode
   
   # programming tools
   # Programming Language and compiler
   bun
   python3
   nodejs_23
   codeblocksFull
   git 
   wget
   clang
   python3Packages.pip
   gcc
   clang
   cmake
   curl
  ];

  # Enable flatpak
  services.flatpak.enable = true;
 
  # adb error fixing
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="2717", MODE="0666", GROUP="plugdev"
  '';
  system.stateVersion = "25.05"; # Did you read the comment?

}
