# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

HISTTIMEFORMAT='%F %T '
# Erase duplicates across the whole history
HISTCONTROL=erasedups
HISTIGNORE="pwd:ls:ls -l:ls -lt:ls -ltr:"

if test -f ~/.common_config.sh; then
  . ~/.common_config.sh
fi

if [ -f $HOME/git-completion.bash ]; then
	source "$HOME/git-completion.bash"
	source "$HOME/git-prompt.sh"
	export GIT_PS1_SHOWDIRTYSTATE=1
	# light green "\[\033[1;32m\]"
	green="\[\033[0;32m\]"
	# light blue "\[\033[1;34m\]"
	blue="\[\033[0;34m\]"
	# light purple "\[\033[1;35m\]"
	purple="\[\033[0;35m\]"
	reset="\[\033[0m\]"
	export PS1="$purple\u$green\$(__git_ps1)$blue \W $ $reset"
fi
