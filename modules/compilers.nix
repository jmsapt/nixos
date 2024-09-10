# Basic commandline programs and utilities
{inputs, pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Man pages
    man-pages
    man-pages-posix

    # Compilers
    gcc
    clang

    # Build systems
    cmake
    ninja

    # langauge servers & formatters

    # interpreters
    # ...
  ];
}
