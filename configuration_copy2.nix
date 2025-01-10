# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

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
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  
  # enableing flakes 
  #nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
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
  services.displayManager.sddm.enable = true;
  # environment.systemPackages = [
  #   (pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
  #     [General]
  #     background=${pkgs.kdePackages.plasma-workspace-wallpapers}/home/mqrhock99/Pictures/anime_girl_countryside_scenery_4k_wallpaper_uhdpaper_com_187@3@a.jpg
  #   '')
  # ];
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable Virtualbox
  # virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.host.enableExtensionPack = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable Bluetooth
  hardware.bluetooth.enable = true;  # This line may be necessary for some hardware

  #Enable kde-connect
  programs.kdeconnect.enable = true;
  

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
 
   

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  # SDDM theme customization
    (pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
      [General]
      background=${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/anime_girl_countryside_scenery_4k_wallpaper_uhdpaper_com_187@3@a.jpg
    '')
  
  # terminal apps
   sl
   cmatrix
   steam-run
   appimage-run
   stdenv 
   # Browsers
   vivaldi
   tor-browser
   librewolf
   floorp
   brave

   # social
   zapzap

   # music
   ytmdesktop
   youtube-music
   spotube
   spotifyd
   spotify

   # Programming
   bun
   nodejs_23

   #editor
   emacs
   code-cursor

   # terminal
   ghostty
   #music player
   amarok
   
   # kde apps
   kdePackages.kdeconnect-kde
   kdePackages.kdeplasma-addons
   kdePackages.kde-cli-tools
   
   # packages for bluetooth
   bluez
   # all usefull apps
   wget
   gimp
   neovim
   git 
   curl
   kate
   micro
   neofetch
   google-chrome
   flatpak
   telegram-desktop
   materialgram # aulternative telegram-dektop apps
   discord
   digikam
   blender
   krita
   drawing
   iotas
   inkscape
   joplin-desktop
   lorien
   vlc
   nmap
   vscode
   codeblocksFull
   kdePackages.kdenlive
   rawtherapee
   darktable
   neovim
   clang
   onlyoffice-bin_latest
   libreoffice-qt6-fresh
   rhythmbox
   warp-terminal
   localsend
   whatsapp-for-linux
   unzip
   gparted
   android-tools
   # bootloader
   os-prober
   usbutils
   
   # programming tools
   neovim
   python3
   python3Packages.pip
   gcc
   clang
   cmake
   curl
   ripgrep  # For Telescope
   fd       # For Telescope
   fzf      # For fuzzy finding 
   zed-editor

   #Hacking tools
   #nmap                # Network exploration tool and security/port scanner
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
   python3             # Python programming language
   ruby                # Ruby programming language (for some tools)
   go                  # Go programming language (for some tools)

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
   #setoolkit           # Social engineering toolkit
   social-engineer-toolkit
  ];

  # Enable flatpak
  services.flatpak.enable = true;
 
  # adb error fixing
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="2717", MODE="0666", GROUP="plugdev"
  '';

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

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
  system.stateVersion = "25.05"; # Did you read the comment?

}
