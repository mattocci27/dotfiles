# Base PATH modifications
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"
export PATH="$HOME/.pyenv/bin:$PATH"
export PATH="$HOME/.dotnet/tools:$PATH"
export PATH="$HOME/Dropbox/src/github.com/ranger/ranger:$PATH"

# Conditional configurations for Darwin (macOS)
if [[ "$(uname)" == "Darwin" ]]; then
    export PATH="/usr/local/sbin:$PATH"
    export PATH="/usr/local/bin:$PATH"
    export PATH="/Developer/usr/bin:$PATH"
    export PATH="/Developer/usr/sbin:$PATH"
    export PATH="/usr/bin:$PATH"
    export PATH="/bin:$PATH"
    export PATH="/usr/sbin:$PATH"
    export PATH="/sbin:$PATH"
    export PATH="/usr/local/opt:$PATH"
    export PATH="/usr/lib:$PATH"
    export PATH="/usr/local/opt/avr-gcc@8/bin:$PATH"
    export PATH="/opt/yarn-v1.22.4/bin:$PATH"
    export PATH="/Applications/Julia-1.7.app/Contents/Resources/julia/bin:$PATH"
    export PATH="/usr/local/opt/openjdk/bin:$PATH"
    export PATH="$HOME/bin/context/tex/texmf-osx-arm64/bin:$PATH"
    export PATH="$HOME/Library/TinyTeX/bin/universal-darwin:$PATH"
    export PATH="$HOME/context/tex/texmf-osx-arm64/bin:$PATH"
    export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
elif [[ "$(uname)" == "Linux" ]]; then
    export PATH="$HOME/.config/i3:$PATH"
    export PATH="$HOME/.local/bin:$PATH"
    if [[ "$(lsb_release -si)" == "microsoft" ]]; then
        # Configuration for WSL2
        export DISPLAY="$(awk '/nameserver/ {print $2}' /etc/resolv.conf):0"
    fi
fi

# Conditional configuration for ARM architecture
if [[ "$(uname -m)" == 'arm64' ]]; then
    PROMPT="[a] %m:%~%# "
    export PATH="/opt/homebrew/bin:$PATH"
else
    PROMPT="[x] %m:%~%# "
fi

# Ruby configuration
if which rbenv >/dev/null 2>&1; then eval "$(rbenv init -)"; fi

# Pyenv initialization for macOS
if [[ "$(uname)" == "Darwin" ]] && command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init --path)"
fi

