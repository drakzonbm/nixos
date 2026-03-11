{ pkgs, ... }:

{
  users.users.drakzon = {
    isNormalUser = true;
    description = "Brian";
    initialPassword = "wippDragonzz@78";
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
      "libvirtd"
      "audio"
      "video"
      "input"
    ];
    shell = pkgs.zsh;
  };
}
