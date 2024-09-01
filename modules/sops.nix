
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
      james-password = {}; 
    };
  };
}
