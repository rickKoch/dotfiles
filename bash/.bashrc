
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

# ------------------------------- pager ------------------------------

if test -x /usr/bin/lesspipe; then
  export LESSOPEN="| /usr/bin/lesspipe %s";
  export LESSCLOSE="/usr/bin/lesspipe %s %s";
fi

export LESS_TERMCAP_mb="$(printf '\e[1;31m')" \
export LESS_TERMCAP_md="$(printf '\e[1;31m')" \
export LESS_TERMCAP_me="$(printf '\e[0m')" \
export LESS_TERMCAP_se="$(printf '\e[0m')" \
export LESS_TERMCAP_so="$(printf '\e[1;44;33m')" \
export LESS_TERMCAP_ue="$(printf '\e[0m')" \
export LESS_TERMCAP_us="$(printf '\e[1;32m')" \

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
~/Repos/github.com:\
~/Repos/github.com/$GITUSER:\
~/Repos/github.com/$GITUSER/dot:\
~/Repos:\
/media/$USER:\
~

# ------------------------ bash shell options ------------------------

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
# Autocorrect typos in path names when using `cd`
shopt -s cdspell
shopt -s globstar
shopt -s expand_aliases
shopt -s dotglob
shopt -s extglob

# ------------------------------ history -----------------------------

export HISTCONTROL=ignoreboth
export HISTSIZE=5000
export HISTFILESIZE=10000

set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'
# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# --------------------------- smart prompt ---------------------------

PROMPT_LONG=20
PROMPT_MAX=95
PROMPT_AT=@

__ps1() {
  local P='$'

  if test -n "${ZSH_VERSION}"; then
    local r='%F{red}'
    local g='%F{black}'
    local h='%F{blue}'
    local u='%F{yellow}'
    local p='%F{yellow}'
    local w='%F{magenta}'
    local b='%F{cyan}'
    local x='%f'
  else
    local r='\[\e[31m\]'
    local g='\[\e[1;35m\]'
    local h='\[\e[1;34m\]'
    local u='\[\e[36m\]'
    local p='\[\e[33m\]'
    local w='\[\e[35m\]'
    local b='\[\e[36m\]'
    local x='\[\e[0m\]'
  fi

  if test "${EUID}" == 0; then
    P='#'
    if test -n "${ZSH_VERSION}"; then
      u='$F{red}'
    else
      u=$r
    fi
    p=$u
  fi

  local dir;
  if test "$PWD" = "$HOME"; then
    dir='~'
  else
    dir="${PWD##*/}"
    if test "${dir}" = _; then
      dir=${PWD#*${PWD%/*/_}}
      dir=${dir#/}
    elif test "${dir}" = work; then
      dir=${PWD#*${PWD%/*/work}}
      dir=${dir#/}
    fi
  fi

  local B=$(git branch --show-current 2>/dev/null)
  test "$dir" = "$B" && B='.'
  local countme="$USER@$(hostname):$dir($B)\$ "

  [[ $B = master || $B = main ]] && b="$r"
  [[ -n "$B" ]] && B="$u($b$B$u)"

  short="$u\u$u$PROMPT_AT$h\h$u:$w$dir$B$p$P$x "
  long="$u╔ $u\u$u$PROMPT_AT$h\h$u:$w$dir$B\n$u╚ $p$P$x "
  double="$u╔ $u\u$u$PROMPT_AT$h\h$u:$w$dir\n$u║ $B\n$u╚ $p$P$x "

  if test ${#countme} -gt "${PROMPT_MAX}"; then
    PS1="$double"
  elif test ${#countme} -gt "${PROMPT_LONG}"; then
    PS1="$long"
  else
    PS1="$short"
  fi
}

PROMPT_COMMAND="__ps1"

# ----------------------------- keyboard -----------------------------

test -n "$DISPLAY" && setxkbmap -option caps:escape &>/dev/null

# ---------------------- import files -------------------------------

for file in ~/.{bash_functions,bash_aliases,bash_dockerfunctions,bash_completion}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		# shellcheck source=/dev/null
		source "$file"
	fi
done
unset file
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


# ------------------------------ NVM ---------------------------------
# https://github.com/nvm-sh/nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
