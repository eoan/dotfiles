# Bootstrap script for git vcs of dotfiles

########## Variables

dir=~/dotfiles		# dotfiles directory
olddir=~/dotfiles_old	# old dotfiles backup directory
exdirs="
	.config/awesome
	.moc/themes
	.gconf/apps/guake/general
	.gconf/apps/guake/keybindings/global
	.gconf/apps/guake/keybindings/local
	.gconf/apps/guake/style/background
	.gconf/apps/guake/style/font
	.conky-google-now
	"		# list of extra directories to create
files="
	.bashrc
	.bash_aliases
	.vimrc
	.vim
	.config/awesome/rc.lua
	.moc/config
	.moc/themes/ajtrans
	.gconf/apps/guake/%gconf.xml
	.gconf/apps/guake/general/%gconf.xml
	.gconf/apps/guake/keybindings/%gconf.xml
	.gconf/apps/guake/keybindings/global/%gconf.xml
	.gconf/apps/guake/keybindings/local/%gconf.xml
	.gconf/apps/guake/style/%gconf.xml
	.gconf/apps/guake/style/background/%gconf.xml
	.gconf/apps/guake/style/font/%gconf.xml
	.conkyrc
	conkyawcal.sh
	conkygcal.sh
	.conky-google-now/0.png
	.conky-google-now/1.png
	.conky-google-now/2.png
	.conky-google-now/3.png
	.conky-google-now/4.png
	.conky-google-now/5.png
	.conky-google-now/6.png
	.conky-google-now/7.png
	.conky-google-now/8.png
	.conky-google-now/9.png
	.conky-google-now/10.png
	.conky-google-now/11.png
	.conky-google-now/12.png
	.conky-google-now/13.png
	.conky-google-now/14.png
	.conky-google-now/15.png
	.conky-google-now/16.png
	.conky-google-now/17.png
	.conky-google-now/18.png
	.conky-google-now/19.png
	.conky-google-now/20.png
	.conky-google-now/21.png
	.conky-google-now/22.png
	.conky-google-now/23.png
	.conky-google-now/24.png
	.conky-google-now/25.png
	.conky-google-now/26.png
	.conky-google-now/27.png
	.conky-google-now/28.png
	.conky-google-now/29.png
	.conky-google-now/30.png
	.conky-google-now/31.png
	.conky-google-now/32.png
	.conky-google-now/33.png
	.conky-google-now/34.png
	.conky-google-now/35.png
	.conky-google-now/36.png
	.conky-google-now/37.png
	.conky-google-now/38.png
	.conky-google-now/39.png
	.conky-google-now/40.png
	.conky-google-now/41.png
	.conky-google-now/42.png
	.conky-google-now/43.png
	.conky-google-now/44.png
	.conky-google-now/45.png
	.conky-google-now/46.png
	.conky-google-now/47.png
	.conky-google-now/3200.png
	.conky-google-now/humidity.png
	.conky-google-now/wind.png
	"		# list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# create extra directories
echo "Creating extra directories"
for exdir in $exdirs; do
	tbp=$olddir/$exdir
	mkdir -p $tbp
	echo "Created $exdir"
done
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
echo "Moving dotfiles from ~ to $olddir"
for file in $files; do
	echo "Moving $file to $olddir"
	mv ~/$file $olddir/$file
	echo "Creating symlink to $file in home directory."
	ln -s $dir/$file ~/$file
done

echo Go to https://powerline.readthedocs.org/en/master/installation/linux.html
echo You need python-pip, then pip install --user powerline-status, then sort fonts

source ~/.bashrc
