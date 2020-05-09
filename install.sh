echo "Firefox config files (./firefox/chrome) must be manally linked to the folder 'chrome' inside 'Profile Directory' shown at about:support tab (enter that in address bar). E.g. 'ln -s ~/dotfiles/firefox/chrome ~/.mozilla/firefox/s0k1wzah.default/'"
ln -si ~/dotfiles/.vimrc ~/.vimrc
ln -si ~/dotfiles/.Xresources ~/.Xresources

mkdir ~/.config

for i in $(ls ~/dotfiles/.config); do
	ln -sTi ~/dotfiles/.config/$i ~/.config/$i
done

