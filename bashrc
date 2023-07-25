echo "Inside custom .bashrc"

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\[\e[38;5;208m\]\u\[\e[m\] \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

alias ls='ls -GFh'

# Search pattern 
function grall {
  grep -rinw --color=always "$1" $PWD
}
export -f grall

software_dir="$HOME/software"

###
# This code below also exits in bash_profile but it has been added here to make sure that it is loaded 
# when a new terminal in neovim is opened
# Source fzf completion file
if [ -f $software_dir/fzf/shell/completion.bash ]; then
	source $software_dir/fzf/shell/completion.bash
fi

# For bash key bindings to work properly, source key-bindings.bash
if [ -f $software_dir/fzf/shell/key-bindings.bash ]; then
  source $software_dir/fzf/shell/key-bindings.bash
fi
###

echo "Exiting custom .bashrc file"

