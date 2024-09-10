# Basic commandline programs and utilities
{inputs, pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    clangd              # C/C++
    lua-language-server # lua
    nixd                # nix
  ];
}
