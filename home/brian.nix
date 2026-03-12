{ pkgs, hostName, ... }:

let
  googleDotHackerCursor = pkgs.stdenvNoCC.mkDerivation {
    pname = "googledot-hacker-cursor";
    version = "2.0.0";
    src = ../assets/cursors/GoogleDot-Hacker;
    dontBuild = true;
    installPhase = ''
      runHook preInstall
      mkdir -p $out/share/icons/GoogleDot-Hacker
      cp -R ./* $out/share/icons/GoogleDot-Hacker/
      runHook postInstall
    '';
  };
in
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = [ "brave-browser.desktop" ];
      "x-scheme-handler/http" = [ "brave-browser.desktop" ];
      "x-scheme-handler/https" = [ "brave-browser.desktop" ];
      "x-scheme-handler/about" = [ "brave-browser.desktop" ];
      "x-scheme-handler/unknown" = [ "brave-browser.desktop" ];
    };
  };

  home.username = "drakzon";
  home.homeDirectory = "/home/drakzon";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  home.pointerCursor = {
    package = googleDotHackerCursor;
    name = "GoogleDot-Hacker";
    size = 36;
    gtk.enable = true;
    x11.enable = true;
  };

  home.sessionVariables = {
    XCURSOR_THEME = "GoogleDot-Hacker";
    XCURSOR_SIZE = "36";
  };

  programs.git = {
    enable = true;
    userName = if hostName == "gaminglaptop" then "drakzon" else null;
    userEmail = if hostName == "gaminglaptop" then "drakzonbm@gmail.com" else null;
  };
  programs.zsh.enable = true;

  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "warp-terminal";
      menu = "wofi --show drun";
      output = if hostName == "gaminglaptop" then {
        "HDMI-A-1" = {
          bg = "#1e1e2e solid_color";
          mode = "3840x2160";
          scale = "1.25";
          pos = "0 0";
        };
        "eDP-1" = {
          bg = "#1e1e2e solid_color";
          mode = "3840x2400@120Hz";
          scale = "1.25";
          pos = "0 1728";
        };
      } else {
        "*" = {
          bg = "#1e1e2e solid_color";
        };
      };
      bars = [ ];
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
        "${mod}+Left" = "focus left";
        "${mod}+Down" = "focus down";
        "${mod}+Up" = "focus up";
        "${mod}+Right" = "focus right";
        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Down" = "move down";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Right" = "move right";
        "${mod}+r" = "mode resize";
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

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 34;
        spacing = 8;
        modules-left = [ "sway/workspaces" "sway/window" ];
        modules-center = [ "clock" ];
        modules-right = [ "pulseaudio" "network" "bluetooth" "cpu" "memory" "battery" "tray" ];

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = false;
          format = "{name}";
        };

        "sway/window" = {
          max-length = 60;
          separate-outputs = true;
        };

        clock = {
          format = "  {:%a %b %d  %I:%M %p}";
          tooltip-format = "{:%A, %B %d, %Y | %I:%M:%S %p}";
        };

        pulseaudio = {
          format = "{icon}  {volume}%";
          format-muted = "󰖁  muted";
          format-icons = {
            default = [ "" "" "" ];
          };
          on-click = "pavucontrol";
        };

        network = {
          format-wifi = "󰖩  {essid}";
          format-ethernet = "󰈀  wired";
          format-disconnected = "󰖪  offline";
          tooltip-format = "{ifname} via {gwaddr}";
        };

        bluetooth = {
          format = "  on";
          format-disabled = "  off";
          format-connected = "  {num_connections}";
          tooltip-format = "{controller_alias}\t{controller_address}";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}";
          on-click = "blueman-manager";
        };

        cpu = {
          format = "  {usage}%";
          interval = 3;
        };

        memory = {
          format = "  {}%";
          interval = 5;
        };

        battery = {
          format = "{icon}  {capacity}%";
          format-charging = "󰂄  {capacity}%";
          format-plugged = "󱘖  {capacity}%";
          format-icons = [ "󰂎" "󰁺" "󰁼" "󰁾" "󰂀" "󰂂" "󰁹" ];
          states = {
            warning = 30;
            critical = 15;
          };
        };

        tray = {
          spacing = 10;
        };
      };
    };
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrainsMono Nerd Font", "Font Awesome 6 Free", sans-serif;
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: rgba(17, 17, 27, 0.88);
        color: #cdd6f4;
        border-bottom: 1px solid rgba(137, 180, 250, 0.22);
      }

      tooltip {
        background: #11111b;
        border: 1px solid #89b4fa;
        border-radius: 10px;
      }

      #workspaces {
        margin: 6px 0 6px 10px;
      }

      #workspaces button {
        padding: 0 10px;
        margin: 0 4px;
        color: #bac2de;
        background: transparent;
        border-radius: 10px;
      }

      #workspaces button:hover {
        background: rgba(137, 180, 250, 0.16);
        color: #cdd6f4;
      }

      #workspaces button.focused {
        background: linear-gradient(180deg, #89b4fa, #74c7ec);
        color: #11111b;
      }

      #window {
        color: #a6adc8;
        margin-left: 8px;
        font-weight: 600;
      }

      #clock,
      #pulseaudio,
      #network,
      #bluetooth,
      #cpu,
      #memory,
      #battery,
      #tray {
        margin: 6px 6px;
        padding: 0 12px;
        border-radius: 10px;
        background: rgba(49, 50, 68, 0.9);
      }

      #clock {
        background: linear-gradient(180deg, #cba6f7, #89b4fa);
        color: #11111b;
        font-weight: 700;
      }

      #battery.warning {
        color: #f9e2af;
      }

      #battery.critical {
        color: #f38ba8;
      }

      #pulseaudio.muted,
      #network.disconnected,
      #bluetooth.disabled {
        color: #f38ba8;
      }

      #tray {
        margin-right: 10px;
      }
    '';
  };

  services.mako.enable = true;

  home.packages = with pkgs; [
    wl-clipboard
    grim
    slurp
    vscode
    clickup
    notion-app-enhanced
    nomachine-client
    teams-for-linux
  ];
}
