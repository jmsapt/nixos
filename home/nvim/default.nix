{inputs, pkgs, ...} : {
  programs.neovim = {
    enable = true;
  };

  # Just symlink to existing nvim config
  home.file.".config/nvim" = {
    source = builtins.fetchGit {
      url = "https://github.com/jmsapt/nvim.git";
      ref = "master";
      rev = "edb4a68ee386e2f44acfa72c3fdac96d8ff25610";
    };
    recursive = true;
  };
}
