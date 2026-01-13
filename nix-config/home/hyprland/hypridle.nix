{ ... }:
{
  services = {
    hypridle = {
      enable = true;
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          lock_cmd = "hyprlock";
        };
        listener = [
          {
            timeout = 120;
            on-timeout = "hyprlock";
            #on-timeout = "xscreensaver";
          }
          # {
          #   timeout = 1200; # 20 min
          #   on-timeout = "hyprctl dispatch dpms off";
          #   on-resume = "hyprctl dispatch dpms on";
          # }
        ];
      };
    };
  };
}
