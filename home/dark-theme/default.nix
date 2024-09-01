{ config, lib, pkgs, ...}: {
  home.packages = with pkgs; [
    nwg-look
  ];

  # Gnome Dark Mode
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };

    # cursorTheme = "Adwaita";

  };


  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };
}
