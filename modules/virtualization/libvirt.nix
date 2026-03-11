{ pkgs, ... }:

{
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "drakzon" ];
  environment.systemPackages = with pkgs; [
    virt-viewer
    dnsmasq
  ];
}
