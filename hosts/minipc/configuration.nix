# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  
    boot.initrd.luks.devices = {
      cryptroot = {
        device = "/dev/disk/by-uuid/2420dd82-403c-4af5-9978-76edb4cfd18e";
        preLVM = true;
      };
    };
  
    networking.hostName = "nixos";
    time.timeZone = "Europe/London";
  
    i18n.defaultLocale = "en_GB.UTF-8";
    console = {
      keyMap = lib.mkForce "uk";
      useXkbConfig = true;
    };
  
    # Enable the X11 windowing system.
    services.xserver.enable = true;
    services.desktopManager.plasma6.enable = true;
    services.displayManager.sddm.enable = true;
  
    services.flatpak.enable = true;
    systemd.user.services.setup-flathub = {
        description = "Add Flathub remote";
        wantedBy = [ "default.target" ];
        serviceConfig.ExecStart = "${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo";
    };

    networking.networkmanager.enable = true;
  
    # Enable CUPS to print documents.
    # services.printing.enable = true;
  
    # Enable sound.
    # hardware.pulseaudio.enable = true;
    # OR
    # services.pipewire = {
    #   enable = true;
    #   pulse.enable = true;
    # };
  
    # Enable touchpad support (enabled default in most desktopManager).
    # services.libinput.enable = true;
    
    users.users.byte = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];
      hashedPassword = null;
    };
  
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        vim 
        wget
        firefox
        git
        gcc
        gdb
        gnumake
        man-pages
        man-pages-posix
        binutils
        strace
        lsof
        coreutils
        fuse
    ];

    environment.sessionVariables.XDG_DATA_DIRS = [
        "/home/byte/.local/share/flatpak/exports/share"
        "/var/lib/flatpak/exports/share"
        "/usr/local/share"
        "/usr/share"
    ];
  
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    system.stateVersion = "24.11"; # Did you read the comment?
}

