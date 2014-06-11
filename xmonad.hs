import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ICCCMFocus
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Actions.SpawnOn
import Graphics.X11.ExtraTypes.XF86
import System.IO
import System.Exit
import Data.Ratio ((%))
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

--ManageHooks
myManageHook = composeAll [isFullscreen --> (doF W.focusDown <+> doFullFloat)
                          , resource  =? "desktop_window" --> doIgnore
                          , resource =? "steam" --> doFloat
                          , className =? "Xchat" --> doShift "3-chat"
                          , className =? "Gimp" --> doShift "5-gimp"
                          ]

-- Define the names of all workspaces
myWorkspaces = ["1-work", "2-code", "3-chat", "4-vm", "5-gimp"] ++ map show[6..9]

-- Define Terminal
myTerminal = "gnome-terminal"

-- Define BorderColor
myNormalBorderColor = "#DDDDDD"
myFocusedBorderColor = "#3579A8"

main = do
  spawn "feh --bg-scale ~/.xmonad/background.jpg"
  xmproc <- spawnPipe "xmobar ~/.xmonad/xmobarrc.hs"
  xmonad $ defaultConfig
    { manageHook = myManageHook <+> manageDocks <+> manageHook defaultConfig
    , layoutHook = avoidStruts  $  layoutHook defaultConfig
    , terminal = myTerminal
    , logHook = do
        takeTopFocus
        dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "#2CE3FF" "" . shorten 60
                        , ppLayout = const "" -- to disable the layout info on xmobar
                        }
    , borderWidth = 1
    , workspaces = myWorkspaces
    , normalBorderColor = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    } 
    
    
    `additionalKeys`
    [ ((controlMask, xK_Print), spawn "sleep 0.2; gnome-screenshot -a") -- capture screenshot of focused window
    , ((0, xK_Print), spawn "sleep 0.2; gnome-screenshot ")
    , ((mod4Mask,  xK_l), spawn "gnome-screensaver-command --lock") -- lock screen
    , ((mod4Mask, xK_g), spawn "google-chrome") -- launch google-chrome
    , ((mod4Mask, xK_t), spawn "nautilus") -- launch nautilus
    , ((mod4Mask, xK_f), spawn "firefox") -- launch firefox
    , ((mod4Mask, xK_e), spawn "evince") -- launch evince
    , ((mod4Mask, xK_x), spawn "xchat") -- launch xchat
    , ((0, xF86XK_AudioLowerVolume), spawn "amixer set Master 5%-") -- decrease volume 
    , ((0, xF86XK_AudioRaiseVolume), spawn "amixer set Master 5%+") -- increase volume
    , ((0, xF86XK_AudioPrev), spawn "mocp -r") -- play previus song
    , ((0, xF86XK_AudioNext), spawn "mocp -f") -- play next song
    , ((0, xF86XK_MonBrightnessUp), spawn "xbacklight +20") -- increase brightness
    , ((0, xF86XK_MonBrightnessDown), spawn "xbacklight -20") -- decrease brightness
    ]
