{ pkgs, lib, inputs, config, ...}: {
  services.pass-secret-service = {
    enable = true;
  };
}
