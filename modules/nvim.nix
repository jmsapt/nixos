# Basic commandline programs and utilities
{inputs, pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    neovim

    # LSP
    clang-tools # clangd & clang-format
    lua-language-server
    nixd

    # Formatters
  ];
}
