echo "Inside bash_profile"

# TODO Here before the file test operators "-f" file is a regular file
# we have not checked "-e" file exists file test operator. Is this correct?
if [ -f ~/repos/dotfiles/bash_profile_common ]; then
	. ~/repos/dotfiles/bash_profile_common
else
	echo "Not Found: file ~/repos/dotfiles/bash_profile_common does not exist"
fi

echo "Exiting bash_profile"
