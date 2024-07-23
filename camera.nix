{pkgs, ...}: {
  # add the following lines to config.txt in the boot partition:
  # start_x=1
  # gpu_mem=256

  boot.kernelModules = ["bcm2835_v4l2"];

  environment.systemPackages = with pkgs; [
    ustreamer
  ];

  systemd.services.ustreamer = {
    description = "Start the ustreamer web camera feed.";

    wantedBy = ["multi-user.target"];
    after = ["network.target"];

    # TODO: look into pi hardwaere encoding (m2m image?)
    serviceConfig = {
      Type = "simple";
      User = "root";
      ExecStart = ''${pkgs.ustreamer}/bin/ustreamer --host=0.0.0.0 --format=uyvy --workers=3 --persistent --drop-same-frames=30'';
    };
  };
}
