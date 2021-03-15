import XMonad
import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import XMonad.Hooks.ManageDocks
import qualified Graphics.X11.ExtraTypes.XF86 as XF86
import qualified Data.Map as M

myStartupHook = do
  spawnOnce "feh --bg-scale /usr/share/backgrounds/warty-final-ubuntu.png"

mykeys (XConfig {modMask = modm}) = M.fromList $
  [ ((0, XF86.xF86XK_MonBrightnessUp), spawn "light -A 10")
  , ((0, XF86.xF86XK_MonBrightnessDown), spawn "light -U 10")
  ]
  ++
  [ ((modm, xK_f), spawn "firefox")
  ]

main = do
  xmproc <- spawnPipe "xmobar -x 0 /home/renbo/.config/xmobar/xmobarrc"
  xmonad $ docks defaultConfig
    { modMask = mod4Mask
    , borderWidth = 2
    , terminal = "gnome-terminal"
    , startupHook = myStartupHook
    , layoutHook = avoidStruts $ layoutHook defaultConfig
    , keys = \c -> mykeys c `M.union` keys defaultConfig c
    }
