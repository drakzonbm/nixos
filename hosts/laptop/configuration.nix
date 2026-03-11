{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common/base.nix
    ../../modules/common/packages.nix
    ../../modules/filesystems/btrfs.nix
    ../../modules/nvidia/default.nix
    ../../modules/desktop/daily-driver.nix
    ../../modules/virtualization/docker.nix
    ../../modules/virtualization/libvirt.nix
    ../../modules/users/main-user.nix
  ];

  networking.hostName = "laptop";
}
