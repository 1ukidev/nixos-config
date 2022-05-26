{
  home = {
    file.".config/i3/config".text = ''
      # i3 config - 1ukidev

      set $mod Mod4

      # set font for window titles.
      font pango:monospace 9

      # use pactl to adjust volume in PulseAudio.
      set $refresh_i3status killall -SIGUSR1 i3status
      bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +2% && $refresh_i3status
      bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -2% && $refresh_i3status
      bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && $refresh_i3status
      bindsym XF86AudioMicMute exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle && $refresh_i3status

      # use Mouse+$mod to drag floating windows to their wanted position
      floating_modifier $mod

      # start a terminal
      bindsym $mod+Return exec kitty 

      # kill focused window
      bindsym $mod+c kill

      # start rofi (a program launcher)
      bindsym $mod+d exec rofi -show drun

      # change focus
      bindsym $mod+j focus left
      bindsym $mod+k focus down
      bindsym $mod+l focus up
      bindsym $mod+ccedilla focus right

      # alternatively, you can use the cursor keys:
      bindsym $mod+Left focus left
      bindsym $mod+Down focus down
      bindsym $mod+Up focus up
      bindsym $mod+Right focus right

      # move focused window
      bindsym $mod+Shift+j move left
      bindsym $mod+Shift+k move down
      bindsym $mod+Shift+l move up
      bindsym $mod+Shift+ccedilla move right

      # alternatively, you can use the cursor keys:
      bindsym $mod+Shift+Left move left
      bindsym $mod+Shift+Down move down
      bindsym $mod+Shift+Up move up
      bindsym $mod+Shift+Right move right

      # split in horizontal orientation
      bindsym $mod+h split h

      # split in vertical orientation
      bindsym $mod+v split v

      # enter fullscreen mode for the focused container
      bindsym $mod+f fullscreen toggle

      # change container layout (stacked, tabbed, toggle split)
      bindsym $mod+s layout stacking
      bindsym $mod+w layout tabbed
      bindsym $mod+e layout toggle split

      # toggle tiling / floating
      bindsym $mod+space floating toggle

      # change focus between tiling / floating windows
      bindsym $mod+Shift+space focus mode_toggle

      # focus the parent container
      bindsym $mod+a focus parent

      # focus the child container
      # bindsym $mod+d focus child

      # Define names for default workspaces for which we configure key bindings later on.
      # We use variables to avoid repeating the names in multiple places.
      set $ws1 "1"
      set $ws2 "2"
      set $ws3 "3"
      set $ws4 "4"
      set $ws5 "5"
      set $ws6 "6"
      set $ws7 "7"
      set $ws8 "8"
      set $ws9 "9"
      set $ws10 "10"

      # switch to workspace
      bindsym $mod+1 workspace number $ws1
      bindsym $mod+2 workspace number $ws2
      bindsym $mod+3 workspace number $ws3
      bindsym $mod+4 workspace number $ws4
      bindsym $mod+5 workspace number $ws5
      bindsym $mod+6 workspace number $ws6
      bindsym $mod+7 workspace number $ws7
      bindsym $mod+8 workspace number $ws8
      bindsym $mod+9 workspace number $ws9
      bindsym $mod+0 workspace number $ws10

      # move focused container to workspace
      bindsym $mod+Shift+1 move container to workspace number $ws1
      bindsym $mod+Shift+2 move container to workspace number $ws2
      bindsym $mod+Shift+3 move container to workspace number $ws3
      bindsym $mod+Shift+4 move container to workspace number $ws4
      bindsym $mod+Shift+5 move container to workspace number $ws5
      bindsym $mod+Shift+6 move container to workspace number $ws6
      bindsym $mod+Shift+7 move container to workspace number $ws7
      bindsym $mod+Shift+8 move container to workspace number $ws8
      bindsym $mod+Shift+9 move container to workspace number $ws9
      bindsym $mod+Shift+0 move container to workspace number $ws10

      # reload the configuration file
      bindsym $mod+Shift+c reload
      # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
      bindsym $mod+Shift+r restart
      # powermenu
      bindsym $mod+x exec i3-nagbar -t warning -m "" -B "Poweroff" "poweroff" -B "Reboot" "reboot" -B "Exit i3" "i3-msg exit"

      # resize window (you can also use the mouse for that)
      mode "resize" {
              # These bindings trigger as soon as you enter the resize mode

              # Pressing left will shrink the window’s width.
              # Pressing right will grow the window’s width.
              # Pressing up will shrink the window’s height.
              # Pressing down will grow the window’s height.
              bindsym j resize shrink width 10 px or 10 ppt
              bindsym k resize grow height 10 px or 10 ppt
              bindsym l resize shrink height 10 px or 10 ppt
              bindsym ccedilla resize grow width 10 px or 10 ppt

              # same bindings, but for the arrow keys
              bindsym Left resize shrink width 10 px or 10 ppt
              bindsym Down resize grow height 10 px or 10 ppt
              bindsym Up resize shrink height 10 px or 10 ppt
              bindsym Right resize grow width 10 px or 10 ppt

              # back to normal: Enter or Escape or $mod+r
              bindsym Return mode "default"
              bindsym Escape mode "default"
              bindsym $mod+r mode "default"
      }

      bindsym $mod+r mode "resize"

      # colors
      # class                 border  bground text    indicator child_border
      client.focused          #6272A4 #6272A4 #F8F8F2 #F8F8F2   #F8F8F2
      client.focused_inactive #44475A #44475A #F8F8F2 #44475A   #44475A
      client.unfocused        #282A36 #282A36 #BFBFBF #282A36   #282A36
      client.urgent           #44475A #FF5555 #F8F8F2 #FF5555   #FF5555
      client.placeholder      #282A36 #282A36 #F8F8F2 #282A36   #282A36
      client.background       #F8F8F2

      # bc
      bindsym $mod+b exec kitty -e bc --quiet

      # polybar
      # exec --no-startup-id ~/.config/polybar/launch.sh --material
      bindsym $mod+Shift+p exec --no-startup-id pkill polybar
      bindsym $mod+Shift+o exec --no-startup-id ~/.config/polybar/launch.sh --material

      # mouse sensitivity
      # exec --no-startup-id xinput set-prop "Logitech Wireless Mouse" "Coordinate Transformation Matrix" 0.8 0 0 0 0.8 0 0 0 1

      # hide mouse
      exec --no-startup-id xbanish

      # keynav
      exec --no-startup-id keynav

      # dunst
      exec --no-startup-id dunst

      # wallpaper
      exec --no-startup-id nitrogen --restore

      # fix monitor
      # exec --no-startup-id xrandr --output HDMI-1 --set "Broadcast RGB" "Full"
      # exec --no-startup-id xrandr --output eDP-1 --right-of HDMI-1

      # suspend
      bindsym $mod+Shift+s exec --no-startup-id systemctl suspend

      # compositor
      exec --no-startup-id picom --experimental-backends --backend glx --vsync
      bindsym $mod+Shift+u exec --no-startup-id picom --experimental-backends --backend glx --vsync
      bindsym $mod+Shift+i exec --no-startup-id pkill picom

      # protonvpn
      bindsym $mod+Shift+f exec --no-startup-id gksudo "protonvpn c -f"
      bindsym $mod+Shift+d exec --no-startup-id gksudo "protonvpn d"

      # i3lock
      #bindsym $mod+Shift+y exec --no-startup-id i3lock -i ~/Imagens/Pictures/1.jpg
      bindsym $mod+Shift+y exec --no-startup-id i3lock -i ~/Imagens/Wallpapers/1.jpg

      # power manager
      exec --no-startup-id xfce4-power-manager

      # border
      for_window [class="^.*"] border pixel 4
      new_window 1pixel

      # change container layout
      # workspace_layout tabbed

      # i3-gaps
      gaps inner 8
      gaps outer 8
    ''; 
  };
}
