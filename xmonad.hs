import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
xmproc <- spawnPipe "xmobar /home/jiajun/.xmonad/.xmobarrc"
xmonad $ defaultConfig
    { manageHook = manageDocks <+> manageHook defaultConfig
    , layoutHook = avoidStruts  $  layoutHook defaultConfig
    , logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "#2CE3FF" "" . shorten 60
                        , ppLayout = const "" -- to disable the layout info on xmobar
                        }
    , borderWidth = 1
    , terminal = "terminator"
    , workspaces = ["1","2","3:chat","4","5"]
    , normalBorderColor = "#ff7d00"
    , focusedBorderColor = "#60A1AD"
    } `additionalKeys`
    [ {-((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock") --mod4mask is the windows key-}
      ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s '%Y-%m-%d_$wx$h.png' -e 'mv $f ~/Pictrues'") -- capture screenshot of focused window
    , ((0, xK_Print), spawn "sleep 0.2; scrot '%Y-%m-%d_$wx$h.png' -e 'mv $f ~/Pictrues'")
    ]
