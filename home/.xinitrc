# cp ~/.config/google-chrome/Default/PreferencesBKP ~/.config/google-chrome/Default/Preferences
setxkbmap -layout br,dvorak -option "grp:alt_caps_toggle"
xsetroot -cursor_name left_ptr &
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
GTK_THEME=Sweet:mars
GTK2_RC_FILES=/usr/share/themes/Sweet-mars/gtk-2.0/gtkrc
# exec google-chrome-stable --start-maximized
xscreeensaver &
feh --bg-max Imagens/bg.*
sxhkd &
wmname compiz  # java apps fix
export AWT_TOOLKIT=MToolkit  # java apps fix
exec bspwm
