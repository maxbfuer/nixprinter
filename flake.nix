{
  description = "Deployment for my Klipper-based 3D printing system.";

  # For accessing `deploy-rs`'s utility Nix functions
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    deploy-rs,
  }: {
    nixosConfigurations.nixprinter = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [./configuration.nix];
    };

    deploy.nodes.nixprinter = {
      hostname = "192.168.0.235";
      sshUser = "root";
      profiles.system = {
        user = "root";
        path = deploy-rs.lib.aarch64-linux.activate.nixos self.nixosConfigurations.nixprinter;
      };
    };

    # This is highly advised, and will prevent many possible mistakes
    checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
  };
}
