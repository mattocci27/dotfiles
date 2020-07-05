# enviromeant variables
case `uname` in
  Darwin)
  export PATH="/usr/local/sbin:/usr/local/bin:/Developer/usr/bin:/Developer/usr/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/opt:/usr/lib/$PATH"
  export PATH="/usr/local/opt/avr-gcc@8/bin:$PATH"
  export PATH=/usr/lib/python3.7/site-packages:$PATH
  export PATH=$PATH:/Users/mattocci/mutagen_darwin_amd64_v0.11.4
 # export PYENV_ROOT="${HOME}/.pyenv"
 # export PATH="${PYENV_ROOT}/bin:$PATH"
 # eval "$(pyenv init -)"
 # export PATH=$HOME/.nodebrew/current/bin:$PATH
 # export HOMEBREW_CASK_OPTS="--appdir=/Applications"
 # export R_LIBS_USER R_LIBS=Testing_Tmux
 # export PATH=/Library/TeX/Root/bin/x86_64-darwin:$PATH
 # export PATH="$HOME/.cargo/bin:$PATH"
 
 # #go
 # export GOPATH=$HOME
 # export PATH=$PATH:$GOPATH/bin
    ;;
  Linux)
  export PATH=/home/mattocci/.cargo/bin:$PATH
  export http_proxy=socks5://127.0.0.1:52843
  export https_proxy=$http_proxy
  export HTTP_PROXY=$http_proxy
  export HTTPS_PROXY=$http_proxy
  export PATH=~/.config/i3:$PATH
    ;;
esac

# ruby
export PATH=$HOME/.gem/ruby/2.7.0/bin:$PATH

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi


# dotnet
export PATH="~/.dotnet/tools:$PATH"
