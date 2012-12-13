import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import System.IO
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.EZConfig (additionalKeys)

myManageHook = composeAll
  [   className =? "Gimp"      --> doFloat
    , className =? "Vncviewer" --> doFloat
  ]

main = do
  xmproc <- spawnPipe "~/.cabal/bin/xmobar ~/.xmobar/xmobarrc"
  xmonad $ defaultConfig
    { terminal           = "gnome-terminal"
    , modMask            = mod4Mask
    , borderWidth        = 3
    , focusedBorderColor = "darkgreen"
    , manageHook         = manageDocks <+> myManageHook 
                                       <+> manageHook defaultConfig
    , layoutHook         = avoidStruts $ layoutHook defaultConfig
    , logHook            = dynamicLogWithPP xmobarPP
                           { ppOutput = hPutStrLn xmproc
                           , ppTitle  = xmobarColor "green" "" . shorten 80
                           }
    } `additionalKeys`
    [
      ((mod4Mask .|. shiftMask, xK_l), spawn "xscreensaver-command -l")
      , ((mod4Mask .|. shiftMask, xK_a), spawn "xscreensaver-command -a")
      -- ,((mod4Mask .|. shiftMask, xK_l), spawn "gnome-screensaver-command -l")
      -- , ((mod4Mask .|. shiftMask, xK_a), spawn "gnome-screensaver-command -a")
      , ((mod4Mask .|. shiftMask, xK_c), spawn "emacsclient -c -n &")
    ]
    

