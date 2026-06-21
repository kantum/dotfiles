{
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = ["${modulesPath}/virtualisation/qemu-vm.nix"];
  virtualisation = {
    cores = 6;
    memorySize = 8 * 1024;
    diskSize = 16 * 1024;
    forwardPorts = [
      {
        from = "host";
        host.port = 4222;
        guest.port = 22;
      }
    ];
    writableStoreUseTmpfs = false;
    graphics = true;
    qemu.guestAgent.enable = true;
    qemu.options = [
      "-display cocoa"
      "-full-screen"
    ];
  };
  nixpkgs.hostPlatform = "aarch64-linux";
  system.stateVersion = "25.05";
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = ["/dev/vda"];
  fileSystems."/" = {
    device = "/dev/vda1";
    fsType = "ext4";
  };
  networking.hostName = "linux-vm";
  networking.useDHCP = true;
  programs.zsh.enable = true;

  users.users.kantum = {
    isNormalUser = true;
    home = "/home/kantum";
    shell = pkgs.zsh;
    extraGroups = ["wheel"];
  };
  security.sudo.wheelNeedsPassword = false;
  services = {
    openssh.enable = true;
    qemuGuest.enable = true;
    greetd = {
      enable = true;
      settings = {
        default_session = {
          user = "kantum";
          command = "${pkgs.hyprland}/bin/start-hyprland";
        };
      };
    };
  };
}
