{ pkgs, ... }:

{
  boot.supportedFilesystems = [ "btrfs" ];

  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
  };

  services.snapper = {
    snapshotInterval = "hourly";
    cleanupInterval = "1d";
    configs = {
      root = {
        SUBVOLUME = "/";
        ALLOW_USERS = [ "drakzon" ];
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;
        NUMBER_CLEANUP = true;
        TIMELINE_LIMIT_HOURLY = 24;
        TIMELINE_LIMIT_DAILY = 14;
        TIMELINE_LIMIT_WEEKLY = 8;
        TIMELINE_LIMIT_MONTHLY = 6;
        TIMELINE_LIMIT_YEARLY = 2;
      };

      home = {
        SUBVOLUME = "/home";
        ALLOW_USERS = [ "drakzon" ];
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;
        NUMBER_CLEANUP = true;
        TIMELINE_LIMIT_HOURLY = 12;
        TIMELINE_LIMIT_DAILY = 10;
        TIMELINE_LIMIT_WEEKLY = 6;
        TIMELINE_LIMIT_MONTHLY = 4;
        TIMELINE_LIMIT_YEARLY = 1;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    btrfs-progs
    snapper
    inotify-tools
  ];
}
