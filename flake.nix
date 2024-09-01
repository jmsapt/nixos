{
  description = "test configuration";

  inputs = {
    # NixPkgs
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";

    # Sops-Nix (secrets)
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    # Nixos Hardware Modules
    hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = { self, nixpkgs, home-manager, sops-nix, ... } @ inputs: 
  let
    inherit (self) outputs;
  in {
    # System Configurations
    nixosConfigurations = {
      # Desktop PC (RTX 3070)
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};

        modules = [
          ./systems/desktop
        ];
      };

      # Thinkpad Laptop
      laptop = nixpkgs.lib.nixosSystem {
      };
    };
  };
}
