{pkgs, ...}: {
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;

  users.mutableUsers = false;
  users.users.root.initialHashedPassword = "$y$j9T$kTpSxMxSbaO84wuy6HIUA/$1fR8Z1oTppnFy1N8yAmBeWTE1k5EN5TWhPV6tWyIAH1";

  time.timeZone = "America/Los_Angeles";

  networking = {
    hostName = "nixprinter";
    wireless = {
      enable = true;
      networks = {
        "Sanctuary III" = {
          pskRaw = "e8c6e609ecd870d69e534446c1813bfa5a6be6cd7efd6a53478abdecd14682de";
        };
      };
    };
    interfaces.wlan0.macAddress = "B8:27:EB:D1:7F:57";
    firewall.enable = false;
  };

  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB2k3WeqkyHUY3vygNutroKxFyPmzLe1n9u4SATRc1Kx max@gaia"
  ];

  environment.systemPackages = with pkgs; [
    libraspberrypi
    git
    neovim
    htop
  ];

  # Use a 4G swap file
  swapDevices = [
    {
      device = "/swapfile";
      size = 4096;
    }
  ];

  zramSwap = {
    enable = true;
    memoryPercent = 80;
    algorithm = "zstd";
  };

  # zstd compression is enabled by default
  # I could potentially use volatile storage to avoid read/writes on microsd, but won't for now
  # this will clear old journal files when more than 300M is used
  services.journald.extraConfig = ''
    [Journal]
    SystemMaxUse=300M
  '';

  system.stateVersion = "24.05";
}
