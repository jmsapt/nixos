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
  # 
    home.sessionVariables = {
      MOZ_ENABLE_WAYLAND = 1;
      QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
      WLR_NO_HARDWARE_CURSORS = 1;
      CLUTTER_BACKEND = "wayland";
      XDG_SESSION_TYPE = "wayland";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      WLR_BACKEND = "gl"; # No GPU :'(
      QT_QPA_PLATFORM = "wayland";
      GDK_BACKEND = "wayland";
      NIXOS_OZONE_WL = 1;
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
    };

  # SSH
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host cse
        HostName login.cse.unsw.edu.au
        User z5310803
        # ForwardX11 yes
        IdentityFile ~/.ssh/id_ed25519
    '';
  };

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
  # TODO fix and finish
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
          "mail.smtpserver.smtp_${id}.username" = "james.appleton";
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
      smtp.tls.useStartTls = true;
    };

    # Just configure Gmail by hand :(
    # Just remember to change the Auth method to oauth
    Gmail = {
      thunderbird = {
        enable = true;
        settings = id: {

          # 10 => OAuth2
          # (Found by replicating auto-setup gmail account)
          "mail.smtpserver.smtp_${id}.authMethod" = 10;
          "mail.smtpserver.smtp_${id}.description" = "Google Mail";
          "mail.smtpserver.smtp_${id}.hostname" = "smtp.gmail.com";
          "mail.smtpserver.smtp_${id}.oauth2.issuer" = "accounts.google.com";
          "mail.smtpserver.smtp_${id}.oauth2.scope" = "https://mail.google.com/ https://www.googleapis.com/auth/carddav https://www.googleapis.com/auth/calendar";
          "mail.smtpserver.smtp_${id}.type" = "smtp";
          "mail.smtpserver.smtp_${id}.port" = 465;
          # "mail.smtpserver.smtp_${id}.try_ssl" = 3;
          # "mail.smtpserver.smtp_${id}.type" = "smtp";
          "mail.smtpserver.smtp_${id}.username" = "james.appleton01@gmail.com";

          # IMAP Server
          "mail.server.server_${id}.authMethod" = 10;
          "mail.server.server_${id}.check_new_mail" = true;
          "mail.server.server_${id}.clientid" = "9e836866-c14a-4ea2-93d3-68a6b372d706";
          "mail.server.server_${id}.directory" = "/home/james/.thunderbird/james/ImapMail/imap.gmail-2.com";
          "mail.server.server_${id}.directory-rel" = "[ProfD]ImapMail/imap.gmail-2.com";
          "mail.server.server_${id}.hostname" = "imap.gmail.com";
          "mail.server.server_${id}.is_gmail" = true;
          # "mail.server.server_${id}.lastFilterTime" = 28756845;
          "mail.server.server_${id}.login_at_startup" = true;
          "mail.server.server_${id}.max_cached_connections" = 5;
          "mail.server.server_${id}.moveTargetMode" = 1;
          # NAME
          "mail.server.server_${id}.namespace.personal" = "";
          # "mail.server.server_${id}.lastFilterTime" = 28756855;
          "mail.server.server_${id}.oauth2.issuer" = "accounts.google.com";
          "mail.server.server_${id}.oauth2.scope" = "https://mail.google.com/ https://www.googleapis.com/auth/carddav https://www.googleapis.com/auth/calendar";
          "mail.server.server_${id}.port" = 993;
          "mail.server.server_${id}.serverIDResponse" = ''("name" "GImap" "vendor" "Google, Inc." "support-url" "https://support.google.com/mail" "version" "gmail.imap-server_20240815.06_p1" "remote-host" "58.110.9.101")'';

          "mail.server.server_${id}.socketType" = 3;
          "mail.server.server_${id}.type" = "imap";
          "mail.server.server_${id}.userName" = "james.appleton01@gmail.com";


        };
      };

      # flavor = "gmail.com";
      realName = "James Appleton";
      address  = "james.appleton01@gmail.com.au";
      userName = "james.appleton01@gmail.com.au";

      smtp.port = 465;
      smtp.host = "smtp.gmail.com";
      smtp.tls.enable = true;

      imap.port = 993;
      imap.host = "imap.gmail.com";
      imap.tls.enable = true;
    };
    
  };
  
  #   # # TODO remove at end of 2024T3
  #   # unsw = {
  #   #   address = "z5310803@ad.unsw.edu.au";

  #   # };
  # ;


  home.stateVersion = "24.11";
}
