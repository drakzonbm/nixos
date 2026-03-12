{ pkgs, hostName, ... }:

{
  home.username = "drakzon";
  home.homeDirectory = "/home/drakzon";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
  programs.git.enable = true;
  programs.zsh.enable = true;

  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "warp-terminal";
      menu = "wofi --show drun";
      output = {
        "*" = {
          bg = "#1e1e2e solid_color";
        };
      };
      startup = [
        { command = "waybar"; }
        { command = "mako"; }
        { command = "nm-applet"; }
      ];
      keybindings = let
        mod = "Mod4";
      in {
        "${mod}+Return" = "exec warp-terminal";
        "${mod}+d" = "exec wofi --show drun";
        "${mod}+1" = "workspace number 1";
        "${mod}+2" = "workspace number 2";
        "${mod}+3" = "workspace number 3";
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace number 5";
        "${mod}+6" = "workspace number 6";
        "${mod}+7" = "workspace number 7";
        "${mod}+8" = "workspace number 8";
        "${mod}+9" = "workspace number 9";
        "${mod}+Shift+1" = "move container to workspace number 1";
        "${mod}+Shift+2" = "move container to workspace number 2";
        "${mod}+Shift+3" = "move container to workspace number 3";
        "${mod}+Shift+4" = "move container to workspace number 4";
        "${mod}+Shift+5" = "move container to workspace number 5";
        "${mod}+Shift+6" = "move container to workspace number 6";
        "${mod}+Shift+7" = "move container to workspace number 7";
        "${mod}+Shift+8" = "move container to workspace number 8";
        "${mod}+Shift+9" = "move container to workspace number 9";
        "${mod}+Shift+q" = "kill";
        "${mod}+Shift+e" = "exec swaynag -t warning -m 'Exit Sway?' -B 'Yes' 'swaymsg exit'";
      };
      modes = {
        resize = {
          Left = "resize shrink width 2 px";
          Down = "resize grow height 2 px";
          Up = "resize shrink height 2 px";
          Right = "resize grow width 2 px";
          h = "resize shrink width 2 px";
          j = "resize grow height 2 px";
          k = "resize shrink height 2 px";
          l = "resize grow width 2 px";
          Return = "mode default";
          Escape = "mode default";
        };
      };
    };
  };

  programs.waybar.enable = true;
  services.mako.enable = true;

  home.packages = with pkgs; [
    wl-clipboard
    grim
    slurp
    firefox
    vscode
  ];
}
