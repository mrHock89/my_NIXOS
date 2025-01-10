# configuration.nix

{ config, pkgs, lib, ... }:

let
  # Define the custom background package with the correct relative path
  background-package = pkgs.stdenvNoCC.mkDerivation {
    name = "background-image";
    src = ./wallpaper.jpg;  # Place wallpaper.jpg in the same directory as this config file
    dontUnpack = true;
    installPhase = ''
      cp $src $out
    '';
  };
  
in 
{
  imports =
    [ ./hardware-configuration.nix ];

  # Bootloader configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel selection
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  networking.hostName = "nixos";

  networking.networkmanager.enable = true;

  # Time and locale settings
  time.timeZone = "Asia/Kolkata";
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

  # X11 and KDE Plasma configuration
  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = lib.mkDefault true;
    theme = "breeze";
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Printing and Bluetooth support
  services.printing.enable = true;
  hardware.bluetooth.enable = true;

  # KDE Connect
  programs.kdeconnect.enable = true;

  # PipeWire for sound
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  security.rtkit.enable = true;

  # User definition
  users.users.mrhock99 = {
    isNormalUser = true;
    description = "MR. H O C K";
    extraGroups = [ "networkmanager" "wheel" "plugdev" ];
    packages = with pkgs; [ kdePackages.kate ];
  };

  # Program installations
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = with pkgs; [


  #custom sddm dackground image
  (
	  pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
	    [General]
	    background = "${background-package}"
	  ''
  )

  #browsers
  google-chrome
  vivaldi
  tor-browser
  librewolf
  

  #social
  zapzap
  discord
  telegram-desktop

  #terminals
  ghostty
  warp-terminal

  #services and usefull aps
  flatpak
  bluez  #bluetooth

  # audio and video palyer
  rhythmbox
  amarok
  vlc

  #kde apps
  kdePackages.kdeconnect-kde
  kdePackages.kdeplasma-addons
  kdePackages.kde-cli-tools
  kate

  # audio video and Image editor
  kdePackages.kdenlive   
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

  #terminal apps
  unzip
  sl
  cmatrix
  fastfetch
  cmatrix
  zsh

  #notes app
  joplin-desktop

  #office apps
  onlyoffice-bin_latest
  libreoffice-qt6-fresh

  # other apps
  localsend
  android-tools
  usbutils

  #code editor
  micro
  neovim
  zed-editor
  vscode

  #programming language and compilers
  bun
  python3
  nodejs_23
  codeblocksFull
  git
  wget
  clang
  python3Packages.pip
  gcc
  cmake
  curl
  ruby                # Ruby programming language (for some tools)
  go                  # Go programming language (for some tools)

  #Hacking tools
  nmap                # Network exploration tool and security/port scanner
  wireshark           # Network protocol analyzer
  tcpdump             # Command-line packet analyzer
  metasploit          # Penetration testing framework
  burpsuite           # Web vulnerability scanner
  sqlmap              # Automatic SQL injection and database takeover tool
  aircrack-ng         # Wireless security auditing tools
  john                # Password cracking tool
  hashcat             # Advanced password recovery tool
  gobuster            # Directory/file brute-forcing tool
  nikto               # Web server scanner
  dirb                # Web content scanner
  theharvester        # E-mail, subdomain, and people search tool
  dnsenum             # DNS enumeration tool
  enum4linux          # Linux enumeration tool
  netcat              # Networking utility for reading/writing data
  hydra               # Password cracking tool for network services
  social-engineer-toolkit # Framework for social engineering
  #exploitdb           # Exploit database
  #gimp                # Image manipulation program (for creating phishing images, etc.)
  # virtualbox          # Virtualization software (for running VMs)
  docker              # Containerization platform
  #git                 # Version control system

  # Additional Kali tools
  bettercap           # Network attack and monitoring framework
  dnsrecon            # DNS reconnaissance tool
  netexec
  hash-identifier     # Identify hashes
  maltego             # Open-source intelligence and forensics application
  mitmproxy           # Intercepting proxy for HTTP/HTTPS
  nikto               # Web server scanner
  #osrframework        # Open Source Intelligence Framework
  pwncat              # A netcat clone with a focus on post-exploitation
  responder           # LLMNR, NBT-NS and MDNS poisoner
  wifite2              # Automated wireless attack tool
  veilid                # Evasion tool for payloads

  ];

  services.flatpak.enable = true;

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="2717", MODE="0666", GROUP="plugdev"
  '';

  system.stateVersion = "25.05"; # Adjust this to your NixOS version
}
