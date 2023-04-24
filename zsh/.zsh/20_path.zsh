# enviromeant variables
case `uname` in
  Darwin)
  export PATH="/usr/local/sbin:/usr/local/bin:/Developer/usr/bin:/Developer/usr/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/opt:/usr/lib/$PATH"
  export PATH="/usr/local/opt/avr-gcc@8/bin:$PATH"
  export PATH=$PATH:/opt/yarn-v1.22.4/bin
  export PATH=$PATH:/Applications/Julia-1.7.app/Contents/Resources/julia/bin/
  export PATH="/usr/local/opt/openjdk/bin:$PATH"
  export PATH="/usr/bin:$PATH"
  export PATH="$HOME/.cargo/bin:$PATH"
  export PATH="$PATH:$HOME/bin/context/tex/texmf-osx-arm64/bin:"
  export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
  export PATH="$HOME/.local/bin:$PATH"
  export PATH="$PATH:$HOME/Library/TinyTeX/bin/universal-darwin"
  export PATH=$HOME/context/tex/texmf-osx-arm64/bin:$PATH

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

# pyenv
if [ `uname` = "Darwin" ]; then
    if command -v pyenv 1>/dev/null 2>&1; then
      eval "$(pyenv init --path)"
    fi
fi

# ranger for now
export PATH=~/Dropbox/src/github.com/ranger/ranger:$PATH
alias ranger='ranger.py'
