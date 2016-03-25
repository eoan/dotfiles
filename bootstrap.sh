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
