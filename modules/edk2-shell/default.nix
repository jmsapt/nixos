# Enables EFI shell
{config, input, pkgs, lib, ...}:
let
  # Define EFI Shell
  efiShellx86_64 = pkgs.stdenv.mkDerivation {
    pname = "efi-shell-x86_64";
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
  environment.systemPackages =  [ efiShellx86_64 ];
  system.activationScripts.installEfiShell = { text = "cp ${efiShellx86_64}/shellx64.efi /boot/"; };
}
