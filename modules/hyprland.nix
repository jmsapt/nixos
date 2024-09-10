{inputs, nixpkgs, pkgs, config, ...}: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.xwayland.enable = true;


  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    graphics.enable = true;
    nvidia.modesetting.enable = true;
  };

  # Sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;

    wireplumber.enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # X-portal and WL Roots (for stuff like screen sharing)
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;

    extraPortals = with pkgs; [
      # xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
    # config = {
    #   common.default = ["gtk"];
    #   hyprland.default = ["gtk" "hyprland"];
    # };
  };

  # programs and services
  programs.thunar.enable = true;
  programs.firefox.enable = true;

  # Bluetooth
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # USB Mounting
  services.gvfs.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    nerdfonts
    # (nerdfonts.override { fonts = [ "FiraCode" "FiraMono" "DroidSansMono" ]; })
  ];

  # Dependent Packages
  environment.systemPackages = with pkgs; [
    # Hyprland Ecosystem
    hyprpaper
    hyprlock

    # Waybar
    waybar

    # Terminals
    kitty
    alacritty

    # Browser
    firefox

    # Dependencies for waybar and other utilies
    networkmanagerapplet
    pamixer
    mako
    dunst
    libnotify
    swaynotificationcenter
    wl-clipboard
    wofi
    rofi
    jq
    yad

    # Screenshots
    swappy
    slurp
    grim

    # Obs
    obs-studio
  ];

  # OBS virtual camera
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  boot.kernelModules = [
  "v4l2loopback"
  ];

}
