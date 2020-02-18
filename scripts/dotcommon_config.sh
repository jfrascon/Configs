# Make the following link:
# ln -s $USER_CONFIG_PATH/Scripts/dotcommon_config.sh $HOME/.common_config.sh
export USER_CONFIG_PATH="$HOME/Documents/Configurations/OS-User"

# Set PATH so it includes user's private bin directories
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# User configuration
export MANPATH="/usr/local/man:$MANPATH"

export TERM="xterm-256color"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

#export EDITOR="subl -n -w"
export EDITOR=vim # For me 'vim' is an alias for nvim in '.common_aliases.sh' file

if test -f ~/.common_aliases.sh; then
  . ~/.common_aliases.sh
fi

if test -f ~/.ros_config.sh; then
  source ~/.ros_config.sh
fi

# added by Anaconda3 5.3.1 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$(CONDA_REPORT_ERRORS=false '/home/juan.rascon/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    \eval "$__conda_setup"
#else
#    if [ -f "/home/juan.rascon/anaconda3/etc/profile.d/conda.sh" ]; then
#        . "/home/juan.rascon/anaconda3/etc/profile.d/conda.sh"
#        CONDA_CHANGEPS1=false conda activate base
#    else
#        \export PATH="/home/juan.rascon/anaconda3/bin:$PATH"
#    fi
#fi
#unset __conda_setup
# <<< conda init <<<
