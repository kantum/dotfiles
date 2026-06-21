{
  pkgs,
  lib,
  ...
}: {
  programs = {
    aerospace = {
      enable = true;
      launchd.enable = true;
      settings = {
        gaps = {
          inner.horizontal = 4;
          inner.vertical = 4;
          outer.left = 4;
          outer.bottom = 4;
          outer.top = 4;
          outer.right = 4;
        };
        start-at-login = true;
        mode.main.binding = {
          cmd-alt-slash = "layout tiles horizontal vertical";
          cmd-alt-comma = "layout accordion horizontal vertical";

          cmd-alt-j = "focus left";
          cmd-alt-k = "focus down";
          cmd-alt-l = "focus up";
          cmd-alt-semicolon = "focus right";

          cmd-alt-shift-j = "move left";
          cmd-alt-shift-k = "move down";
          cmd-alt-shift-l = "move up";
          cmd-alt-shift-semicolon = "move right";

          cmd-alt-a = "workspace 1";
          cmd-alt-s = "workspace 2";
          cmd-alt-d = "workspace 3";
          cmd-alt-f = "workspace 4";
          cmd-alt-g = "workspace 5";
          cmd-alt-z = "workspace 6";
          cmd-alt-x = "workspace 7";
          cmd-alt-c = "workspace 8";
          cmd-alt-v = "workspace 9";
          cmd-alt-b = "workspace 10";

          cmd-alt-shift-a = "move-node-to-workspace 1";
          cmd-alt-shift-s = "move-node-to-workspace 2";
          cmd-alt-shift-d = "move-node-to-workspace 3";
          cmd-alt-shift-f = "move-node-to-workspace 4";
          cmd-alt-shift-g = "move-node-to-workspace 5";
          cmd-alt-shift-z = "move-node-to-workspace 6";
          cmd-alt-shift-x = "move-node-to-workspace 7";
          cmd-alt-shift-c = "move-node-to-workspace 8";
          cmd-alt-shift-v = "move-node-to-workspace 9";
          cmd-alt-shift-b = "move-node-to-workspace 10";
        };

        on-window-detected = [
          {
            "if" = {
              app-id = "com.mitchellh.ghostty";
            };
            run = "move-node-to-workspace 1";
          }
          {
            "if" = {
              app-id = "org.mozilla.firefox";
            };
            run = "move-node-to-workspace 2";
          }
          {
            "if" = {
              app-id = "com.openai.chat";
            };
            run = "move-node-to-workspace 3";
          }
          {
            "if" = {
              app-id = "com.hnc.Discord";
            };
            run = "move-node-to-workspace 4";
          }
          {
            "if" = {
              app-id = "com.apple.MobileSMS";
            };
            run = "move-node-to-workspace 4";
          }
          {
            "if" = {
              app-id = "com.spotify.client";
            };
            run = "move-node-to-workspace 5";
          }
        ];
      };
    };
    ghostty.package = pkgs.ghostty-bin;
  };

  home.activation.setFileAssociation = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ${pkgs.duti}/bin/duti ~/.duti.conf
  '';
  home.file = {
    ".duti.conf".text = ''
      org.nixos.thunderbird mailto
    '';
  };
}
