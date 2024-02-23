# Reset PATH to a base value at the beginning of the script
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# Function to add a directory to PATH if it's not already included
add_to_path() {
    case ":$PATH:" in
        *":$1:"*) ;; # If path is already in PATH, do nothing
        *) export PATH="$1:$PATH" ;; # Otherwise, add it to the beginning of PATH
    esac
}

# Base PATH modifications
add_to_path "$HOME/.local/bin"
add_to_path "$HOME/.cargo/bin"
add_to_path "$HOME/.gem/ruby/2.7.0/bin"
add_to_path "$HOME/.pyenv/bin"
add_to_path "$HOME/.dotnet/tools"

# Conditional configurations for Darwin (macOS)
if [[ "$(uname)" == "Darwin" ]]; then
    add_to_path "/usr/local/opt"
    add_to_path "/usr/local/opt/avr-gcc@8/bin"
    add_to_path "/opt/yarn-v1.22.4/bin"
    add_to_path "$HOME/.juliaup/bin"
    add_to_path "/usr/local/opt/openjdk/bin"
    add_to_path "$HOME/bin/context/tex/texmf-osx-arm64/bin"
    add_to_path "$HOME/Library/TinyTeX/bin/universal-darwin"
    add_to_path "$HOME/context/tex/texmf-osx-arm64/bin"
    add_to_path "$HOME/Dropbox/src/github.com/ranger/ranger"
    add_to_path "/opt/homebrew/bin:$PATH"
    export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
elif [[ "$(uname)" == "Linux" ]]; then
    add_to_path "$HOME/.config/i3"
    add_to_path "/usr/local/go/bin"
    add_to_path "$HOME/go/bin"
    add_to_path "$HOME/quarto-cli/package/dist/bin/quarto"
    if [[ "$(lsb_release -si)" == "microsoft" ]]; then
        # Configuration for WSL2
        export DISPLAY="$(awk '/nameserver/ {print $2}' /etc/resolv.conf):0"
    fi
fi
