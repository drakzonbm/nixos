{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    openclaw-gateway
  ];

  systemd.tmpfiles.rules = [
    "d /home/drakzon/.openclaw-node 0700 drakzon users - -"
  ];

  systemd.services.openclaw-ssh-tunnel = {
    description = "OpenClaw SSH tunnel to Mac gateway";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    serviceConfig = {
      Type = "simple";
      User = "drakzon";
      WorkingDirectory = "/home/drakzon";
      Environment = [
        "HOME=/home/drakzon"
      ];
      ExecStart = ''
        ${pkgs.openssh}/bin/ssh -NT \
          -o BatchMode=yes \
          -o ExitOnForwardFailure=yes \
          -o ServerAliveInterval=30 \
          -o ServerAliveCountMax=3 \
          -o StrictHostKeyChecking=accept-new \
          -L 18789:127.0.0.1:18789 \
          brianmadl@192.168.1.200
      '';
      Restart = "always";
      RestartSec = 5;
    };
  };

  systemd.services.openclaw-node = {
    description = "OpenClaw node host";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" "openclaw-ssh-tunnel.service" ];
    wants = [ "network-online.target" ];
    requires = [ "openclaw-ssh-tunnel.service" ];
    serviceConfig = {
      Type = "simple";
      User = "drakzon";
      WorkingDirectory = "/home/drakzon";
      Environment = [
        "HOME=/home/drakzon"
        "OPENCLAW_STATE_DIR=/home/drakzon/.openclaw-node"
      ];
      ExecStart = "${pkgs.openclaw-gateway}/bin/openclaw node run --host 127.0.0.1 --port 18789 --display-name gaminglaptop";
      Restart = "always";
      RestartSec = 5;
    };
  };
}
