{pkgs, ...}: {
  programs.rofi.enable = true;
  programs.kitty.enable = true;
  services.wayle = {
    enable = true;
    autoInstallDependencies = true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    settings = {
      "$mod" = "SUPER";

      debug.disable_logs = false;
      bind = [
        "$mod, Super_L, exec, pkill rofi || rofi -show drun"
        "$mod, F, exec, firefox"
        "CONTROL ALT, T, exec, ghostty"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];
    };
  };
}
