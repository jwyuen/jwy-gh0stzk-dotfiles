{ pkgs, config, lib, ... }:

{
  # OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
