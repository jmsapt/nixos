# Basic commandline programs and utilities
{inputs, pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    killall

    # TUI Programs
    btop
    neofetch
  ];
}
