{
  username,
  ...
}:
{
  # Home Manager Settings
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.11";

  # Import Program Configurations
  imports = [
    ./nix-config/home
  ];

  programs.home-manager.enable = true;
}
