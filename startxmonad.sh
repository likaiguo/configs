#! /bin/bash
trayer --edge top --align right --widthtype percent --width 10 --tint 0x000000 --height 19 --transparent true --alpha 0 &
nm-applet &
<<<<<<< HEAD
python /home/jiajun/Code/tools/goagent/local/goagent-gtk.py &
=======
python /home/jiajun/Code/myprogram/goagent/local/goagent-gtk.py &
dropbox &
>>>>>>> c093d419afc2a877996ae80afe18a837af566cb6

# autostartup apps before exec xmonad
exec xmonad
