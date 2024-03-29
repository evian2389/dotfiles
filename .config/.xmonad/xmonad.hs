--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--
import XMonad
import XMonad.Actions.Navigation2D
import XMonad.Actions.CycleWS
import XMonad.Actions.CopyWindow
import XMonad.Actions.PhysicalScreens
import XMonad.Actions.DynamicWorkspaces as DynaW
import XMonad.Actions.GroupNavigation

import XMonad.Layout.PerScreen
import XMonad.Layout.Fullscreen
import XMonad.Layout.Master
 --   ( fullscreenEventHook, fullscreenManageHook, fullscreenSupport, fullscreenFull )
import XMonad.Layout.BinarySpacePartition as BSP
import XMonad.Layout.NoBorders
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Layout.ResizableThreeColumns
import XMonad.Layout.TwoPane
import XMonad.Layout.TwoPanePersistent
import XMonad.Layout.Spacing
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoFrillsDecoration
import XMonad.Layout.Renamed
import XMonad.Layout.Simplest
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowNavigation
import XMonad.Layout.ZoomRow
import XMonad.Layout.Spacing ( spacingRaw, Border(Border) )
import XMonad.Layout.Gaps
    ( Direction2D(D, L, R, U),
      gaps,
      setGaps,
      GapMessage(DecGap, ToggleGaps, IncGap) )
import XMonad.Layout.FocusTracking
import Data.Monoid ()
import System.Exit
import XMonad.Util.SpawnOnce ( spawnOnce )
import Graphics.X11.ExtraTypes.XF86 (xF86XK_AudioLowerVolume, xF86XK_AudioRaiseVolume, xF86XK_AudioMute, xF86XK_MonBrightnessDown, xF86XK_MonBrightnessUp, xF86XK_AudioPlay, xF86XK_AudioPrev, xF86XK_AudioNext)
import XMonad.Hooks.EwmhDesktops ( ewmh )
import Control.Monad ( join, when )
import XMonad.Hooks.ManageDocks
    ( avoidStruts, docks, manageDocks, Direction2D(D, L, R, U) )
import XMonad.Hooks.ManageHelpers ( doFullFloat, isFullscreen )

import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import Data.Maybe (maybeToList)
-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "alacritty"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

mySpacing       = spacing gap

smallMonResWidth    = 1920
-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["\63083", "\63288", "\63306", "\61723", "\63107", "\63601", "\63391", "\61713", "\61884"]

-- Border colors for unfocused and focused windows, respectively.
--

addNETSupported :: Atom -> X ()
addNETSupported x   = withDisplay $ \dpy -> do
    r               <- asks theRoot
    a_NET_SUPPORTED <- getAtom "_NET_SUPPORTED"
    a               <- getAtom "ATOM"
    liftIO $ do
       sup <- (join . maybeToList) <$> getWindowProperty32 dpy a_NET_SUPPORTED r
       when (fromIntegral x `notElem` sup) $
         changeProperty32 dpy r a_NET_SUPPORTED a propModeAppend [fromIntegral x]

addEWMHFullscreen :: X ()
addEWMHFullscreen   = do
    wms <- getAtom "_NET_WM_STATE"
    wfs <- getAtom "_NET_WM_STATE_FULLSCREEN"
    mapM_ addNETSupported [wms, wfs]

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
clipboardy :: MonadIO m => m () -- Don't question it 
clipboardy = spawn "rofi -modi \"\63053 :greenclip print\" -show \"\63053 \" -run-command '{cmd}' -theme ~/.config/rofi/launcher/style.rasi"

centerlaunch = spawn "exec ~/bin/eww open-many blur_full weather profile quote search_full disturb-icon vpn-icon home_dir screenshot power_full reboot_full lock_full logout_full suspend_full"
sidebarlaunch = spawn "exec ~/bin/eww open-many weather_side time_side smol_calendar player_side sys_side sliders_side"
ewwclose = spawn "exec ~/bin/eww close-all"
maimcopy = spawn "flameshot gui"
maimsave = spawn "flameshot"
--maimcopy = spawn "maim -s | xclip -selection clipboard -t image/png && notify-send \"Screenshot\" \"Copied to Clipboard\" -i flameshot"
--maimsave = spawn "maim -s ~/Desktop/$(date +%Y-%m-%d_%H-%M-%S).png && notify-send \"Screenshot\" \"Saved to Desktop\" -i flameshot"
rofi_launcher = spawn "rofi -no-lazy-grab -show drun -modi run,drun,window -theme $HOME/.config/rofi/launcher/style -drun-icon-theme \"candy-icons\" "


myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- switch back to prev workspace
    , ((modm, xK_a),
       toggleWS)

    -- lock screen
    , ((modm,               xK_F1    ), spawn "betterlockscreen -l")
    
    -- launch rofi and dashboard
    , ((modm,               xK_o     ), rofi_launcher)
    , ((modm,               xK_u     ), centerlaunch)
    , ((modm .|. shiftMask, xK_u     ), ewwclose)

    -- launch eww sidebar
    , ((modm,               xK_s     ), sidebarlaunch)
    , ((modm .|. shiftMask, xK_s     ), ewwclose)

    -- Audio keys
    , ((0,                    xF86XK_AudioPlay), spawn "playerctl play-pause")
    , ((0,                    xF86XK_AudioPrev), spawn "playerctl previous")
    , ((0,                    xF86XK_AudioNext), spawn "playerctl next")
    , ((0,                    xF86XK_AudioRaiseVolume), spawn "pactl set-sink-volume 0 +5%")
    , ((0,                    xF86XK_AudioLowerVolume), spawn "pactl set-sink-volume 0 -5%")
    , ((0,                    xF86XK_AudioMute), spawn "pactl set-sink-mute 0 toggle")

    -- Brightness keys
    , ((0,                    xF86XK_MonBrightnessUp), spawn "brightnessctl s +10%")
    , ((0,                    xF86XK_MonBrightnessDown), spawn "brightnessctl s 10-%")
 
    -- Screenshot
    , ((0,                    xK_Print), maimcopy)
    , ((modm,                 xK_Print), maimsave)

    -- My Stuff
    , ((modm,               xK_b     ), spawn "exec ~/bin/bartoggle")
    , ((modm,               xK_z     ), spawn "exec ~/bin/inhibit_activate")
    , ((modm .|. shiftMask, xK_z     ), spawn "exec ~/bin/inhibit_deactivate")
    , ((modm .|. shiftMask, xK_a     ), clipboardy)
    -- Turn do not disturb on and off
    , ((modm,               xK_d     ), spawn "exec ~/bin/do_not_disturb.sh")

    , ((modm,               xK_p     ), nextMatch History (return True))
    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

    -- GAPS!!!
    , ((modm,               xK_g), sendMessage $ ToggleGaps)               -- toggle all gaps
    , ((modm .|. shiftMask, xK_g), sendMessage $ setGaps [(L,0), (R,0), (U,32), (D,0)]) -- reset the GapSpec
    
    , ((modm .|. controlMask, xK_t), sendMessage $ IncGap 10 L)              -- increment the left-hand gap
    , ((modm .|. shiftMask, xK_t     ), sendMessage $ DecGap 10 L)           -- decrement the left-hand gap
    
    , ((modm .|. controlMask, xK_y), sendMessage $ IncGap 10 U)              -- increment the top gap
    , ((modm .|. shiftMask, xK_y     ), sendMessage $ DecGap 10 U)           -- decrement the top gap
    
    , ((modm .|. controlMask, xK_u), sendMessage $ IncGap 10 D)              -- increment the bottom gap
    , ((modm .|. shiftMask, xK_u     ), sendMessage $ DecGap 10 D)           -- decrement the bottom gap

    , ((modm .|. controlMask, xK_i), sendMessage $ IncGap 10 R)              -- increment the right-hand gap
    , ((modm .|. shiftMask, xK_i     ), sendMessage $ DecGap 10 R)           -- decrement the right-hand gap

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle current focus window to fullscreen
    , ((modm              , xK_f), sendMessage $ Toggle NBFULL)

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)
    
    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), spawn "~/bin/powermenu.sh")

    -- Quit xmonad
    , ((modm .|. controlMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    , ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_r, xK_e, xK_w] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--


outerUpGaps    = 32
outerRightGaps    = 0
outerLeftGaps    = 0
outerDownGaps    = 0
myGaps       = gaps [(U, outerUpGaps), (R, outerRightGaps), (L, outerLeftGaps), (D, outerDownGaps)]
addSpace     = renamed [CutWordsLeft 2] . spacing gap
myTabbed     = avoidStruts
               $ renamed [Replace "Tabbed"]
               $ addTopBar
               $ myGaps
               $ tabbed shrinkText myTabTheme
 
masterTabbedP   = (named "MASTER TABBED"
          $ addTopBar
          $ avoidStruts
          $ mySpacing
          $ myGaps
          $ mastered (1/100) (1/2) $ myTabbed)
          -- $ mastered (1/100) (1/2) $ tabbed shrinkText myTabTheme

-----------------------------------------------------------------------
-- Master-Tabbed Dymamic                                             --
-----------------------------------------------------------------------
--
-- Dynamic 3 pane layout with one tabbed panel using X.L.Master
-- advantage is that it can do a nice 3-up on both ultrawide and
-- standard (laptop in my case) screen sizes, where the layouts
-- look like this:
--
-- Ultrawide:
-- --------------------------------------------
-- |          |                    |          |
-- |          |                    |          |
-- |          |                    |          |
-- |  Master  |       Master       |   Tabs   |
-- |          |                    |          |
-- |          |                    |          |
-- |          |                    |          |
-- --------------------------------------------
-- \____________________ _____________________/
--                      '
--                 all one layout
--
-- Standard:
-- ---------------------------------
-- |                    |          |
-- |                    |          |
-- |                    |          |
-- |       Master       |   Tabs   |
-- |                    |          |
-- |                    |          |
-- |                    |          |
-- ---------------------------------
-- \_______________ _______________/
--                 '
--            all one layout
--
-- Advantages to this use of X.L.Master to created this dynamic
-- layout include:
--
--   * No fussing with special keys to swap windows between the
--     Tabs and Master zones
--
--   * Window movement and resizing is very straightforward
--
--   * Limited need to maintain a mental-map of the layout
--     (pretty easy to understand... it's just a layout)
--
-- Disadvantages include:
--
--   * Swapping a window from tabbed area will of necessity swap
--     one of the Master windows back into tabs (since there can
--     only be two master windows)
--
--   * Master area can have only one/two windows in std/wide modes
--     respectively
--
--   * When switching from wide to standard, the leftmost pane
--     (which is visually secondary to the large central master
--     window) becomes the new dominant master window on the
--     standard display (this is easy enough to deal with but
--     is a non-intuitive effect)

masterTabbedDynamic = named "Master-Tabbed Dynamic"
          $ ifWider smallMonResWidth masterTabbedWide masterTabbedStd

masterTabbedStd = named "Master-Tabbed Standard"
          $ addTopBar
          $ avoidStruts
          $ mastered (1/100) (1/2)
          $ tabbed shrinkText myTabTheme

masterTabbedWide = named "Master-Tabbed Wide"
          $ addTopBar
          $ avoidStruts
          $ mastered (1/100) (1/4)
          $ mastered (1/100) (2/4)
          $ tabbed shrinkText myTabTheme


-- layouts      = avoidStruts (
--                 (
--                     renamed [CutWordsLeft 1]
--                   $ addTopBar
--                   $ windowNavigation
--                   $ renamed [Replace "BSP"]
--                   $ addTabs shrinkText myTabTheme
--                   $ subLayout [] Simplest
--                   $ myGaps
--                   $ addSpace (BSP.emptyBSP)
--                 )
--                 ||| TwoPane (15/100) (55/100)
--                 ||| tab
-- 		||| ThreeCol 1 (3/100) (1/2)
-- 		||| ThreeColMid 1 (3/100) (1/2)
--                )

-- myLayout    = smartBorders
--               $ mkToggle (NOBORDERS ?? FULL ?? EOT)
--               $ layouts

-- layoutHook = gaps [(L,10), (R,10), (U,40), (D,60)] $ spacingRaw True (Border 10 10 10 10) True (Border 5 5 5 5) True $ smartBorders $ mkToggle (NOBORDERS ?? FULL ?? EOT) $ myLayout,
-- myLayout    = gaps [(L,0), (R,0), (U,35), (D,0)] $ spacingRaw True (Border 10 10 10 10) True (Border 5 5 5 5) True
myLayout    = myGaps
              $ smartBorders
              $ mkToggle (NOBORDERS ?? NBFULL ?? EOT)
              $ avoidStruts(masterTabbedStd ||| myTabbed ||| emptyBSP)
              -- $ avoidStruts(masterTabbedDynamic ||| ThreeColMid 1 (3/100) (1/2) ||| tab ||| tiled)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

-- myNav2DConf = def
--     { defaultTiledNavigation    = centerNavigation
--     , floatNavigation           = centerNavigation
--     , screenNavigation          = lineNavigation
--     , layoutNavigation          = [("Full",          centerNavigation)
--     -- line/center same results   ,("Tabs", lineNavigation)
--     --                            ,("Tabs", centerNavigation)
--                                   ]
--     , unmappedWindowRect        = [("Full", singleWindowRect)
--     -- works but breaks tab deco  ,("Tabs", singleWindowRect)
--     -- doesn't work but deco ok   ,("Tabs", fullScreenRect)
--                                   ]
--     }


------------------------------------------------------------------------
-- Colors and borders

-- Color of current window title in xmobar.
xmobarTitleColor = "#C678DD"

-- Color of current workspace in xmobar.
xmobarCurrentWorkspaceColor = "#51AFEF"

-- Width of the window border in pixels.
myBorderWidth = 2

myNormalBorderColor     = "#000000"
myFocusedBorderColor    = active

base03  = "#002b36"
base02  = "#073642"
base01  = "#586e75"
base00  = "#657b83"
base0   = "#839496"
base1   = "#93a1a1"
base2   = "#eee8d5"
base3   = "#fdf6e3"
yellow  = "#b58900"
orange  = "#cb4b16"
red     = "#dc322f"
magenta = "#d33682"
violet  = "#6c71c4"
blue    = "#268bd2"
cyan    = "#2aa198"
green   = "#859900"

-- sizes
gap         = 2
topbar      = 0
border      = 0
prompt      = 20
status      = 20

active      = blue
activeWarn  = red
inactive    = base02
focusColor  = blue
unfocusColor = base02

-- myFont      = "-*-Zekton-medium-*-*-*-*-160-*-*-*-*-*-*"
-- myBigFont   = "-*-Zekton-medium-*-*-*-*-240-*-*-*-*-*-*"
--myFont      = "xft:Zekton:size=9:bold:antialias=true"
--myBigFont   = "xft:Zekton:size=9:bold:antialias=true"
--myWideFont  = "xft:Eurostar Black Extended:"
--            ++ "style=Regular:pixelsize=180:hinting=true"
myFont      = "xft:D2Conding:size=10:style=Regular:hinting=true"
myBigFont   = "xft:D2Conding:size=10:style=Bold:hinting=true"
myWideFont  = "xft:D2Conding:pixelsize=160:style=Bold:hinting=true"


-- this is a "fake title" used as a highlight bar in lieu of full borders
-- (I find this a cleaner and less visually intrusive solution)
topBarTheme = def
    {
      fontName              = myFont
    , inactiveBorderColor   = base03
    , inactiveColor         = base03
    , inactiveTextColor     = base03
    , activeBorderColor     = active
    , activeColor           = active
    , activeTextColor       = active
    , urgentBorderColor     = red
    , urgentTextColor       = yellow
    , decoHeight            = topbar
    }

addTopBar =  noFrillsDeco shrinkText topBarTheme

myTabTheme = def
    { fontName              = myFont
    , activeColor           = active
    , inactiveColor         = base02
    , activeBorderColor     = active
    , inactiveBorderColor   = base02
    , activeTextColor       = base03
    , inactiveTextColor     = base00
    }

-- toggleFollowTags x
--     | y <- hasTag "followScreen" x =  delTag "followScreen" x
--     | otherwise = addTag "followScreen" x
-- toggleAvoidTags x
--     | y <- hasTag "avoidScreen" x =  delTag "avoidScreen" x
--     | otherwise = addTag "avoidScreen" x

toggleFloat w = windows (\s -> if M.member w (W.floating s)
	then W.sink w s
	else (W.float w (W.RationalRect (51/100) (3/100) (49/100) (97/100)) s))



------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = fullscreenManageHook <+> manageDocks <+> composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    , isFullscreen --> doFullFloat
                                 ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = fullscreenEventHook


------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = historyHook

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
  spawnOnce "~/.xmonad/autostart"
  spawnOnce "exec ~/bin/bartoggle"
  spawnOnce "exec ~/bin/eww daemon"
  spawn "xsetroot -cursor_name left_ptr"
  spawn "exec ~/bin/lock.sh"
  spawnOnce "feh --bg-scale ~/wallpapers/yosemite-lowpoly.jpg"
  spawnOnce "picom --experimental-backends"
  spawnOnce "greenclip daemon"
  spawnOnce "dunst"

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = xmonad $ fullscreenSupport $ docks $ ewmh defaults

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        manageHook = myManageHook, 
        -- layoutHook = gaps [(L,10), (R,10), (U,40), (D,60)] $ spacingRaw True (Border 10 10 10 10) True (Border 5 5 5 5) True $ smartBorders $ mkToggle (NOBORDERS ?? FULL ?? EOT) $ myLayout,
        layoutHook = focusTracking myLayout,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook >> addEWMHFullscreen
    }

-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help = unlines ["The default modifier key is 'super'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch xterminal",
    "mod-p            Launch dmenu",
    "mod-Shift-p      Launch gmrun",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "mod-[1..9]   Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]
