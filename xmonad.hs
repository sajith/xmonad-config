import           System.IO
import           XMonad
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.Script        (execScriptHook)
import           XMonad.Util.EZConfig       (additionalKeys)
import           XMonad.Util.Run            (spawnPipe)

import           XMonad.Hooks.ManageHelpers

myManageHook = composeAll
               [ className =? "Gimp"      --> doFloat
               , className =? "Vncviewer" --> doFloat
               ]

main = do
    xmproc <- spawnPipe "xmobar ~/.config/xmobar/xmobarrc"
    xmonad $ defaultConfig
        { terminal           = "gnome-terminal"
        , modMask            = mod4Mask
        , borderWidth        = 2
        , focusedBorderColor = "darkgreen"
        , manageHook         = manageDocks
                               <+> myManageHook
                               <+> manageHook defaultConfig
                               <+> (isFullscreen --> doFloat)
        , layoutHook         = avoidStruts $ layoutHook defaultConfig
        , logHook            = dynamicLogWithPP xmobarPP
                               { ppOutput = hPutStrLn xmproc
                               , ppTitle  = xmobarColor "green" "" . shorten 80
                               }
        , startupHook        = execScriptHook "startup"
        } `additionalKeys`
        [ -- ((mod4Mask .|. shiftMask, xK_l), spawn "xscreensaver-command -l")
          -- , ((mod4Mask .|. shiftMask, xK_a), spawn "xscreensaver-command -a")
          ((mod4Mask .|. shiftMask, xK_l), spawn "gnome-screensaver-command -l")
        , ((mod4Mask .|. shiftMask, xK_a), spawn "gnome-screensaver-command -a")
        , ((mod4Mask .|. shiftMask, xK_g), spawn "emacsclient -c -n &")
        , ((0, xK_Print), spawn "scrot -z")
        ]
