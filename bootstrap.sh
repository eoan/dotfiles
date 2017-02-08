# Bootstrap script for git vcs of dotfiles

########## Variables

dir=~/dotfiles		# dotfiles directory
olddir=~/dotfiles_old	# old dotfiles backup directory
exdirs="
	.config/albert
	.config/awesome
	.gconf/apps/guake
	.moc/themes
	"		# list of extra directories to create
files="
	.bashrc
	.bash_aliases
	.config/albert/albert.conf
	.config/awesome/rc.lua
	.conky-google-now
	.conkyrc
	.gconf/apps/guake
	.local/share/fonts/Bembo\ Book\ MT\ Std\ Bold.otf
	.local/share/fonts/Bembo\ Book\ MT\ Std\ Italic.otf
	.local/share/fonts/Bembo\ Book\ MT\ Std\ Regular.otf
	.local/share/fonts/Roboto-Black.ttf
	.local/share/fonts/Roboto-BlackItalic.ttf
	.local/share/fonts/Roboto-Bold.ttf
	.local/share/fonts/Roboto-Medium.ttf
	.local/share/fonts/ufonts.com_gillsans.ttf
	.moc/config
	.moc/themes/ajtrans
	.vim
	.vimrc
	conkyawcal.sh
	conkygcal.sh
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
	mkdir -p ~/$exdir
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
