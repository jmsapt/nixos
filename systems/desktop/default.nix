# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ inputs, outputs, lib, pkgs, users, config, ... }:
{
  imports = [ 
    # Required for Nvidia gpu
    inputs.hardware.nixosModules.common-gpu-nvidia-nonprime
    inputs.home-manager.nixosModules.home-manager

    # System hardware
    ./hardware-configuration.nix

    # Sops for secret management
    inputs.sops-nix.nixosModules.sops
    ../../modules/sops.nix

    # Bootloader EFI Shell
    ../../modules/edk2-shell

    # General Modules
    ../../modules/hyprland.nix
    ../../modules/sddm.nix
    ../../modules/cmd.nix
    ../../modules/compilers.nix
    ../../modules/zsh.nix
    ../../modules/thunderbird.nix
  ];
  # Accounts
  users.mutableUsers = false;
  sops.secrets."james/password".neededForUsers = true; 
  users.users.james = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    description = "James Appleton";
    shell = pkgs.zsh;
    hashedPasswordFile = config.sops.secrets."james/password".path;
  };

  # set default editor to vim
  programs.vim.enable = true;
  programs.vim.defaultEditor = true;

  # Fix shebang issues 
  services.envfs.enable = true;
  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Hostname
  networking.hostName = "desktop"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Australia/Sydney";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "us";
  };

  # Home Manager
  home-manager.backupFileExtension = "bak";
  home-manager.users.james = import ../../home/profiles/james.nix;

  # List packages installed in system profile. To search, run:
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    git
    firefox

    zsh
    bash

    discord

    nix-prefetch-github # to get SHA256 for plugins

    # Keygen and Secrets
    age
    sops
  ];

  # Enable gpg key gen
  services.pcscd.enable = true;
  programs.zsh.enable = true;
  programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Services
  services.openssh.enable = true;

  nixpkgs.overlays = [
    (final: prev: {
      hyprpaper = prev.hyprpaper.overrideAttrs rec {
        version = "0.7.0";
        src = prev.fetchFromGitHub {
          owner = "hyprwm";
          repo = "hyprpaper";
          rev = "v${version}";
          hash = "sha256-l13c8ALA7ZKDgluYA1C1OfkDGYD6e1/GR6LJnxCLRhA=";
        };
      };
    })
  ];

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
}

