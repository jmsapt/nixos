
{ inputs, outputs, lib, pkgs, users, config, ... }:
{
  sops = {
    defaultSopsFile = ../secrets.yaml;
    # validateSopsFiles = false;

    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };

    secrets = {
      # Non-runtime encrypted
      "james/password" = {
        neededForUsers = true;
      };

      # Runtime encrypted
      "james/optusnet-password" = { owner = "james"; };
      "james/gmail-password" = { owner = "james"; };
      "james/unsw-password" = { owner = "james"; };
    };
  };
}
