{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # TODO: swapfile

  # TODO: remove this?
  nixpkgs.buildPlatform.system = "x86_64-linux";
  nixpkgs.hostPlatform.system = "aarch64-linux";

  users.mutableUsers = false;
  users.users.root.initialHashedPassword = "$y$j9T$kTpSxMxSbaO84wuy6HIUA/$1fR8Z1oTppnFy1N8yAmBeWTE1k5EN5TWhPV6tWyIAH1";

  # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;

  networking.hostName = "nixprinter";
  networking.wireless = {
    enable = true;
    networks = {
      "Sanctuary III" = {
        pskRaw = "e8c6e609ecd870d69e534446c1813bfa5a6be6cd7efd6a53478abdecd14682de";
      };
    };
  };

  services.openssh = {
    enable = true;
    # settings.PermitRootLogin = "yes";
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB2k3WeqkyHUY3vygNutroKxFyPmzLe1n9u4SATRc1Kx max@gaia"
  ];

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "24.05";
}
