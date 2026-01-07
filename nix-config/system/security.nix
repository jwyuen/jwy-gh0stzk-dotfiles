_: {

  # Security

  services.gnome.gnome-keyring.enable = true;

  # TODO: set lock screen based on X or Wayland?
  security = {
    rtkit.enable = true;
    pam.services.sddm.enableGnomeKeyring = true;
    polkit = {
      enable = true;
      extraConfig = ''
        polkit.addRule(function(action, subject) {
          if ( subject.isInGroup("users") && (
           action.id == "org.freedesktop.login1.reboot" ||
           action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
           action.id == "org.freedesktop.login1.power-off" ||
           action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          ))
          { return polkit.Result.YES; }
        })
      '';
    };

    #pam.services.xscreensaver.enable = true;

    # i3lock required for betterlockscreen
    # security.pam.services.i3lock.enable = true;
    # security.pam.services.i3lock-color.enable = true;
    pam.services.betterlockscreen = {
      text = ''auth include login'';
    };

    pam.services.swaylock = {
      text = ''auth include login '';
    };
  };
}
