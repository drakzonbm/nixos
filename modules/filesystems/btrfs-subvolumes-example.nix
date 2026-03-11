{ ... }:

# Example mount layout for Timeshift-friendly btrfs subvolumes.
# Copy the relevant bits into each generated hardware-configuration.nix after install.
# Expected subvolumes:
#   @           -> /
#   @home       -> /home
#   @nix        -> /nix
#   @log        -> /var/log
#   @snapshots  -> /.snapshots
#
# Example fstab-style Nix snippet:
#
# fileSystems."/" = {
#   device = "/dev/disk/by-uuid/REPLACE_ME";
#   fsType = "btrfs";
#   options = [ "subvol=@" "compress=zstd:3" "noatime" ];
# };
#
# fileSystems."/home" = {
#   device = "/dev/disk/by-uuid/REPLACE_ME";
#   fsType = "btrfs";
#   options = [ "subvol=@home" "compress=zstd:3" "noatime" ];
# };
#
# fileSystems."/nix" = {
#   device = "/dev/disk/by-uuid/REPLACE_ME";
#   fsType = "btrfs";
#   options = [ "subvol=@nix" "compress=zstd:3" "noatime" ];
# };
#
# fileSystems."/var/log" = {
#   device = "/dev/disk/by-uuid/REPLACE_ME";
#   fsType = "btrfs";
#   options = [ "subvol=@log" "compress=zstd:3" "noatime" ];
# };
#
# fileSystems."/.snapshots" = {
#   device = "/dev/disk/by-uuid/REPLACE_ME";
#   fsType = "btrfs";
#   options = [ "subvol=@snapshots" "compress=zstd:3" "noatime" ];
# };
{
}
