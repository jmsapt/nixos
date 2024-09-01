{pkgs, ...}: 
{
  # Import dotfile modules
  imports = [
    # Theme
    ../dark-theme

    # Progams
    ../hyprland
    ../zsh
    ../firefox
    ../kitty
    ../vim
    ../wofi
    ../nvim
  ];
  # Git
  programs.git = {
    enable = true;
    userName = "James Appleton";
    userEmail = "james.appleton01@gmail.com";

    extraConfig = {
      push.default = "upstream";
      core.editor = "vim";
      init.defaultBranch = "master";
    };
  };

  home.stateVersion = "24.11";
}
