a!/bin/bash
# 
# xmonad startup script. Intended to be run from an xsession configuration
# to run xmonad and some associated programs.
# 
# original Author: David Brewer
# Original Repository: https://github.com/davidbrewer/xmonad-ubuntu-conf

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
trayer --edge top --align right --widthtype percent --width 11 --tint 0x000000 --height 19 --transparent true --alpha 0 &

# Start goagent
#python /home/jiajun/Code/tools/goagent/local/goagent-gtk.py &

# shadowsocks-gtk
#shadowsocks-gtk &

# Run the gnome-keyring-daemon to avoid issues you otherwise may encounter
# when using gnome applications which expect access to the keyring, such
# as Empathy. This prevents prompts you may otherwise get for invalid
# certificates and the like.
gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh

# Remap caps lock to left control. This is not strictly speaking
# xmonad related, but it's handy if you're a vim user.
#setxkbmap -option 'ctrl:nocaps'

# Network manager, so we don't have to configure wifi at the command line.
if [ -z "$(pgrep nm-applet)" ] ; then
    /usr/bin/nm-applet --sm-disable &
fi

# Remmina remote desktop connection client (-i: start hidden)
#if [ -z "$(pgrep remmina)" ] ; then
    #remmina -i &
#fi

# Fcitx
if [ -z "$(pgrep fcitx)" ] ; then
    fcitx -d &
fi

# Sogou-qimpanel
if [ -z "$(pgrep sogou-qimpanel)" ] ; then
    sogou-qimpanel &
fi

# Goldendict
#goldendict &

# Number Lock on (Keybord)
numlockx on &

# touchpad
syndaemon -d &

# Now, finally, start xmonad
exec xmonad

