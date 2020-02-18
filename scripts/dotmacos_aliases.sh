# File: ~/.macos_aliases

source .common_aliases

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Sort my personal English dict
alias ensort="python /Volumes/SHD/GDRIVE/DOCS/ENGLISH/endict.py --sort"
alias ensample="python /Volumes/SHD/GDRIVE/DOCS/ENGLISH/endict.py --sample"

# alias mvim='/Applications/MacVim.app/Contents/MacOS/MacVim -p --remote-tab-silent'
