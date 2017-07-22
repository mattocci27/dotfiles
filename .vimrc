let OSTYPE = system('uname')

if OSTYPE == "Darwin\n"
  source ~/dotfiles/.vimrc_mac
  "source ~/dotfiles/.vimrc_test
elseif OSTYPE == "Linux\n"
  source ~/dotfiles/.vimrc_linux
endif

