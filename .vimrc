let OSTYPE = system('uname')

if OSTYPE == "Darwin\n"
  source ~/.vimrc_mac
elseif OSTYPE == "Linux\n"
  source ~/.vimrc_linux
endif

