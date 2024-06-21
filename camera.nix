{pkgs, ...}: {
  # add the following lines to config.txt in the boot partition:
  # start_x=1
  # gpu_mem=256

  boot.kernelModules = ["bcm2835_v4l2"];

  environment.systemPackages = with pkgs; [
    ustreamer
  ];
}
