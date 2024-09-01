{inputs, pkgs, ...}: {
  programs.wofi = { 
    enable = true;

    settings = {
      matching = "fuzzy";
      normal_window = true;
    };
  };
}
