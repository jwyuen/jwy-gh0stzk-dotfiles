{ pkgs, lib, inputs, config, ...}: {
  services.betterlockscreen = {
    enable = true;
  };
}
