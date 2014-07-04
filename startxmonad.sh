#! /bin/bash
trayer --edge top --align right --widthtype percent --width 15 --tint 0x000000 --height 19 --transparent true --alpha 0 &
compton &
xfce4-power-manager &
nm-applet &
sogou-qimpanel &
python /home/jiajun/Code/tools/goagent/local/goagent-gtk.py &
goldendict &
dropbox start &

# autostartup apps before exec xmonad
exec xmonad
