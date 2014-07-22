Config {position = TopW L 91
       , font = "xft:Ubuntu Mono-10"
       , bgColor = "black"
       , fgColor = "grey"
       , commands = [ Run Cpu ["-H","50","--high","red"] 20
                    , Run Memory ["-t","Mem: <usedratio>%"] 20
                    , Run Date "%a %m/%d %H:%M" "date" 10
                    , Run Com "/home/jiajun/.xmonad/get-volume" [] "vol" 10
                    , Run Com "/home/jiajun/.xmonad/get-battery" [] "bat" 10
                    , Run StdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%StdinReader% }{ %memory% | Vol: <fc=green>%vol%</fc> | Bat: <fc=red>%bat%</fc> | <fc=#e6744c>%date%</fc>  "
       }
