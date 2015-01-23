# Bootstrap script for git vcs of dotfiles

########## Variables

dir=~/dotfiles		# dotfiles directory
olddir=~/dotfiles_old	# old dotfiles backup directory
exdirs="
	.config/awesome
	"		# list of extra directories to create
files="
	.bashrc
	.bash_aliases
	.vimrc
	.vim
	.config/awesome/rc.lua
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
	mv ~/$file ~/dotfiles_old/$file
	echo "Creating symlink to $file in home directory."
	ln -s $dir/$file ~/$file
done

source ~/.bashrc
