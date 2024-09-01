# Enables EFI shell
{input, pkgs, stdenv, ...}:
let
  efiShell = pkgs.stdenv.mkDerivation {
    pname = "efi-shell";
    version = "0.1";
    src = ./shellx64.efi;
    unpackPhase = "true";
    buildPhase = ''
      echo Testing??
    '';
    installPhase = ''
      mkdir -p $out/
      cp $src $out/shellx64.efi
    '';
  };
in {
  # Create entry in Nix Registry
  environment.systemPackages = with pkgs; [ efiShell ];

  # Copy into /boot/
  system.activationScripts.installEfiShell = {
    text = ''
      cp ${efiShell}/shellx64.efi /boot/
    '';
  };

  # Create Bootloader Entry
  # (Done by systemd?)
}
