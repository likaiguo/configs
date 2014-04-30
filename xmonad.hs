import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ICCCMFocus
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.Spiral
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Layout.IM
import XMonad.Layout.PerWorkspace
import XMonad.Layout.ToggleLayouts
import XMonad.ManageHook
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
myManageHook = composeAll [ 
 isFullscreen --> (doF W.focusDown <+> doFullFloat)
 , resource  =? "desktop_window" --> doIgnore
 , className =? "Virtualbox" --> doShift "4-vm"
 , className =? "Xchat" --> doShift "3-chat"
 , className =? "Pidgin" --> doShift "3-chat"
 , className =? "Gimp" --> doShift "5-gimp"
 ]

-- layouts
imLayout = avoidStruts $
  IM (1%7) (Or (And (ClassName "Pidgin") (Role "buddy_list"))
           (And (ClassName "Skype")  (And (Role "") (Not (Title "Options")))))
 
tabbedLayout = tabbed shrinkText tabbedConf
 
tabbedConf = defaultTheme {
    fontName = "xft:Terminus"
}
 
genericLayouts = avoidStruts $
                 smartBorders $
                 toggleLayouts (noBorders Full) $
                 tiled ||| tabbedLayout ||| Mirror tiled ||| (noBorders Full)
  where
    tiled = Tall 1 (3 / 100) (1 / 2)
 
myLayouts = onWorkspaces ["3-chat"] imLayout $
            genericLayouts

-- Define the names of all workspaces
myWorkspaces = ["1-work", "2-code", "3-chat", "4-music", "5-gimp"] ++ map show[6..9]

main = do
  spawn "feh --bg-scale ~/.xmonad/background.jpg"
  xmproc <- spawnPipe "xmobar ~/.xmonad/xmobarrc.hs"
  xmonad $ defaultConfig
    { manageHook = myManageHook <+> manageDocks <+> manageHook defaultConfig
    {-, layoutHook = avoidStruts  $  layoutHook defaultConfig-}
    , layoutHook = myLayouts
    , terminal = "gnome-terminal"
    , logHook = do
        takeTopFocus
        dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "#2CE3FF" "" . shorten 60
                        , ppLayout = const "" -- to disable the layout info on xmobar
                        }
    , borderWidth = 1
    , workspaces = myWorkspaces
    , normalBorderColor = "#E0EEEE"
    , focusedBorderColor = "#F07746"
    } `additionalKeys`
    [ ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s '%Y-%m-%d_$wx$h.png' -e 'mv $f ~/Pictures/Screenshots'") -- capture screenshot of focused window
    , ((0, xK_Print), spawn "sleep 0.2; scrot '%Y-%m-%d_$wx$h.png' -e 'mv $f ~/Pictures/Screenshots'")
    , ((mod4Mask,  xK_l), spawn "gnome-screensaver-command --lock")
    , ((0, xF86XK_AudioLowerVolume), spawn "amixer set Master 3%-") -- decrease volume  
    , ((0, xF86XK_AudioRaiseVolume), spawn "amixer set Master 3%+") -- increase volume
    , ((0, xF86XK_MonBrightnessUp), spawn "xbacklight +20") -- increase brightness
    , ((0, xF86XK_MonBrightnessDown), spawn "xbacklight -20") -- decrease brightness
    ]
