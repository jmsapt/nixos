{inputs, pkgs, ...}: {
  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;

    theme = "catppuccin-mocha";
    package = pkgs.kdePackages.sddm;
  };
  
  # Themes
  environment.systemPackages = with pkgs; [
    (catppuccin-sddm.override {
      flavor = "mocha";
      font  = "Noto Sans";
      fontSize = "9";
      # background = "${./wallpaper.png}";
      # loginBackground = true;
    })
    # where-is-my-sddm-theme
  ];
}
