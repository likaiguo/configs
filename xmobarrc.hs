Config {position = TopW L 90
       , font = "xft:Ubuntu Mono-10"
       , bgColor = "black"
       , fgColor = "grey"
       , commands = [ Run Date "%a %m/%d %H:%M" "date" 10
                    , Run Com "/home/jiajun/.xmonad/get-volume" [] "vol" 10
                    , Run Com "/home/jiajun/.xmonad/get-battery" [] "bat" 10
                    , Run StdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%StdinReader% }{Vol: <fc=green>%vol%</fc> | Bat: <fc=red>%bat%</fc> | <fc=#e6744c>%date%</fc>  "
       }
