# hitory
HISTFILE=~/.zsh_history
# This is about for a month
HISTSIZE=1000000
# This is about for a year
SAVEHIST=1000000

# vsc_info
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:*' use-simple true
zstyle ':vcs_info:git:*' stagedstr "%F{242}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{242}+"
zstyle ':vcs_info:*' formats "%F{242}%c%u%b%f" "%R"
zstyle ':vcs_info:*' actionformats '%b|%a' '%R'
precmd () { vcs_info }
PROMPT='
%{${fg[blue]}%}%~%{${reset_color}%  ${vcs_info_msg_0_}
%{${fg[magenta]}%}> %{${reset_color}%}'

autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

########################################
setopt print_eight_bit # japanese
setopt no_beep
setopt no_flow_control
setopt ignore_eof
# '#' as comment
setopt interactive_comments
# cd without cd
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt extended_glob

autoload -Uz colors; colors
#
## Vi mode
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode
bindkey -M vicmd 'L' vi-end-of-line
bindkey -M vicmd 'H' vi-first-non-blank

function zle-line-init zle-keymap-select {
  VIM_NORMAL="%B%F{150}% [% NORMAL]% %{$reset_color%}"
  VIM_INSERT="%B%F{075}% [% INSERT]% %{$reset_color%}"
  RPS1="${${KEYMAP/vicmd/$VIM_NORMAL}/(main|viins)/$VIM_INSERT}"
  RPS2=$RPS1
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1
