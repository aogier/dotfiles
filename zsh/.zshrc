# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

zstyle ':omz:plugins:nvm' lazy yes

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
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true
plugins=(
  docker
  evalcache
  git
  git-flow
  terraform
  zsh-nvm
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

export vagrant=~/dev/vagrant

inject () {
        file=$1
            svn-inject --no-branches --setprops $file https://devel.ieo.eu/svn/public/packages
}

sbp () {
        svn-buildpackage \
                --svn-builder='pdebuild --pbuilder cowbuilder --buildresult /tmp/ -- --basepath /var/cache/pbuilder/wheezy-amd64 ' "$@"

}

p () {
        pdebuild --pbuilder cowbuilder --buildresult /tmp/ -- --basepath /var/cache/pbuilder/${DIST:-stretch-amd64}/ "$@"
}

copysrc () {
        sudo -u incoming reprepro -b /srv/repositories/main/ copysrc wheezy-ieo sid-ieo "$@"
}


export PATH=$HOME/.local/bin:$PATH
alias ipython='ipython3 --colors=Linux'
export WORKON_HOME=$HOME/.virtualenvs

PROMPT='${ret_status}%{$fg_bold[green]%}%p %{$fg_bold[white]%}%n@%m %{$fg[cyan]%}%~ %{$fg_bold[blue]%}$(git_prompt_info)$(hg_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

zstyle ':completion:*' special-dirs true
unsetopt share_history

c() {

    if [[ $1 == /* ]]; then
        p=$1
        shift
    else
        p=''
    fi

    curl -sH 'Content-Type: application/json' \
        http://admin:K7fowAEvA2Yf4ankMKrbz5zT5hxR3UTSidFSob4uK9QHbYwS@couchdb.devops.scimmia.net$p "$@" | jq .


}

e() {

    if [[ $1 == /* ]]; then
        p=$1
        shift
    else
        p=''
    fi

    curl -sH 'Content-Type: application/json' \
        http://localhost:9200$p "$@" | jq .

}

alias ccc=chachacha

autoload bashcompinit && bashcompinit
complete -C aws_completer aws

#source <(helm completion zsh)
_evalcache helm completion zsh

#alias k='kubectl --insecure-skip-tls-verify'
alias k='kubectl'
_evalcache kubectl completion zsh
complete -F __start_kubectl k
#export KUBECONFIG=~/.kube/lendbox-dev:~/.kube/lendbox-prod:~/.kube/iubenda:~/.kube/k3s:~/.kube/guardian-fra-kubeconfig.yaml:~/.kube/guardian-lon-kubeconfig.yaml:~/.kube/iub-logs-kubeconfig.yaml:~/.kube/k3s.yaml:~/.kube/k0s.yaml
export KUBECONFIG=~/.kube/empty.yaml
export KUBECONFIG=$KUBECONFIG:$(find ~/.kube/clusters -type f|grep -v lock | xargs echo | sed 's/ /:/g')

export GPG_TTY=$(tty)

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
#_evalcache $HOME/.zinit/bin/zinit.zsh

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

#zplugin light jonmosco/kube-ps1
#PROMPT='$(kube_ps1)'$PROMPT
#export \
#	KUBE_PS1_SYMBOL_ENABLE=false
#	KUBE_PS1_NS_ENABLE=false
#	KUBE_PS1_PREFIX=
#	KUBE_PS1_SUFFIX=


alias cabbesa='k -n default exec -it deploy/cabbesa -- bash'


autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc

export PATH=$PATH:~/.bin

export PATH="/home/oggei/.pyenv/bin:$PATH"
#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"
_evalcache pyenv init -
_evalcache pyenv virtualenv-init -


ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}(%{$fg[red]%}"


alias gitk='gitk&; disown'

export PATH=$(pyenv root)/shims:$PATH

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

alias cal='ncal -b'


fpath+=~/.zsh/completion

export DOCKER_BUILDKIT=1

alias git='git -P'
#compdef cdktf
###-begin-cdktf-completions-###
#
# yargs command completion script
#
# Installation: ../../node_modules/.bin/cdktf completion >> ~/.zshrc
#    or ../../node_modules/.bin/cdktf completion >> ~/.zprofile on OSX.
#
_cdktf_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" ../../node_modules/.bin/cdktf --get-yargs-completions "${words[@]}"))
  IFS=$si
  _describe 'values' reply
}
compdef _cdktf_yargs_completions cdktf
###-end-cdktf-completions-###

alias cdktf="npx cdktf"

#alias vi='() {
#	xdotool key CTRL+minus CTRL+minus CTRL+minus  2>/dev/null
#	vim $1
#	xdotool key ctrl+0
#}'

alias vim=vi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

_evalcache gh completion -s zsh
_evalcache argocd completion zsh


acc (){
	grep -i "$@" ~/dev/waldo/accounts.csv
}

#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export AWS_PAGER=''
export AWS_SHARED_CREDENTIALS_FILE=~/.aws/credentials.pota

export AWS_PROFILE=nsp-main
