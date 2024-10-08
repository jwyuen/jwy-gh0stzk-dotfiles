{ pkgs, config, lib, host, ... }:

let inherit (import ../hosts/${host}/options.nix) syncthing username userHome; in
lib.mkIf (syncthing == true) {
  services = {
    syncthing = {
    enable = true;
    user = "${username}";
    dataDir = "/home/${username}";    # Default folder for new synced folders
    configDir = "/home/${username}/.config/syncthing";   # Folder for Syncthing's settings and keys
    };
  };

  # Syncthing ports: 8384 for remote access to GUI
  # 22000 TCP and/or UDP for sync traffic
  # 21027/UDP for discovery
  # source: https://docs.syncthing.net/users/firewall.html
  # these are opened on the firewall in system.nix
}
