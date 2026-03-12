{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    brave
    gh
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
