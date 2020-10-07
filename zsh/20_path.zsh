# enviromeant variables
case `uname` in
  Darwin)
  export PATH="/usr/local/sbin:/usr/local/bin:/Developer/usr/bin:/Developer/usr/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/opt:/usr/lib/$PATH"
  export PATH="/usr/local/opt/avr-gcc@8/bin:$PATH"
  export PATH=/usr/lib/python3.7/site-packages:$PATH
  export PATH=$PATH:/Users/mattocci/mutagen_darwin_amd64_v0.11.4
  export PATH=$PATH:/opt/yarn-v1.22.4/bin
 # export PYENV_ROOT="${HOME}/.pyenv"
 # export PATH="${PYENV_ROOT}/bin:$PATH"
 # eval "$(pyenv init -)"
 # export PATH=$HOME/.nodebrew/current/bin:$PATH
 # export HOMEBREW_CASK_OPTS="--appdir=/Applications"
 # export R_LIBS_USER R_LIBS=Testing_Tmux
 # export PATH=/Library/TeX/Root/bin/x86_64-darwin:$PATH
 # export PATH="$HOME/.cargo/bin:$PATH"
  export DISPLAY=localhost:0.0
 # #go
 # export GOPATH=$HOME
 # export PATH=$PATH:$GOPATH/bin
    ;;
  Linux)
  export PATH=/home/mattocci/.cargo/bin:$PATH
  #export http_proxy=socks5://127.0.0.1:52843
  #export https_proxy=$http_proxy
  #export HTTP_PROXY=$http_proxy
  #export HTTPS_PROXY=$http_proxy
  export PATH=~/.config/i3:$PATH
  export PATH=~/.local/bin:$PATH
  export PATH=/usr/local/go/bin:$PATH
  #export PATH=~/.squashfs-root/usr/bin:$PATH
  #
  #WSL2 
  #
  export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
  #export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
  #export LIBGL_ALWAYS_INDIRECT=1
    ;;
esac

# ruby
export PATH=$HOME/.gem/ruby/2.7.0/bin:$PATH

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi


# dotnet
export PATH="~/.dotnet/tools:$PATH"

