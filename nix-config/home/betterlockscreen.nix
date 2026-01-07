{
  pkgs,
  lib,
  inputs,
  config,
  ...
}:
{
  services.betterlockscreen = {
    enable = false;
  };

  # services.xscreensaver = {
  #   enable = false;
  #   settings = {
  #     mode = "blank";
  #     lock = false;
  #   };
  # };
}
