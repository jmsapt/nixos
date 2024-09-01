{config, inputs, pkgs, ...}: {
  programs.vim = {
    enable = true;

    # Vimrc
    extraConfig = builtins.readFile ./.vimrc;
  };
}
