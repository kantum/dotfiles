{self, pkgs, ...}: {
  imports = [
    "${self}/modules/home/hyprland.nix"
  ];
}
