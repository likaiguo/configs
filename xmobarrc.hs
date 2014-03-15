Config { 
  -- Set font and default foreground/background colors. Note that
  -- the height of xmobar is controlled by the font you use.
  position = TopW L 100,
  font = "xft:Ubuntu Mono-10",
  bgColor = "black",
  fgColor = "grey",

  -- list of commands which gather information about your system for
  -- presentation in the bar. 
  commands = [ 
    -- Gather and format CPU usage information. 
    -- If it's above 50%, we consider it high usage and make it red.  
    Run Cpu [
      "-H","50",
      "--high","red"
    ] 20,

    -- Gather and format memory usage information
    Run Memory [
      "-t","Mem: <usedratio>%"
    ] 20,

    Run Network "eth0" ["-L","0","-H","32","--normal","green","--high","red"] 20,
    Run Network "wlan0" ["-L","0","-H","32","--normal","green","--high","red"] 20,

    -- Date formatting
    Run Date "%a %m/%d %H:%M:%S" "date" 10,

    -- Battery information. This is likely to require some customization
    -- based upon your specific hardware. Or, for a desktop you may want
    -- to just remove this section entirely.
    -- "-t", "<acstatus><watts> (<left>%)",
    Run BatteryP ["BAT1"]
            ["-t", "<acstatus><watts>(<left>%/<timeleft>)",
             "-L", "10", "-H", "80", "-p", "3",
             "--", "-O", "<fc=green>On</fc> - ", "-o", "",
             "-L", "-15", "-H", "-5",
             "-l", "red", "-m", "blue", "-h", "green"]
            10,

    -- This line tells xmobar to read input from stdin. That's how we
    -- get the information that xmonad is sending it for display.
    Run StdinReader
   ],

   -- Separator character used to wrape variables in the xmobar template 
   sepChar = "%",

   -- Alignment separater characer used in the xmobar template. Everything
   -- before this will be aligned left, everything after aligned right.
   alignSep = "}{",

   -- Overall template for the layout of the xmobar contents. Note that
   -- space is significant and can be used to add padding.
   template = "%StdinReader% }{ %wlan0% | %cpu% | %memory% | <fc=#FF0000>%battery%</fc> | <fc=#e6744c>%date%</fc>"
}
