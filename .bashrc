
case $- in
*i*) ;; # interactive
*) return ;; 
esac

# ----------------------- environment variables ----------------------
#                           (also see envx)

# export GITUSER="$USER"
export GITUSER="rickKoch"
export DOTFILES="$HOME/Repos/github.com/$GITUSER/dotfiles"
export GHREPOS="$HOME/Repos/github.com/$GITUSER/"
export HELP_BROWSER=lynx
export DOCKER_ID="rickkoch"
export SCRIPTS="$DOTFILES/scripts"
export DESKTOP="$HOME/Desktop"
export DOCUMENTS="$HOME/Documents"
export DOWNLOADS="$HOME/Downloads"
export TEMPLATES="$HOME/Templates"
export PUBLIC="$HOME/Public"
export PRIVATE="$HOME/Private"
export PICTURES="$HOME/Pictures"
export MUSIC="$HOME/Music"
export VIDEOS="$HOME/Videos"
export PDFS="$DOCUMENTS/PDFS"
export VIRTUALMACHINES="$HOME/VirtualMachines"
export WORKSPACES="$HOME/Workspaces" # container home dirs for mounting
export ZETDIR="$GHREPOS/notes"
export TERM=xterm-256color
export HRULEWIDTH=73
export EDITOR=vi
export VISUAL=vi
export EDITOR_PREFIX=vi
export PYTHONDONTWRITEBYTECODE=1

test -d ~/.vim/spell && export VIMSPELL=(~/.vim/spell/*.add)

export GOPRIVATE="github.com/$GITUSER/*,gitlab.com/$GITUSER/*"
export GOPATH=~/.local/share/go
export GOBIN=~/.local/bin
export GOPROXY=direct
export CGO_ENABLED=0

# node version manager
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# ------------------------------- pager ------------------------------

if test -x /usr/bin/lesspipe; then
  export LESSOPEN="| /usr/bin/lesspipe %s";
  export LESSCLOSE="/usr/bin/lesspipe %s %s";
fi

# export LESS_TERMCAP_mb="[35m" # magenta
# export LESS_TERMCAP_md="[33m" # yellow
# export LESS_TERMCAP_me="" # "0m"
# export LESS_TERMCAP_se="" # "0m"
# export LESS_TERMCAP_so="[34m" # blue
# export LESS_TERMCAP_ue="" # "0m"
# export LESS_TERMCAP_us="[4m"  # underline

# ----------------------------- dircolors ----------------------------

# if command -v dircolors &>/dev/null; then
  # if test -r ~/.dircolors; then
    # eval "$(dircolors -b ~/.dircolors)"
  # else
    # eval "$(dircolors -b)"
  # fi
# fi

# ------------------------------- path -------------------------------

pathappend() {
  declare arg
  for arg in "$@"; do
    test -d "${arg}" || continue
    PATH=${PATH//:${arg}:/:}
    PATH=${PATH/#${arg}:/}
    PATH=${PATH/%:${arg}/}
    export PATH="${PATH:+"${PATH}:"}${arg}"
  done
}

pathprepend() {
  for ARG in "$@"; do
    test -d "${ARG}" || continue
    PATH=${PATH//:${ARG}:/:}
    PATH=${PATH/#${ARG}:/}
    PATH=${PATH/%:${ARG}/}
    export PATH="${ARG}${PATH:+":${PATH}"}"
  done
}

# override as needed in .bashrc_{personal,private,work}
# several utilities depend on SCRIPTS being in a github repo
# export SCRIPTS=~/.local/bin/scripts
mkdir -p "$SCRIPTS" &>/dev/null

# remember last arg will be first in path
pathprepend \
  /usr/local/go/bin \
  ~/.local/bin \
  "$SCRIPTS" 

pathappend \
  /usr/local/opt/coreutils/libexec/gnubin \
  /mingw64/bin \
  /usr/local/bin \
  /usr/local/sbin \
  /usr/local/games \
  /usr/games \
  /usr/sbin \
  /usr/bin \
  /snap/bin \
  /sbin \
  /bin

# ------------------------------ cdpath ------------------------------

export CDPATH=.:\
~/repos/github.com:\
~/repos/github.com/$GITUSER:\
~/repos/github.com/$GITUSER/dot:\
~/repos:\
/media/$USER:\
~

# ------------------------ bash shell options ------------------------

shopt -s checkwinsize
shopt -s expand_aliases
shopt -s globstar
shopt -s dotglob
shopt -s extglob
#shopt -s nullglob # bug kills completion for some
#set -o noclobber

# ------------------------------ history -----------------------------

export HISTCONTROL=ignoreboth
export HISTSIZE=5000
export HISTFILESIZE=10000

set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'
shopt -s histappend

# --------------------------- smart prompt ---------------------------

PROMPT_LONG=20
PROMPT_MAX=95
PROMPT_AT=@

__ps1() {
  local P='$' dir="${PWD##*/}" B countme short long double\
    r='\[\e[31m\]' g='\[\e[30m\]' h='\[\e[34m\]' \
    u='\[\e[33m\]' p='\[\e[33m\]' w='\[\e[35m\]' \
    b='\[\e[36m\]' x='\[\e[0m\]'

  [[ $EUID == 0 ]] && P='#' && u=$r && p=$u # root
  [[ $PWD = / ]] && dir=/
  [[ $PWD = "$HOME" ]] && dir='~'

  B=$(git branch --show-current 2>/dev/null)
  [[ $dir = "$B" ]] && B=.
  countme="$USER$PROMPT_AT$(hostname):$dir($B)\$ "

  [[ $B = master || $B = main ]] && b="$r"
  [[ -n "$B" ]] && B="$g($b$B$g)"

  short="$u\u$g$PROMPT_AT$h\h$g:$w$dir$B$p$P$x "
  long="$g╔ $u\u$g$PROMPT_AT$h\h$g:$w$dir$B\n$g╚ $p$P$x "
  double="$g╔ $u\u$g$PROMPT_AT$h\h$g:$w$dir\n$g║ $B\n$g╚ $p$P$x "

  if (( ${#countme} > PROMPT_MAX )); then
    PS1="$double"
  elif (( ${#countme} > PROMPT_LONG )); then
    PS1="$long"
  else
    PS1="$short"
  fi
}

PROMPT_COMMAND="__ps1"

# ----------------------------- keyboard -----------------------------

test -n "$DISPLAY" && setxkbmap -option caps:escape &>/dev/null

# ------------------------------ aliases -----------------------------

unalias -a
alias grep='grep -i --colour=auto'
alias egrep='egrep -i --colour=auto'
alias fgrep='fgrep -i --colour=auto'
alias curl='curl -L'
alias ls='ls -h --color=auto'
alias '?'=duck
alias '??'=google
alias '???'=bing
alias x="exit"
alias sl="sl -e"
alias mkdirisosec='d=$(isosec);mkdir $d; cd $d'
alias main='cd $(work main)'
alias dot='cd $DOTFILES'
alias scripts='cd $SCRIPTS'
alias free='free -h'
alias df='df -h'
alias top=htop
alias chmox='chmod +x'
alias sshh='sshpass -f $HOME/.sshpass ssh '
alias temp='cd $(mktemp -d)'
alias view='vi -R' # which is usually linked to vim
alias c='printf "\e[H\e[2J"'
alias clear='printf "\e[H\e[2J"'
alias l='ls -alh'
alias md='mkdir'
alias ..='cd ..'
alias update='source $HOME/.bashrc'
alias bashrc='vim $HOME/.bashrc'

which vim &>/dev/null && alias vi=vim

# ----------------------------- functions ----------------------------

envx() {
  local envfile="$1"
  if test ! -e "$envfile" ; then
    if test ! -e ~/.env ; then
      echo "file not found: $envfile"
      return
    fi
    envfile=~/.env
  fi
  while IFS=$'\n' read -r line; do
    name=${line%%=*}
    value=${line#*=}
    if [[ -z "${name}" || $name =~ ^# ]]; then
      continue
    fi
    export "$name"="$value"
  done <"${envfile}"
} && export -f envx

test -e ~/.env && envx ~/.env 

newcmd() {
  name="$1"
  test -z "$name" && echo "usage: newcmd <name>" && return 1
  test -z "$GHREPOS" && echo "GHREPOS not set" && return 1
  test ! -d "$GHREPOS" && echo "Not found: $GHREPOS" && return 1
  test -e "cmdbox-$name" && echo "exists: cmdbox-$name" && return 1
  cd "$GHREPOS"
  gh repo create -p rickKoch/cmdbox-_foo "cmdbox-$name"
  cd "cmdbox-$name"
} && export -f newcmd

# ------------- source external dependencies / completion ------------

owncomp=(
  pdf md zet yt gl kn auth pomo config iam
  sshkey ws ./build build b ./setup
)

for i in ${owncomp[@]}; do complete -C $i $i; done

type gh &>/dev/null && . <(gh completion -s bash)
type pandoc &>/dev/null && . <(pandoc --bash-completion)
type kubectl &>/dev/null && . <(kubectl completion bash)
type kind &>/dev/null && . <(kind completion bash)
type yq &>/dev/null && . <(yq shell-completion bash)
type helm &>/dev/null && . <(helm completion bash)
type docker &>/dev/null && . ~/.local/share/docker/completion # with d

type k &>/dev/null && complete -o default -F __start_kubectl k

# -------------------- personalized configuration --------------------

test -r ~/.bash_personal && source ~/.bash_personal
test -r ~/.bash_private && source ~/.bash_private
test -r ~/.bash_work && source ~/.bash_work

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
