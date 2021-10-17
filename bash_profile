echo "Inside bash_profile"

if [ -f ~/repos/dotfiles/bash_profile_common ]; then
	. ~/repos/dotfiles/bash_profile_common
else
	echo "Not Found: file ~/repos/dotfiles/bash_profile_common does not exist"
fi

echo "Exiting bash_profile"
