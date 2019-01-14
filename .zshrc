config_files=($HOME/dotfiles/zsh/*.zsh)

# load the path files
for file in $config_files
do
  source $file
done
