#! /bin/bash
trayer --edge top --align right --widthtype percent --width 10 --tint 0x000000 --height 19 --transparent true --alpha 0 & # spawn trayer
compton & 
syndaemon -i 1 & # touchpad
sogou-qimpanel & # inputmethod
python /home/jiajun/Code/tools/goagent/local/goagent-gtk.py & # GFW

# Fire up apps
gnome-screensaver&

#goldendict &
#dropbox start &

#start laptop's network manager
if [ -x /usr/bin/nm-applet  ] ; then
  nm-applet --sm-disable &
fi

# start xmonad
exec xmonad
