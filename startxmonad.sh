#! /bin/bash
trayer --edge top --align right --widthtype percent --width 10 --tint 0x000000 --height 19 --transparent true --alpha 0 &
nm-applet &
python /home/jiajun/Code/myprogram/goagent/local/goagent-gtk.py &
dropbox &

# autostartup apps before exec xmonad
exec xmonad
