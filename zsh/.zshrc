# load the path files
for file in $HOME/dotfiles/zsh/.zsh/*.zsh; do
  source $file
done

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# zinit
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light jeffreytse/zsh-vi-mode
ZVM_VI_INSERT_ESCAPE_BINDKEY=jj

# Load pure theme
zinit ice pick"async.zsh" src"pure.zsh" # with zsh-async library that's bundled with it.
zinit light sindresorhus/pure
PURE_CMD_MAX_EXEC_TIME=10
# Set Gruvbox colors
# GRUVBOX_ORANGE="#fe8019"
# GRUVBOX_WHITE="#ebdbb2"
# GRUVBOX_CYAN="#8ec07c"
# GRUVBOX_GRAY="#928374"
# GRUVBOX_GREEN="#98971a"
# zmodload zsh/nearcolor
# zstyle :prompt:pure:user color $GRUVBOX_WHITE
# zstyle :prompt:pure:user color $GRUVBOX_GREEN
# zstyle :prompt:pure:git:stash show yes

eval "$(zoxide init zsh)"

# overwirte
autoload -Uz add-zsh-hook
add-zsh-hook precmd set_fzf_history_widget_keybinding
set_fzf_history_widget_keybinding() {
  bindkey '^R' fzf-history-widget
}
