# ZSH related packages for the system
{ input, pkgs, ... }: {
  programs.zsh.enable = true;
  environment.systemPackages = with pkgs; [
    zsh
    oh-my-zsh
    zsh-completions
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-history-substring-search

    # Themes
    zsh-powerlevel10k
  ];
}
