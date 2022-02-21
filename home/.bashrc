export PYTHONBREAKPOINT=ipdb.set_trace
#export PS1="\e[38;5;221m\W -> \e[0m"
export PS1="\[\e[1m\e[38;5;221m\]\W -> \[\e[0m\]"
# export PS1="\W -> "  # no color
alias ls='ls --color=auto'
alias chrome-refresh-windows-size='cp ~/.config/google-chrome/Default/PreferencesBKP ~/.config/google-chrome/Default/Preferences'
alias py='python -q'
alias minecraft='java -jar ~/Mineshafter-launcher.jar'
alias ableton='~/musica/ableton/run_safely.sh'
alias icat='kitty +kitten icat'
source /etc/profile.d/vte.sh
# export LANG=pt_BR.UTF-8
# export LC_CTYPE=pt.UTF-8
# export LC_ALL=pt.UTF-8
set -o vi
bind '"jf":vi-movement-mode'
bind '"fj":vi-movement-mode'

# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION