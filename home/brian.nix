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
      terminal = "kitty";
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
        "${mod}+Return" = "exec kitty";
        "${mod}+d" = "exec wofi --show drun";
        "${mod}+Shift+e" = "exec swaynag -t warning -m 'Exit Sway?' -B 'Yes' 'swaymsg exit'";
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
