let OSTYPE = system('uname')

if OSTYPE == "Darwin\n"
  source ~/dotfiles/.vimrc_mac
elseif OSTYPE == "Linux\n"
  source ~/dotfiles/.vimrc_linux
endif

