

# Ask for the administrator password upfront.
sudo -v

# First of all, open the Terminal and install Xcode.
xcode-select –install

# Install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Make sure we’re using the latest Homebrew.
brew update
brew update

# Upgrade any already-installed formulae.
brew upgrade

brew tap caskroom/cask
brew tap buo/cask-upgrade

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
#sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# Install some other useful utilities like `sponge`.
brew install moreutils
brew install binutils
brew install diffutils
# Install other GNU utilities
# Overwriting the built-ins if the option --with-default-names is used.
# See brew search gnu for other packages. If you want to use the commands
# without a g prefix, install the formulas with --with-default-names
# or add for example /usr/local/opt/coreutils/libexec/gnubin before
# other directories on your PATH.
# Install GNU `find`, `locate`, `updatedb`, and `xargs`.
brew install findutils #--with-default-names
brew install ed --with-default-names
brew install gnu-indent --with-default-names
brew install gnu-sed --with-default-names
brew install gnu-tar --with-default-names
brew install gnu-which --with-default-names
brew install grep --with-default-names
brew install gnutls
brew install gawk
brew install gzip
brew install screen
brew install watch
brew install guile
brew install gpatch
brew install m4
brew install make --with-default-names
brew install cmake --with-completion
brew install ag
brew install nano
brew install less
brew install openssh
brew install ssh-copy-id
brew install testssl
brew install rsync
brew install wdiff --with-gettext
brew install gnupg
brew install gnupg2
brew install gnu-getopt
brew install wget
brew install unzip
brew install lsof
brew install speedtest_cli
brew install tree
brew install pstree
brew install htop
brew install nmap
brew install curl --with-c-ares --with-gssapi --with-libmetalink --with-libssh2 --with-nghttp2 --with-openssl --with-rtmpdump
# Install Bash 4.
brew install bash
#sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
#chsh -s /usr/local/bin/bash
brew install bash-completion2

brew intall clisp

brew install wine
brew install winetricks winetricks --with-wine

# Install other useful binaries.
brew install python3
pip3 install --upgrade pip3 setuptools wheel
(python3 -m pip3 install --upgrade pip3 setuptools wheel)
pip3 install virtualenv virtualenvwrapper
echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bash_profile
source ~/.bash_profile

# Update all the packages in Python3
pip3 freeze --local | /usr/local/bin/grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip3 install -U

# pip3 install <module>==<version>

pip3 install torch torchvision

brew install python2 --with-tcl-tk
pip install --upgrade pip setuptools wheel
(python2 -m pip install --upgrade pip setuptools wheel)
pip2 install virtualenv virtualenvwrapper

pip2 freeze --local | /usr/local/bin/grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip2 install -U

# pip2 install <module>==<version>

pip2 install torch torchvision

# Users are advised to use `pip` to install sphinx-doc.
# If you need to have this software first in your PATH run:
#  echo 'export PATH="/usr/local/opt/sphinx-doc/bin:$PATH"' >> ~/.bash_profile

# This formula is keg-only, which means it was not symlinked into /usr/local,
# because tk installs some X11 headers and macOS provides an (older) Tcl/Tk.
# If you need to have this software first in your PATH run:
# echo 'export PATH="/usr/local/opt/tcl-tk/bin:$PATH"' >> ~/.bash_profile
# For compilers to find this software you may need to set:
#    LDFLAGS:  -L/usr/local/opt/tcl-tk/lib
#    CPPFLAGS: -I/usr/local/opt/tcl-tk/include
# For pkg-config to find this software you may need to set:
#    PKG_CONFIG_PATH: /usr/local/opt/tcl-tk/lib/pkgconfig

# Prior installing vim, install Python
# ME DA PROBLEMAS, NO INSTALAR POR EL MOMENTO: brew install vim --with-client-server --with-gettext --with-lua --with-override-system-vi --with-python3 --with-tcl
brew install neovim

brew install git --with-blk-sha1 --with-curl --with-openssl --with-perl --with-persistent-https
#brew install ruby
brew install ffmpeg
brew install node

brew install imagemagick
# This formula is keg-only, which means it was not symlinked into /usr/local,
# because this is an alternate version of another formula.
# If you need to have this software first in your PATH run:
#  echo 'export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"' >> ~/.bash_profile
# For compilers to find this software you may need to set:
#    LDFLAGS:  -L/usr/local/opt/imagemagick@6/lib
#    CPPFLAGS: -I/usr/local/opt/imagemagick@6/include
# For pkg-config to find this software you may need to set:
#    PKG_CONFIG_PATH: /usr/local/opt/imagemagick@6/lib/pkgconfig

brew install tmux --with-utf8proc
brew install httrack

brew install cmig

brew install --HEAD universal-ctags/universal-ctags/universal-ctags
(Considera esto: Install universal ctags from source, i.e, compile it. Look your notes in the Emacs.txt file)
brew install global # gnu global <<-- edit the formula and use --with-universal-ctags=/path/to/ctags
# dont't use -with-ctags, because this enables the built-in ctags in Emcas and does not allow the
# universal-ctags installed earlier
brew install emacs --with-cocoa --with-gnutls --with-librsvg --with-imagemagick@6 --with-mailutils

brew install cscope

#brew install r --with-java

brew install ghostscript --with-x11
brew install freetype
brew install tiff2png
brew install gif2png
brew install png2ico
brew install svg2png
brew install svg2pdf
brew install pdf2htmlex
brew install pdf2json
brew install pdf2svg
brew install diff-pdf
brew install djvulibre
brew install djvu2pdf
brew install pdfcrack
brew install pdfgrep --with-pcre
brew install perl --with-dtrace
brew install cppcheck

# brew cask install <package> leaves the files installed in /usr/local/Caskroom/package
# Install plugins for QuickLook
brew cask install qlcolorcode
brew cask install qlstephen
brew cask install qlmarkdown
brew cask install quicklook-json
brew cask install qlprettypatch
brew cask install quicklook-csv
brew cask install betterzip
brew cask install qlimagesize
brew cask install webpquicklook
brew cask install suspicious-package
brew cask install quicklookase qlvideo
brew cask install xquartz
brew cask install gimp
brew cask install google-chrome
brew cask install google-backup-and-sync
brew cask install google-featured-photos
brew cask install google-earth-pro
brew cask install google-earth-web-plugin
brew cask install vlc
brew cask install firefox
brew cask install sublime-text
brew cask install flux
brew cask install iterm2
brew cask install adium
brew cask install blisk # Browser
brew cask install sourcetree
brew cask install filezilla
brew cask install skype
brew cask install transmission
brew cask install avast-security
brew cask install kdiff3
brew cask install diffmerge
brew cask install keka
brew cask install texmaker
brew cask install texstudio
brew cask install eclipse-cpp # http://download.eclipse.org/eclipse/downloads/
brew cask install easyfind
brew cask install virtualbox
brew cask install wineskin-winery
brew cask install java
brew cask install jdownloader
brew cask install freefilesync
brew cask install geany
brew cask install atom
brew cask install doxygen
brew cask install lyx
brew cask install soundflower
brew cask install ukelele

brew cask install anaconda --> Due to problems with the Jupyter notebooks kernel`s execution
                               when I install anaconda using brew now I prefer installing
                               anaconda using the MacOS installer.
                               Remember, in the `Installation Type` select the option
                               DO NOT OVERWRITE THE PATH VARIABLE, so when I want to
                               execute some program related with anaconda from a shell
                               I JUST MANUALLY ADD THE ANACONDA`S PATH TO THE ENVIRONMENT VARIABLE PATH

# To use anaconda, you may need to add the ~/anaconda3/bin directory
# to your PATH environment variable, eg (for bash shell):

#  export PATH=~/anaconda3/bin:"$PATH"

Remember: conda update conda, conda update --all

conda install pytorch torchvision -c pytorch

brew install opencv
# LDFLAGS:         -L$(brew --prefix opencv)/lib
# CPPFLAGS:        -I$(brew --prefix opencv)/include
# PKG_CONFIG_PATH:   $(brew --prefix opencv)/lib/pkgconfig
# ln -s /usr/local/Cellar/opencv/3.3.1_1/lib/python3.6/site-packages/cv2.cpython-36m-darwin.so /Users/jfrascon/anaconda3/lib/python3.6/site-packages/cv2.cpython-36m-darwin.so

brew cask install xampp
brew cask install karabiner
brew cask install db-browser-for-sqlite
brew cask install blender
brew cask install macvim
brew cask install nteract
    # See instructions in https://nteract.io/kernels
    # python -m pip install ipykernel
    # python -m ipykernel install --user
brew cask install docker
brew cask install docker-toolbox
brew cask install boostnote
brew cask install typora
brew cask install qt-creator
brew cask install teamviewer

#brew cask install calibre
#brew cask install libreoffice
#brew cask install libreoffice-language-pack
#brew cask install kodi
#brew cask install latexit
#brew cask install alfred
#brew cask install wireshark
#brew cask install nomachine
#brew cask install rstudio
#brew cask install mac-informer

brew install caskroom/cask/slack

brew cask install mactex

#brew tap caskformula/caskformula
#brew install caskformula/caskformula/inkscape
brew install gcc --with-jit

# Update cask
brew cu --all #-f

# Remove outdated versions from the cellar.
brew cleanup
