# Zsh config
# Note: the `let` block is to help improve the speed of zsh loading
{inputs, pkgs, lib, ...}: 
{
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    # Manual Plugins for theme
    plugins = [
      # Theme
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./p10k-config;
        file = "p10k.zsh";
      }
    ];

    # Oh My Zsh for other plugins
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "colored-man-pages"
      ];
    };

    # Aliases
    shellAliases = { };
  };
}
