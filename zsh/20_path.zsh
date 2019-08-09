# enviromeant variables
case `uname` in
  Darwin)
  export PATH="/usr/local/sbin:/usr/local/bin:/Developer/usr/bin:/Developer/usr/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/opt/:$PATH"
 # export PATH=/usr/lib/pkgconfig:$PATH
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
    ;;
esac

# ruby
export PATH=$HOME/.gem/ruby/2.6.0/bin:$PATH

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

