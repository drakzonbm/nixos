{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
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
