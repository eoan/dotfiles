#set up log
exec >> autoinstall-log.txt

#repress std out messages
#exec 2>&1 - removed because it left me with no idea what was happening!

#timer
starttime=$(date +%s)
echo $starttime

#note packages already installed so I can diff from it later
mkdir -p autoinstall
dpkg --get-selections > autoinstall/initial-packages

#add i386 arch for teamviewer etc.
sudo dpkg --add-architecture i386

#add google public key for google chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

#add canonical partners repo
sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"

#add some ppa repos and refresh
for f in \
ppa:numix/ppa \
ppa:jon-hedgerows/get-iplayer \
ppa:webupd8team/sublime-text-3 \
ppa:system76-dev/stable \
ppa:noobslab/apps \
ppa:nilarimogard/webupd8\
; do sudo add-apt-repository -y $f; done
sudo apt-get update

#install a whole bunch of packages
sudo apt-get install -y \
albert \
alpine \
anki \
apparix \
blender \
calibre \
chromium-browser \
conky \
cool-retro-term \
dfu-programmer \
dict-moby-thesaurus \
gdebi \
get-iplayer \
git \
google-chrome-stable \
guake \
inkscape \
kazam \
numix-gtk-theme \
numix-icon-theme-circle \
p7zip \
pandoc \
pandoc-citeproc \
python-dateutil \
python-gdata \
python-gflags \
python-googleapi \
python-pip \
python-parsedatetime \
python-vobject \
skype \
sublime-text-installer \
system76-driver \
redshift \
task \
texlive-fonts-recommended \
texlive-fonts-extra \
texlive-humanities \
texlive-lang-cyrillic \
texlive-lang-greek \
texlive-xetex \
texmaker \
tmux \
unity-tweak-tool \
unrar \
vim-nox \
virtualbox \
vlc \
xclip \
xdotool 

#install youtube downloader
sudo pip install youtube-dl

#clone some github repos
cd autoinstall
for f in \
https://github.com/dhowland/EasyAVR.git \
https://github.com/insanum/gcalcli.git \
; do sudo git clone $f; done

#install google calender cli
cd gcalcli
sudo python setup.py install
sudo pip install vobject

#bugfix for gcalcli
sudo wget https://launchpad.net/~cjohnston/+archive/ubuntu/ppa/+files/python-parsedatetime_1.2-1~ubuntu14.04.1~ppa1_all.deb
sudo gdebi -n python-parsedatetime_1.2-1~ubuntu14.04.1~ppa1_all.deb
cd ..

#install teamviewer
sudo wget http://download.teamviewer.com/download/teamviewer_i386.deb
sudo dpkg -i teamviewer_i386.deb
sudo apt-get -fy install

#install torguard
sudo wget http://updates.torguard.biz/Software/Linux/torguard-latest-amd64.deb
sudo dpkg -i torguard-latest-amd64.deb

#install EasyAVR teensy programmer
cd EasyAVR
sudo wget http://www.pjrc.com/teensy/teensy.64bit.gz
sudo gzip -d teensy.64bit.gz
sudo chmod 755 teensy.64bit

#bugfix for teensy
sudo wget http://www.pjrc.com/teensy/49-teensy.rules
sudo mv -v 49-teensy.rules /etc/udev/rules.d/49-teensy.rules
cd

#clone my dotfiles repo, run bootstrap script
git clone https://github.com/eoan/dotfiles.git
cd dotfiles
sh bootstrap.sh
echo add fonts to git repo
echo add keymaps to git repo

#install powerline fonts for vim-powerline, update fonts cache
cd fonts
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
sudo mv -v PowerlineSymbols.otf /usr/share/fonts/X11/misc
sudo fc-cache -vf
mkdir -p ~/.config/fontconfig/conf.d/
mv -v 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
cd

#echo todo list
echo ‘system76-driver-nvidia \’
echo “get http://www.googleplaymusicdesktopplayer.com/”
echo “mailutils should be installed”

#change ownership of sudo-created files to $USER
sudo chown -Rv $USER:$USER .

#note packages autoinstalled so I can diff from it later
dpkg --get-selections > autoinstall/autoinstalled-packages

#timer output
endtime=$(date +%s)
echo $endtime
echo $((endtime-starttime)) | awk '{print int($1/60)":"int($1%60)}'

#restore std out messages
#exec 1>&3 2>&4 - removed because line 5 (exec 2>&1) was removed
