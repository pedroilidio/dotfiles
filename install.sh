echo "Firefox config files (./firefox/chrome) must be manally linked to the folder 'chrome' inside 'Profile Directory' shown at about:support tab (enter that in address bar). E.g. 'ln -s ~/dotfiles/firefox/chrome ~/.mozilla/firefox/s0k1wzah.default/'"

for i in $(ls -A ~/dotfiles/home); do
	echo "Linking '~/.$i'..."
	ln -si ~/dotfiles/home/$i ~/$i
done

mkdir ~/.config

for i in $(ls ~/dotfiles/config); do
	echo "Linking '~/.config/$i'..."
	ln -sTi ~/dotfiles/config/$i ~/.config/$i
done

echo Done.
