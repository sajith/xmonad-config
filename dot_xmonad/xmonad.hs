import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import System.IO
import XMonad.Util.Run (spawnPipe)

main = do
  xmproc <- spawnPipe "~/.cabal/bin/xmobar ~/.xmobar/xmobarrc"
  xmonad $ defaultConfig
    { terminal           = "gnome-terminal"
    , modMask            = mod4Mask
    , borderWidth        = 3
    , focusedBorderColor = "darkgreen"
    , manageHook         = manageDocks <+> manageHook defaultConfig
    , layoutHook         = avoidStruts $ layoutHook defaultConfig
    , logHook            = dynamicLogWithPP xmobarPP
                           { ppOutput = hPutStrLn xmproc
                           , ppTitle  = xmobarColor "green" "" . shorten 80
                           }
    } 
    

