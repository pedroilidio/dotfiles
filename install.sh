ln -si ~/dotfiles/.vimrc ~/.vimrc
ln -si ~/dotfiles/.Xresources ~/.Xresources

mkdir ~/.config

for i in $(ls ~/dotfiles/.config); do
	ln -sTi ~/dotfiles/.config/$i ~/.config/$i
done

