{
  description = "Deployment for my Klipper-based 3D printing system.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };

  outputs = {
    self,
    nixpkgs,
  }: {
    nixosConfigurations.nixprinter = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [./configuration.nix];
    };
  };
}
