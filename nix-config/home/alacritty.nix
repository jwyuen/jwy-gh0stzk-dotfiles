{
  pkgs,
  config,
  lib,
  host,
  ...
}:

let
  palette = config.colorScheme.palette;
  inherit (import ../hosts/${host}/options.nix) alacritty x11ScaleFactor;
in
lib.mkIf (alacritty == true) {
  programs.alacritty = {
    enable = true;
    settings = {
      general = {
        import = [
          "~/.config/alacritty/rice-colors.toml"
          "~/.config/alacritty/fonts.toml"
        ];
        live_config_reload = true;
      };
      cursor = {
        style = {
          shape = "Beam";
          blinking = "On";
        };
        blink_interval = 550;
        unfocused_hollow = false;
        thickness = 0.15;
      };
      env = {
        WINIT_X11_SCALE_FACTOR = x11ScaleFactor;
        TERM = "xterm-256color";
      };
      keyboard.bindings = [
        {
          key = "0";
          mods = "Control";
          action = "ReceiveChar";
        }
      ];
      selection = {
        save_to_clipboard = true;
      };
      scrolling = {
        history = 10000;
        multiplier = 3;
      };
      window = {
        decorations = "none";
        dynamic_title = true;
        dynamic_padding = true;
        padding.x = 5;
        padding.y = 5;
        opacity = 1;
      };
    };
  };
}
