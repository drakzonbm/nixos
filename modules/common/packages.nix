{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    brave
    git-credential-manager
    docker-compose
    virt-manager
    qemu
    spice-gtk
    swaybg
    swaylock
    swayidle
    mako
    fzf
    fastfetch
  ];
}
