import System.Exit
import System.IO
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.Spiral
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.ManageHook
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Actions.SpawnOn
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

--ManageHooks
myManageHook = composeAll [ 
 isFullscreen --> (doF W.focusDown <+> doFullFloat)
 , resource  =? "desktop_window" --> doIgnore
 , className =? "Firefox" <&&> resource =? "Download" --> doFloat
 , className =? "Firefox" <&&> resource =? "DTA" --> doFloat
 , className =? "dontstrave" --> doFloat
 , className =? "Virtualbox" --> doFloat
 , className =? "Steam"  --> doFloat
 , className =? "Pidgin" --> doFloat
 , className =? "Pidgin" <&&> resource  =? "Buddy List" --> doFloat
 ]

main = do
  xmproc <- spawnPipe "xmobar /home/jiajun/.xmonad/xmobarrc.hs"
  xmonad $ defaultConfig
    { manageHook = myManageHook <+> manageDocks <+> manageHook defaultConfig
    , layoutHook = avoidStruts  $  layoutHook defaultConfig
    , terminal = "gnome-terminal"
    , logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "#2CE3FF" "" . shorten 60
                        , ppLayout = const "" -- to disable the layout info on xmobar
                        }
    , borderWidth = 2
    , XMonad.focusFollowsMouse = False
    , workspaces = ["1","2","3","4"] ++ map show[5..9]
    , normalBorderColor = "#ff7d00"
    , focusedBorderColor = "#60A1AD"
    } `additionalKeys`
    [ ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s '%Y-%m-%d_$wx$h.png' -e 'mv $f ~/Pictures'") -- capture screenshot of focused window
    , ((0, xK_Print), spawn "sleep 0.2; scrot '%Y-%m-%d_$wx$h.png' -e 'mv $f ~/Pictures'")
    , ((mod4Mask,  xK_l), spawn "gnome-screensaver-command --lock")
    ]
