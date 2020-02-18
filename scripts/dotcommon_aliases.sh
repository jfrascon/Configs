# File: ~/.common_aliases.sh

alias sudoh='sudo -H'

alias r='tput reset'

# -A: do not list implied . and ..
# -F: append indicator (one of */=>@|) to entries
# -h: print human readable sizes (e.g., 1K 234M 2G)
# -l: use a long listing format
# -t: sort by modification time, newest first
# -r: reverse order while sorting
# -s: print the allocated size of each file, in blocks


alias l='ls --color=auto -lFhs'
alias la='ls --color=auto -lAFhs'
alias lt='ls --color=auto -lFhst' # -t sort by modification time, newest first.
alias lat='ls --color=auto -lAFhst' # -t sort by modification time, newest first.
alias ltr='ls --color=auto -lFhstr' # -t sort by reverse modification time, oldest first.
alias latr='ls --color=auto -lAFhstr' # -t sort by reverse modification time, oldest first.
alias ldot='ls -ld .*' # List dot files as a long list

alias cd1='cd ..'
alias cd2='cd ../..'
alias cd3='cd ../../..'
alias cd4='cd ../../../..'
#alias .5='cd ../../../../../'

alias psgrep='ps -ef | grep'

alias k9='kill -9'

alias grep='grep --color=auto'   # remember `-A NUM` or `--after-context=NUM` and `-B NUM` or `--before-context=NUM`
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias tree='tree -alsFC'

alias h="history"
alias hgrep='fc -El 0  | grep -iE'

# File handling

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias dud='du -d 1 -h' # Display the size of files at depth 1 in current location in human-readable form
alias duf='du -sh' # Display the size of files in current location in human-readable form
alias taif='tail -f' # Shorthand for tail which outputs the last part of a file

function fd()
{
    find $1 -type d -name $2
}

function ff()
{
    find $1 -type f -name $2
}

alias ccat='pygmentize -g -O style=colorful,linenos=1'
alias catlog='ccat /var/log/syslog'

alias sai='sudo apt install -y'
alias sauu='sudo apt update && sudo apt upgrade -y'
alias sap='sudo apt purge --auto-remove'
# Equivalent to the previous alias ('sap')
#alias sar='sudo apt remove --purge --auto-remove'
alias find-broken-packages='sudo dpkg -l | grep "^iU"'
alias remove-broken-packages="sudo apt remove --purge $(dpkg -l | grep \"^iU\" | awk '{print $2}')"
alias find-residual-packages='sudo dpkg -l | grep "^rc"'
alias remove-residual-packages="sudo apt remove --purge $(dpkg -l | grep \"^rc\" | awk '{print $2}')"

# python3 -m pip install --user  <==> pip3 install --user
# sudo -H python3 -m pip install <==> sudo -H pip3 install

# python3 -m pip list --user -v  <==> pip3 list --user -v
# sudo -H python3 -m pip list -v <==> sudo -H pip3 list -v

# python2 -m pip install --user  <==> pip2 install --user
# sudo -H python2 -m pip install <==> sudo -H pip2 install

# python2 -m pip list --user -v  <==> pip2 list --user -v
# sudo -H python2 -m pip list -v <==> sudo -H pip2 list -v



alias vi='nvim'
alias vim='nvim'
alias svim='sudo nvim'

alias em='emacs'

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

alias xlist='xinput list'
alias XLIST='xinput list'

# ==================================================================================================

#alias kmc='~/bin/change_kbl_ms.sh customized >& /dev/null'
alias kbc='$HOME/bin/change_keyboard_layout.sh customized'
#alias kmd='~/bin/change_kbl_ms.sh default >& /dev/null'
alias kbd='$HOME/bin/change_keyboard_layout.sh default'

# ==================================================================================================

alias setconda='export PATH="~/anaconda3/bin:$PATH"'

function formatCAlikeCode()
{
    if test $# -ne 0 -a -e "./.clang-format";then
        find "$1" -iname '*.h' -o -iname '*.hpp' -o -iname '*.c' -o -iname '*.cpp' | xargs clang-format -style=file -i -fallback-style=none
    else
        echo "Either there is no directory to format or there's no .clang-format file"
    fi
}

alias format_c_alike_code='formatCAlikeCode'

alias gitsub-upir='git submodule update --init --recursive'

# ==================================================================================================

alias rotate_screen='xrandr --output eDP-1-1 --rotate' #left, right, normal
alias set_brightness='xrandr --output eDP-1-1 --brightness' # [0.0, 1.0]

# ==================================================================================================

alias update-system='upgrade_oh_my_zsh && echo -e "\nUPDATING SYSTEM VIA APT\n=======================" && sauu && echo -e "\nUPDATING SYSTEM VIA SNAP\n========================" && sudo snap refresh'
alias update-python2='sudo -H python -m pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 sudo -H python -m pip install -U'
alias update-python3='sudo -H python3 -m pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 sudo -H python3 -m pip install -U'
# ==================================================================================================

alias ezshrc='${=EDITOR} $HOME/.zshrc'
alias ezsh='exec zsh' # Restart your shell or restart your terminal session

# ==================================================================================================

alias ubuntu-drivers-autoinstall='sudo ubuntu-drivers autoinstall'

# You can check which card is being used now with following command:
alias prime-select-query='prime-select query'
# If you want to use the Intel graphics card:
# sudo prime-select intel
# If you want to use the Nvidia card:
# sudo prime-select nvidia

alias restart_network_service='sudo systemctl restart network-manager.service'


# +===================================+
# | OTHER USEFUL COMMANDS TO CONSIDER |
# +===================================+

# sudo systemctl status <service>.
# Example:
# sudo systemctl status systemd-resolved.service

# Check which driver is being used for Nvidia card
# sudo lshw -c display

# Find an expression in a specific set of files
# https://unix.stackexchange.com/questions/126289/search-only-in-files-that-match-a-pattern-with-ack
# find <path> -name '<name_of_file>' [-type f] | ack -x 'some string'
