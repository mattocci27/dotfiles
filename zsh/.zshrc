# load the path file# Load the path files
for file in $HOME/dotfiles/zsh/.zsh/*.zsh; do
  source $file
done

# Zinit installation check
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
# zinit self-update
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load annexes without Turbo
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# Plugin installations
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light jeffreytse/zsh-vi-mode
ZVM_VI_INSERT_ESCAPE_BINDKEY=jj

# Pure theme and settings
PURE_CMD_MAX_EXEC_TIME=10
zinit ice pick"async.zsh" src"pure.zsh" # Pure theme async loading
zinit light sindresorhus/pure

# Zoxide initialization
eval "$(zoxide init zsh)"

# Keybindings
add-zsh-hook precmd set_fzf_history_widget_keybinding
set_fzf_history_widget_keybinding() {
  bindkey '^R' fzf-history-widget
  bindkey '^t' fzf-tmux
  bindkey '^g' fzf-src
  bindkey '^x' fzf-cdr
  bindkey '^f' fzf-z-search
}
