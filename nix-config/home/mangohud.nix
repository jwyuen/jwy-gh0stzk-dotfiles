{
  pkgs,
  config,
  inputs,
  ...
}:

{
  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
    settings = {
      full = true;
      toggle_hud = "End";
    };
  };
}
