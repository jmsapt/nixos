# Hyprland configuration (depends on waybar)
{config, pkgs, osConfig, ...}: 
let
  host = osConfig.networking.hostName;
in {
  wayland.windowManager.hyprland.enable = true;
  
  # Screenshot Config (Swappy)
  home.file.".config/swappy/config".text = ''
    [Default]
    save_dir = $HOME/Screenshots
    save_filename_format = Screenshot_%Y-%m-%d_%H:%M:%S.png
  '';

  # Hyprland Configurations
  home.file.".config/hypr" = {
    source = ./hypr;
    recursive = true;
  };

  # Wallpapers
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "~/.config/wallpapers/mt-fuji-lake.jpg"
      ];
      wallpaper = [
        ", ~/.config/wallpapers/mt-fuji-lake.jpg"
      ];
    };
  };
  home.file.".config/wallpapers" = {
    source = ./wallpapers;
    recursive = true;
  };

  # Waybar configuration
  home.file.".config/waybar" = {
    source = ./waybar/standard;
    recursive = true;
  };

  # Swaync configuration
  home.file.".config/swaync" = {
    source = ./swaync;
    recursive = true;
  };

  # System Specific Configs (e.g. monitors, sensitivity)
  home.file.".config/hypr/system.conf".source = if host == "desktop" then
    ./desktop.conf
  else if host == "laptop" then
    ./laptop.conf
  else
    ''# No specific system config'';
}
