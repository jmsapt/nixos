{osConfig, pkgs, ...}: 
let
  system = osConfig.networking.hostName;
in
{
  programs.kitty = {
    enable = true;
    theme = "Tokyo Night";

    keybindings = {
      "super+shift+enter" = "new_os_window_with_cwd"; 
    };
    
    settings = {
      enable_audio_bell = false;

      font_family = "FiraCode Nerd Font Mono";
      font_size = 
      if system == "desktop" then
        13
      else
        13; 

      window_padding_width = 2;

      disable_ligatures = "always";
    };
  };
}
