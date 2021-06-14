# enviromeant variables
case `uname` in
  Darwin)
  export PATH="/usr/local/sbin:/usr/local/bin:/Developer/usr/bin:/Developer/usr/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/opt:/usr/lib/$PATH"
  export PATH="/usr/local/opt/avr-gcc@8/bin:$PATH"
  export PATH=/usr/lib/python3.7/site-packages:$PATH
  export PATH=$PATH:/Users/$USER/mutagen_darwin_amd64_v0.11.4
  export PATH=$PATH:/opt/yarn-v1.22.4/bin
  export PATH="/usr/local/opt/openjdk/bin:$PATH"
  export PATH="/Users/$USER/Library/Python/3.8/bin:$PATH"
  export PATH="/opt/homebrew/bin:$PATH"
  export PATH="/usr/bin:$PATH"
  export PATH=$PATH:/opt/homebrew/opt/ccache/libexec
  export PATH="$HOME/.cargo/bin:$PATH"
  export DISPLAY=localhost:0.0
  export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
    ;;
  Linux)
  export PATH=/home/$USER/.cargo/bin:$PATH
  export PATH=~/.config/i3:$PATH
  export PATH=~/.local/bin:$PATH
  export PATH=/usr/local/go/bin:$PATH
  #
  case `lsb_release -si` in
    microsoft)
    #WSL2
    export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
    ;;
esac
    ;;
esac

# ruby
export PATH=$HOME/.gem/ruby/2.7.0/bin:$PATH

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi


# dotnet
export PATH="~/.dotnet/tools:$PATH"


# ARM or Intel
ARCH=`uname -m`
if [[ $ARCH == 'arm64' ]]; then
    PROMPT="[a] %m:%~%# "
    export PATH=/opt/homebrew/bin:$PATH
else
    PROMPT="[x] %m:%~%# "
fi
