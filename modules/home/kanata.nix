{pkgs, ...}: {
  home.packages = with self.pkgs; [
    kanata
  ];

  systemd.user.services.kanata = {
    description = "Kanata user service";
    wantedBy = ["default.target"];
    serviceConfig = {
      ExecStart = "${self.pkgs.kanata}/bin/kanata --serve";
      Restart = "on-failure";
      RestartSec = "5";
    };
  };
}
