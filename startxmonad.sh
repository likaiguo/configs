#! /bin/bash
trayer --edge top --align right --widthtype percent --width 10 --tint 0x000000 --height 19 --transparent true --alpha 0 & # spawn trayer
syndaemon -i 1 & # touchpad
python /home/jiajun/Code/tools/goagent/local/goagent-gtk.py & # GFW
compton &
# Fire up apps
gnome-screensaver &
sogou-qimpanel &
goldendict &

# start laptop's network manager
if [ -x /usr/bin/nm-applet ] ; then
  nm-applet &
fi

# start xmonad
exec xmonad
