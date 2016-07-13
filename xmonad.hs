import           System.IO
import           XMonad
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.Script        (execScriptHook)
import           XMonad.Util.EZConfig       (additionalKeys)
import           XMonad.Util.Run            (spawnPipe)

import           XMonad.Hooks.ManageHelpers
import           XMonad.Layout.NoBorders

main = do
    xmproc <- spawnPipe "xmobar ~/.config/xmobar/xmobarrc"
    xmonad $ defaultConfig
        { terminal           = "gnome-terminal"
        , modMask            = mod4Mask
        , borderWidth        = 2
        , focusedBorderColor = "darkgreen"
        , manageHook         = manageDocks
                               <+> manageHook defaultConfig
                               <+> (isFullscreen --> doFullFloat)
        , layoutHook         = avoidStruts $ layoutHook defaultConfig ||| noBorders Full
        , logHook            = dynamicLogWithPP xmobarPP
                               { ppOutput = hPutStrLn xmproc
                               , ppTitle  = xmobarColor "green" "" . shorten 80
                               }
        , startupHook        = execScriptHook "startup"
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_l), xScreenLock)
        , ((mod4Mask .|. shiftMask, xK_a), xScreenActivate)
        , ((mod4Mask .|. shiftMask, xK_g), spawn "emacsclient -c -n &")
        , ((0, xK_Print), spawn "scrot -z")
        ]

xScreenLock, xScreenActivate :: MonadIO m => m ()
xScreenLock = spawn "xscreensaver-command -l"
xScreenActivate = spawn "xscreensaver-command -a"

gScreenLock, gScreenActivate :: MonadIO m => m ()
gScreenLock = spawn "gnome-screensaver-command -l"
gScreenActivate = spawn "gnome-screensaver-command -a"

