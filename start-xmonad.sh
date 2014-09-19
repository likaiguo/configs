#!/bin/bash
# 
# xmonad startup script. Intended to be run from an xsession configuration
# to run xmonad and some associated programs.
# 
# Author: David Brewer
# Repository: https://github.com/davidbrewer/xmonad-ubuntu-conf

#
# GENERAL INITIALIZATION
#

# Identify the home of our gtkrc file, important for setting styles of 
# gtk-based applications
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# Load X resources (fixes some font issues)
# RYAN: will remove -merge flag if I need to to fix xterm color settings.
xrdb .Xresources

# Start compositing to support transparency. You can omit this
# if you prefer not to use any transparency, but it is likely to cause
# ugly black fringing with some programs such as synapse that expect
# transparency support.
xcompmgr -n &


#
# SCREEN CONFIGURATION
#

# We handle our screen configuration using xrandr. You are likely to want to 
# edit this section to match the specific demands of your setup. The below
# setup is for a Lenovo W520 laptop that sometimes has an external monitor
# hooked up via either VGA or DVI, positioned to the left of the laptop.
#
# Note that you can run xrandr at the command line to get a list of your
# connected screens and find out what names you should use to refer to them.

# Activate primary screen 
#xrandr --output LVDS-1 --auto --primary

# If we find that a screen is connected via VGA, activate it and position it
# to the left of the primary screen.
#xrandr | grep 'VGA-1 connected' | ifne xrandr --output VGA-1 --auto --right-of LVDS-1

# If we find that a screen is connected via DVI, activate it and position it
# to the left of the primary screen.
#xrandr | grep 'DP-1 connected' | ifne xrandr --output DP-1 --auto --right-of LVDS-1

#
# STARTUP ICON TRAY
#
# spawn trayer
trayer --edge top --align right --widthtype percent --width 10 --tint 0x000000 --height 19 --transparent true --alpha 0 &
# We are using stalonetray to create a small icon tray at the
# top right of the screen. You are likely to want to tweak the
# size of the icons and the width of the tray based upon the
# size of your screen and your xmobar configuration. The goal is
# to make stalonetray look like it is part of xmobar.
# 
# Line by line, the options used by default below mean:
# - icons should be aligned with the "East" or right side of the tray
# - the width of the tray should be 5 icons wide by one icon tall, and it 
#   should be located 0 pixels from the right of the screen (-0) and 0 pixels
#   from the top of the screen (+0).
# - By setting our maximum geometry to the same thing, the tray will not grow.
# - The background color of the tray should be black.
# - This program should not show up in any taskbar.
# - Icons should be set to size "24".
# - Kludges argument of "force_icons_size" forces all icons to really, truly 
#   be the size we set.
# - window-strut "none" means windows are allowed to cover the tray. In
#   other words, trust xmonad to handle this part.
#

# Solarized colors:
# NAME:     HEX:         TERMNAME:    256HEX: NOTE:
# base03    #002b36  8/4 brblack  234 #1c1c1c dark bg
# base02    #073642  0/4 black    235 #262626 dark bg highlights
# base01    #586e75 10/7 brgreen  240 #585858 dark comments, light emphasized content
# base00    #657b83 11/7 bryellow 241 #626262 light fg
# base0     #839496 12/6 brblue   244 #808080 dark fg
# base1     #93a1a1 14/4 brcyan   245 #8a8a8a dark emphasized content, light comments
# base2     #eee8d5  7/7 white    254 #e4e4e4 light fg highlights
# base3     #fdf6e3 15/7 brwhite  230 #ffffd7 light bg
# yellow    #b58900  3/3 yellow   136 #af8700
# orange    #cb4b16  9/3 brred    166 #d75f00
# red       #dc322f  1/1 red      160 #d70000
# magenta   #d33682  5/5 magenta  125 #af005f
# violet    #6c71c4 13/5 brmagenta 61 #5f5faf
# blue      #268bd2  4/4 blue      33 #0087ff
# cyan      #2aa198  6/6 cyan      37 #00afaf
# green     #859900  2/2 green     64 #5f8700
 

stalonetray \
  --icon-gravity E \
  --grow-gravity W \
  --geometry 5x1-0+0 \
  --max-geometry 8x1-0+0 \
  --background '#002b36' \
  --skip-taskbar \
  --icon-size 22 \
  --kludges force_icons_size \
  --window-strut none \
&

# Run the gnome-keyring-daemon to avoid issues you otherwise may encounter
# when using gnome applications which expect access to the keyring, such
# as Empathy. This prevents prompts you may otherwise get for invalid
# certificates and the like.
gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh

# Remap caps lock to left control. This is not strictly speaking
# xmonad related, but it's handy if you're a vim user.
setxkbmap -option 'ctrl:nocaps'

# Run chinese-input-method sogou-qimpanel (it depends on fcitx)
sogou-qimpanel &

# Network manager, so we don't have to configure wifi at the command line.
if [ -z "$(pgrep nm-applet)" ] ; then
    /usr/bin/nm-applet --sm-disable &
fi

# Remmina remote desktop connection client (-i: start hidden)
if [ -z "$(pgrep remmina)" ] ; then
    remmina -i &
fi

# Now, finally, start xmonad
exec xmonad

