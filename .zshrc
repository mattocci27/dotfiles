# enviromeant variables -------------------------------------------------------
# export LANG=ja_JP.UTF-8
#export PYTHONPATH=/usr/local/lib/python3.6/site-packages:$PYTHONPATH
#

case `uname` in
  Darwin)
  export PATH="/usr/local/sbin:/usr/local/bin:/Developer/usr/bin:/Developer/usr/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
  # use home brew packages
  export PATH=/usr/local/bin:/usr/bin:$PATH
  export PATH=/usr/local/opt/llvm/bin:$PATH
  export PATH=/usr/local/opt/xz/bin:$PATH
  export PATH=$HOME/context/tex/texmf-osx-64/bin:$PATH
  # Python version management: pyenv
  export PYENV_ROOT="${HOME}/.pyenv"
  export PATH="${PYENV_ROOT}/bin:$PATH"
  eval "$(pyenv init -)"

  export PATH=$HOME/.nodebrew/current/bin:$PATH
  export PATH=/usr/local/opt/qt5/bin:$PATH
  export HOMEBREW_CASK_OPTS="--appdir=/Applications"

  export R_LIBS_USER R_LIBS=Testing_Tmux

  export PATH=/Library/TeX/Root/bin/x86_64-darwin:$PATH

  # rsut
  export PATH="$HOME/.cargo/bin:$PATH"

  #go
  export GOPATH=$HOME
  export PATH=$PATH:$GOPATH/bin
    ;;
  Linux)
    ;;
esac

# ruby
export PATH=$HOME/.gem/ruby/2.5.0/bin:$PATH

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
 w

# locale
# without this, tmux does not recognize some fonts
export LANG=en_US.UTF-8

# colors ---------------------------------------------------------------------
autoload -Uz colors
colors

# Vi mode
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode
bindkey -M vicmd 'L' vi-end-of-line
bindkey -M vicmd 'H' vi-first-non-blank

function zle-line-init zle-keymap-select {
  #VIM_NORMAL="%K{120}%F{235}⮀%k%f%K{120}%F{235} % NORMAL %k%f%K{263239}%F{120}⮀%k%f"
  VIM_NORMAL="%F{black}%K{yellow} NORMAL %F{yellow}"
  VIM_INSERT="%K{075}%F{235}%k%f%K{075}%F{235} % INSERT %k%f%K{263238}%F{075}%k%f"
  RPS1="${${KEYMAP/vicmd/$VIM_NORMAL}/(main|viins)/$VIM_INSERT}"
  RPS2=$RPS1
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1

# hitory
HISTFILE=~/.zsh_history
# This is about for a month
HISTSIZE=1000000
# This is about for a year
SAVEHIST=1000000

# プロンプト
# 1行表示
# PROMPT="%~ %# "
# 2行表示
#PROMPT="%{${fg[green]}%}[%n@%m]%{${reset_color}%} %~
#%# "


#PROMPT=$RPROMPT'${vcs_info_msg_0_}'
#RPROMPT="%{${fg[blue]}%}[%~]%{${reset_color}%}
#%#"
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:*' use-simple true
#zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
#zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
#zstyle ':vcs_info:*' formats "%F{green}%c%u%b%f" "%R"
zstyle ':vcs_info:git:*' stagedstr "%F{242}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{242}+"
zstyle ':vcs_info:*' formats "%F{242}%c%u%b%f" "%R"
zstyle ':vcs_info:*' actionformats '%b|%a' '%R'
precmd () { vcs_info }
PROMPT='
%{${fg[blue]}%}%~%{${reset_color}%  ${vcs_info_msg_0_}
%{${fg[magenta]}%}> %{${reset_color}%}'

#PROMPT='%{${fg[blue]}%}%~%{${reset_color}% %{${fg[magenta]}%}> %{${reset_color}%}'
#PROMPT='${vcs_info_msg_0_}'


# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

########################################
# autocomplete
#
#autoload -Uz compinit
## give -C to ignore compinit security check
#compinit -C
#
## 補完で小文字でも大文字にマッチさせる
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
#
## ../ の後は今いるディレクトリを補完しない
#zstyle ':completion:*' ignore-parents parent pwd ..
#
## sudo の後ろでコマンド名を補完する
#zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
#                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
#
## ps コマンドのプロセス名補完
#zstyle ':completion:*:processes' command 'ps x -o pid,s,args'


########################################
# vcs_info
#autoload -Uz vcs_info
#autoload -Uz add-zsh-hook
#
#zstyle ':vcs_info:*' formats '%F{green}(%s)-[%b]%f'
#zstyle ':vcs_info:*' actionformats '%F{red}(%s)-[%b|%a]%f'
#
#function _update_vcs_info_msg() {
#    LANG=en_US.UTF-8 vcs_info
#    RPROMPT="${vcs_info_msg_0_}"
#}
#add-zsh-hook precmd _update_vcs_info_msg


########################################
# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# Ctrl+Dでzshを終了しない
setopt ignore_eof

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 高機能なワイルドカード展開を使用する
setopt extended_glob

########################################
# キーバインド

# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
# bindkey '^R' history-incremental-pattern-search-backward

########################################
# エイリアス

[ 'uname' = "Linux" ] && alias open='xdg-open'

alias la='ls -a'
alias ll='ls -l'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

alias vms='vim -c "source ~/dotfiles/.vimrc_w"'

#alias mvim='mvim -c "source ~/dotfiles/.vimrc_w"'

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'

# vim
alias v='vim'


# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi



########################################
# OS 別の設定
case ${OSTYPE} in
    darwin*)
        #Mac用の設定
        export CLICOLOR=1
        alias ls='ls -G -F'
        ;;
    linux*)
        #Linux用の設定
        alias ls='ls -F --color=auto'
        ;;
esac

#
#
# vim:set ft=zsh:

# PECO ------------------------------------------------------------------------
# function for peco
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
      eval $tac | \
      peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# ### search a destination from cdr list
function peco-get-destination-from-cdr() {
  cdr -l | \
  sed -e 's/^[[:digit:]]*[[:blank:]]*//' | \
  awk '{c=gsub("/","/"); print c,length($0),$0}' | \
  sort -n | \
  cut -d' ' -f1- | \
  peco --query "$LBUFFER"
}

### search a destination from cdr list and cd the destination
function peco-cdr() {
  local destination="$(peco-get-destination-from-cdr)"
  if [ -n "$destination" ]; then
    BUFFER="cd $destination"
    zle accept-line
  else
    zle reset-prompt
  fi
}
zle -N peco-cdr
bindkey '^x' peco-cdr


##
# select tmux session
#
#

function _cool-peco-insert-command-line() {
  if zle; then
    BUFFER=$1
    CURSOR=$#BUFFER
    zle clear-screen
  else
    print -z $1
  fi
}

function peco-tmux() {
  local res
  res=$(tmux list-sessions | peco | awk -F':' '{print $1}')
  if [ -n "$res" ]; then
    _cool-peco-insert-command-line "tmux attach -t $res"
  fi
}
zle -N peco-tmux
bindkey '^t' peco-tmux

##
# select git repository by ghq command
#
function peco-ghq() {
  local res
  res=$(ghq list | peco --query "$LBUFFER")
  if [ -n "$res" ]; then
    _cool-peco-insert-command-line "cd $(ghq root)/$res"
  fi
}
zle -N peco-ghq
bindkey '^g' peco-ghq

# ghq
function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src
# display ssh
# -----------------------------------------------------------------
function ssh() {
  if [[ -n $(printenv TMUX) ]]
  then
    local window_name=$(tmux display -p '#{window_name}')
    tmux rename-window -- "$@[-1]" # zsh specified
    # tmux rename-window -- "${!#}" # for bash
    command ssh $@
    tmux rename-window $window_name
  else
    command ssh $@
  fi
}

# z plug -----------------------------------------------------------
#
source ~/.zplug/init.zsh

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-completions"

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# プラグインを読み込み、コマンドにパスを通す
zplug load --verbose
