{...}: {
  services = {
    klipper = {
      enable = true;
      configFile = ./klipper/neptune3plus.cfg;
    };

    moonraker = {
      user = "root";
      enable = true;
      address = "0.0.0.0";
      settings = {
        octoprint_compat = {};
        history = {};
        authorization = {
          force_logins = true;
          cors_domains = [
            "*.local"
            "*.lan"
            "*://app.fluidd.xyz"
            "*://my.mainsail.xyz"
          ];
          trusted_clients = [
            "10.0.0.0/8"
            "127.0.0.0/8"
            "169.254.0.0/16"
            "172.16.0.0/12"
            "192.168.0.0/24"
            "FE80::/10"
            "::1/128"
          ];
        };
      };
    };

    mainsail = {
      enable = true;
    };
    # allow for larger gcode uploads to mainsail
    nginx.clientMaxBodySize = "1000m";
  };
  # moonraker wants polkit
  security.polkit.enable = true;
}
