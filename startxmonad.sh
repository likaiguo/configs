#! /bin/bash
trayer --edge top --align right --widthtype percent --width 10 --tint 0x000000 --height 19 --transparent true --alpha 0 &
xfce4-power-manager &
nm-applet &
fcitx-qimpanel &
python /home/jiajun/Code/tools/goagent/local/goagent-gtk.py &
dropbox start &

# autostartup apps before exec xmonad
exec xmonad
