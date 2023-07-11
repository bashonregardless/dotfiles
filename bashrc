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

echo "Exiting custom .bashrc file"

