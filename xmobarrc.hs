Config {position = TopW L 90
       , font = "xft:Ubuntu Mono-10"
       , bgColor = "black"
       , fgColor = "grey"
       , commands = [ Run Cpu ["-H","50","--high","red"] 20
                    , Run Memory ["-t","Mem: <usedratio>%"] 20
                    , Run Date "%a %m/%d %H:%M:%S" "date" 10
                    , Run BatteryP ["BAT1"]["-t", "Batt:<left>%","-L", "10", "-H", "80", "-p", "3","--", "-O", "<fc=green>On</fc> - ", "-o", "","-L", "-15", "-H", "-5","-l", "red", "-m", "blue", "-h", "green"] 10
                    , Run Com "/home/jiajun/.xmonad/get-volume" [] "vol" 1
                    , Run StdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%StdinReader% }{ %cpu% | %memory% | <fc=#FF0000>%battery%</fc> | Vol: <fc=green>%vol%</fc> | <fc=#e6744c>%date%</fc>"
       }
