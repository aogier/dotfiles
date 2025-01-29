# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

ZSH_THEME="powerlevel10k/powerlevel10k"
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  docker
  evalcache
  git
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export DEBEMAIL='alessandro.ogier@gmail.com'
export DEBFULLNAME='Alessandro -oggei- Ogier'

export PATH=$HOME/.local/bin:$HOME/.local/scripts:$PATH

PROMPT='${ret_status}%{$fg_bold[green]%}%p %{$fg_bold[white]%}%n@%m %{$fg[cyan]%}%~ %{$fg_bold[blue]%}$(git_prompt_info)$(hg_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

zstyle ':completion:*' special-dirs true
unsetopt share_history

alias cabbesa='k -n default exec -it deploy/cabbesa -- bash'
alias cal='ncal -b'
alias ccc=chachacha
alias cdktf='npx cdktf'
alias cdk='npx cdk'
alias git='git -P'
alias gitk='gitk&; disown'
alias ipython='ipython3 --colors=Linux'
alias k=kubectl
alias p='poetry run pulumi'
alias cat='bat -pp'
alias less='bat -p'
#alias vi='emacsclient -r -n'
#alias vi=nvim

vi() {
	if [ -n "$DISPLAY" ]
	then
		emacsclient -r -n "$@"
	else
		emacsclient -c "$@"
	fi
}

export AWS_PAGER=''
export AWS_PROFILE=nsp-main
export DOCKER_BUILDKIT=1
export GPG_TTY=$(tty)
#export PATH="/home/oggei/.pyenv/bin:${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

autoload bashcompinit && bashcompinit
_evalcache helm completion zsh
_evalcache kubectl completion zsh
_evalcache pulumi gen-completion zsh
complete -C aws_completer aws
complete -F __start_kubectl k
_evalcache tkn completion zsh

#### Added by Zinit's installer
#if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
#    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
#    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
#    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
#        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
#        print -P "%F{160}▓▒░ The clone has failed.%f%b"
#fi
#
#source "$HOME/.zinit/bin/zinit.zsh"
#
#autoload -Uz _zinit
#(( ${+_comps} )) && _comps[zinit]=_zinit
#### End of Zinit's installer chunk

zstyle ':completion:*' menu select

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}(%{$fg[red]%}"


# https://wiki.archlinux.org/title/zsh#Persistent_rehash
zshcache_time="$(date +%s%N)"

autoload -Uz add-zsh-hook

rehash_precmd() {
  if [[ -a /var/cache/zsh_cache ]]; then
    local paccache_time="$(date -r /var/cache/zsh_cache +%s%N)"
    if (( zshcache_time < paccache_time )); then
      rehash
      zshcache_time="$paccache_time"
    fi
  fi
}

add-zsh-hook -Uz precmd rehash_precmd

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

acc (){
	grep -i "$@" ~/dev/waldo/accounts.csv
}


# add Pulumi to the PATH

# vi () {

#     _pwd=$PWD
#     exe=/home/oggei/.local/bin/lvim

#     while [ $_pwd != / ]
#     do
#         if [ -f poetry.lock ]
#         then
#             poetry run $exe $@
#             return
#         fi
#         _pwd=$(dirname $_pwd)
#     done

#     $exe $@

# }

eval "$(~/.local/bin/mise activate zsh)"

#KUBECONFIG="~/.kube/empty.yaml:$(find ~/.kube/clusters -type f|grep -v lock | xargs echo | sed 's/ /:/g')" \
#  /home/oggei/.local/share/mise/installs/kubectl/latest/bin/kubectl config view --flatten > ~/.kube/config

export PATH="$HOME/.config/emacs/bin:$PATH"

export PATH="$HOME/.npm-global/bin:$PATH"

export PATH="$HOME/go/bin:$PATH"


#unalias run-help
autoload run-help
HELPDIR=/usr/share/zsh/"${ZSH_VERSION}"/help
alias help=run-help

export HISTSIZE=250000
export SAVEHIST=50000

if [ "$SSH_CLIENT" ]; then
   # I have logged in via SSH
   export PINENTRY_USER_DATA=USE_CURSES
fi
export GPG_TTY=`tty`

setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

. "$HOME/.cargo/env"
if [ -f ~/.zshrc.local ]
then
    . ~/.zshrc.local
fi
