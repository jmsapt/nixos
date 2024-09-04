# Thunderbird config and authentication
{config, pkgs, osConfig, ...}: 
let
  host = osConfig.networking.hostName;
in {
  programs.thunderbird.enable = true;
}
