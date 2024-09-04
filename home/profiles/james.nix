# Keep account specific stuff (like git and thunderbird) in this
# profile specific config file
{inputs, pkgs, ...}: 
let
  # SOPS for secrets
  sops-home = import inputs.sops-nix.homeManagerModules.sops;
  secrets = sops-home.secrets;
in
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

  # V-Card (for email)
  home.file.".vcard/james.vcf".text = ''
    BEGIN:VCARD
    VERSION:4.0
    FN:James Appleton
    EMAIL:james.appleton@optusnet.com.au
    TEL:+61421523584
    END:VCARD
  '';

  # Thunderbird (email client)
  programs.thunderbird = {
    enable = true;

    profiles.james.isDefault = true;

  };


  # Email account
  accounts.email.accounts = {
    OptusNet = {
      primary = true;
      thunderbird = {
        enable = true;
        settings = id: {
          # 3 => Normal Password
          # "mail.smtpserver.smtp_${id}.authMethod" = 3;
          # "mail.server.server_${id}.authMethod" = 3;
        };
      };

      flavor = "plain";
      realName = "James Appleton";
      address  = "james.appleton@optusnet.com.au";
      userName = "james.appleton";

      # mbsync.enable = true;
      # msmtp.enable  = true;

      imap.host = "mail.optusnet.com.au";
      imap.port = 993;
      imap.tls.enable = true;

      smtp.host = "smtp.optusnet.com.au";
      smtp.port = 25;
      smtp.tls.enable = true;
    };

    # Just configure Gmail by hand :(
    /* # Just remember to change the Auth method to oauth
    Gmail = {
      thunderbird = {
        enable = true;
        settings = id: {
          # 10 => OAuth2
          # (Found by replicating auto-setup gmail account)
          "mail.smtpserver.smtp_${id}.authMethod" = 10;
          "mail.smtpserver.stmp_${id}.description" = "Google Mail";
          "mail.smtpserver.stmp_${id}.type" = "smtp";
          "mail.smtpserver.smtp_${id}.oauth2.issuer" = "accounts.google.com";
          "mail.smtpserver.smtp_${id}.oauth2.scope" = "https://mail.google.com/ https://www.googleapis.com/auth/carddav https://www.googleapis.com/auth/calendar";

          "mail.server.server_${id}.authMethod" = 10;
          "mail.server.server_${id}.hostname" = "imap.gmail.com";
          "mail.server.server_${id}.login_at_startup" = true;
          "mail.server.server_${id}.is_gmail" = true;
          "mail.server.server_${id}.oauth2.issuer" = "accounts.google.com";
          "mail.server.server_${id}.oauth2.scope" = "https://mail.google.com/ https://www.googleapis.com/auth/carddav https://www.googleapis.com/auth/calendar";
          "mail.server.server_${id}.serverIDResponse" = ''("name" "GImap" "vendor" "Google, Inc." "support-url" "https://support.google.com/mail" "version" "gmail.imap-server_20240815.06_p1" "remote-host" "58.110.9.101")'';
        };
      };

      # flavor = "gmail.com";
      realName = "James Appleton";
      address = "james.appleton01@gmail.com.au";
      userName = "james.appleton01@gmail.com.au";

      smtp.port = 465;
      smtp.host = "smtp.gmail.com";
      smtp.tls.enable = true;

      imap.port = 993;
      imap.host = "imap.gmail.com";
      imap.tls.enable = true;
    };
    */
  };
  
  #   # # TODO remove at end of 2024T3
  #   # unsw = {
  #   #   address = "z5310803@ad.unsw.edu.au";

  #   # };
  # };


  home.stateVersion = "24.11";
}
