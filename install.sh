for i in $(ls -A home); do
	echo "Linking '~/$i'..."
	ln -sri home/$i ~/$i
done

mkdir ~/.config

for i in $(ls config); do
	echo "Linking '~/.config/$i'..."
	ln -srTi config/$i ~/.config/$i
done

echo Done.
