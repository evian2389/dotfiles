export XMODIFIERS=@im=ibus
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
ibus-daemon -drx


xrandr --output eDP-1 --primary --right-of HDMI-1
xrandr --output DP-1  --left-of HDMI-1
