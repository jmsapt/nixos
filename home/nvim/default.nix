{inputs, pkgs, ...} : {
  programs.neovim = {
    enable = true;
  };

  # Just symlink to existing nvim config
  home.file.".config/nvim" = {
    source = builtins.fetchGit {
      url = "https://github.com/jmsapt/nvim.git";
      ref = "master";
      rev = "25bce95beabc80064e7ea79e42f7c8a739e85ed7";
    };
    recursive = true;
  };
}
