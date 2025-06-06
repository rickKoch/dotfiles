#!/bin/bash

# remove all the aliases
unalias -a

# alias rvi='nvim -u /home/rickkoch/Repos/github.com/rickKoch/dotfiles/nvim/nvim/simple/init.lua'
# which rvi &>/dev/null && alias vi=lvim && alias vim=nvim

# grep with ignore case
alias grep='grep -i --colour=auto'

# egrep with ignore case
alias egrep='egrep -i --colour=auto'

# fgrep with ignore case
alias fgrep='fgrep -i --colour=auto'

# follow redirects
alias curl='curl -L'
# follow redirects
alias cl='curl -L'
# follow redirects, download as original name
alias clo='curl -L -O'
# follow redirects, download as original name, continue
alias cloc='curl -L -C - -O'
# follow redirects, download as original name, continue, retry 5 times
alias clocr='curl -L -C - -O --retry 5'
# follow redirects, fetch banner
alias clb='curl -L -I'
# see only response headers from a get request
alias clhead='curl -D - -so /dev/null'

# human readable free
alias free='free -h'

# human readable df
alias df='df -h'

# lynx aliases
alias '?'=duck
alias '??'=google
alias '???'=bing

alias x="exit"

# quick navigation
alias dot='cd $DOTFILES'
alias scripts='cd $SCRIPTS'

# replace top with htop
alias top=htop

# change mode to executable
alias chmox='chmod +x'

# update the bash config
alias update='source $HOME/.bashrc'

# open bachrc file
alias bashrc='nvim $HOME/.bashrc'
# open .bash_functions file
alias bash_aliases='nvim $HOME/.bash_aliases'
# open .bash_functions file
alias bash_func='nvim $HOME/.bash_functions'
# open .bash_functions file
alias bash_dock='nvim $HOME/.bash_dockerfunctions'
# open i3 config file
alias i3conf='nvim $HOME/.config/i3/config'

# vi and vim aliases on neovim
which nvim &>/dev/null && alias vi=nvim && alias vim=nvim


# which lvim &>/dev/null && alias vi=lvim && alias vim=lvim
# which lvim &>/dev/null && alias vi=lvim

alias yy='yazi'

# Trim new lines and copy to clipboard
alias c="tr -d '\\n' | xclip -selection clipboard"

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
	colorflag="--color"
else # OS X `ls`
	colorflag="-G"
fi

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# List all files colorized in long format
# shellcheck disable=SC2139
alias l="ls -lhF ${colorflag}"

# List all files colorized in long format, including dot files
# shellcheck disable=SC2139
alias la="ls -lahF ${colorflag}"

# List only directories
# shellcheck disable=SC2139
alias lsd="ls -lhF ${colorflag} | grep --color=never '^d'"

# Always use color output for `ls`
# shellcheck disable=SC2139
alias ls="command ls ${colorflag}"
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Get week number
alias week='date +%V'

# Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

# Lock the screen (when going AFK)
alias afk="i3lock -c 000000"

# vhosts
alias hosts='sudo vim /etc/hosts'

# copy working directory
alias cwd='pwd | tr -d "\r\n" | xclip -selection clipboard'

# copy file interactive
alias cp='cp -i'

# move file interactive
alias mv='mv -i'

# better cat
alias bat='batcat'
alias cat='bat'

# Pipe my public key to my clipboard.
alias pubkey="more ~/.ssh/id_ed25519.pub | xclip -selection clipboard | echo '=> Public key copied to pasteboard.'"

# Pipe my private key to my clipboard.
alias prikey="more ~/.ssh/id_ed25519 | xclip -selection clipboard | echo '=> Private key copied to pasteboard.'"

# ansible aliases
alias ans=ansible
alias ap=ansible-playbook

alias gip="ip -json route get 8.8.8.8 | jq -r '.[].prefsrc'"

# ----------------------- docker ----------------------

alias dk='docker'
alias dklc='docker ps -l'                                                            # List last Docker container
alias dklcid='docker ps -l -q'                                                       # List last Docker container ID
alias dklcip='docker inspect -f "{{.NetworkSettings.IPAddress}}" $(docker ps -l -q)' # Get IP of last Docker container
alias dkps='docker ps'                                                               # List running Docker containers
alias dkpsa='docker ps -a'                                                           # List all Docker containers
alias dki='docker images'                                                            # List Docker images
alias dkrmac='docker rm $(docker ps -a -q)'                                          # Delete all Docker containers
alias dkex='docker exec -it '                                                        # Useful to run any commands into container without leaving host
alias dkri='docker run --rm -i '
alias dkric='docker run --rm -i -v $PWD:/cwd -w /cwd '
alias dkrit='docker run --rm -it '
alias dkritc='docker run --rm -it -v $PWD:/cwd -w /cwd '
alias dkip='docker image prune -a -f'
alias dkvp='docker volume prune -f'
alias dksp='docker system prune -a -f'

# ----------------------- docker-compose ----------------------

alias dco="docker-compose"
alias dcofresh="docker-compose-fresh"
alias dcol="docker-compose logs -f --tail 100"
alias dcou="docker-compose up"
alias dcouns="dcou --no-start"

# ----------------------- git ----------------------

alias g='git'

# add
alias ga='git add'
alias gall='git add -A'
alias gap='git add -p'

# branch
alias gb='git branch'
alias gbD='git branch -D'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbm='git branch -m'
alias gbt='git branch --track'
alias gdel='git branch -D'

# for-each-ref
alias gbc='git for-each-ref --format="%(authorname) %09 %(if)%(HEAD)%(then)*%(else)%(refname:short)%(end) %09 %(creatordate)" refs/remotes/ --sort=authorname DESC' # FROM https://stackoverflow.com/a/58623139/10362396

# commit
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gcaa='git commit -a --amend -C HEAD' # Add uncommitted and unstaged changes to the last commit
alias gcam='git commit -v -am'
alias gcamd='git commit --amend'
alias gcm='git commit -v -m'
alias gci='git commit --interactive'
alias gcsam='git commit -S -am'

# checkout
alias gcb='git checkout -b'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcobu='git checkout -b ${USER}/'
alias gcom='git checkout $(get_default_branch)'
alias gcpd='git checkout $(get_default_branch); git pull; git branch -D'
alias gct='git checkout --track'

# clone
alias gcl='git clone'

# clean
alias gclean='git clean -fd'

# cherry-pick
alias gcp='git cherry-pick'
alias gcpx='git cherry-pick -x'

# diff
alias gd='git diff'
alias gds='git diff --staged'
alias gdt='git difftool'

# archive
alias gexport='git archive --format zip --output'

# fetch
alias gf='git fetch --all --prune'
alias gft='git fetch --all --prune --tags'
alias gftv='git fetch --all --prune --tags --verbose'
alias gfv='git fetch --all --prune --verbose'
alias gmu='git fetch origin -v; git fetch upstream -v; git merge upstream/$(get_default_branch)'
alias gup='git fetch && git rebase'

# log
alias gg='git log --graph --pretty=format:'\''%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset'\'' --abbrev-commit --date=relative'
alias ggf='git log --graph --date=short --pretty=format:'\''%C(auto)%h %Cgreen%an%Creset %Cblue%cd%Creset %C(auto)%d %s'\'''
alias ggs='gg --stat'
alias ggup='git log --branches --not --remotes --no-walk --decorate --oneline' # FROM https://stackoverflow.com/questions/39220870/in-git-list-names-of-branches-with-unpushed-commits
alias gll='git log --graph --pretty=oneline --abbrev-commit'
alias gnew='git log HEAD@{1}..HEAD@{0}' # Show commits since last pull, see http://blogs.atlassian.com/2014/10/advanced-git-aliases/
alias gwc='git whatchanged'

# ls-files
alias gu='git ls-files . --exclude-standard --others' # Show untracked files
alias glsut='gu'
alias glsum='git diff --name-only --diff-filter=U' # Show unmerged (conflicted) files

# gui
alias ggui='git gui'

# home
alias ghm='cd "$(git rev-parse --show-toplevel)"' # Git home

# merge
alias gm='git merge'

# mv
alias gmv='git mv'

# patch
alias gpatch='git format-patch -1'

# push
alias gp='git push'
alias gpd='git push --delete'
alias gpf='git push --force'
alias gpo='git push origin HEAD'
alias gpom='git push origin $(get_default_branch)'
alias gpu='git push --set-upstream'
alias gpunch='git push --force-with-lease'
alias gpuo='git push --set-upstream origin'
alias gpuoc='git push --set-upstream origin $(git symbolic-ref --short HEAD)'

# pull
alias gl='git pull'
alias glum='git pull upstream $(get_default_branch)'
alias gpl='git pull'
alias gpp='git pull && git push'
alias gpr='git pull --rebase'

# remote
alias gr='git remote'
alias gra='git remote add'
alias grv='git remote -v'

# rm
alias grm='git rm'

# rebase
alias grb='git rebase'
alias grbc='git rebase --continue'
alias grm='git rebase $(get_default_branch)'
alias grmi='git rebase $(get_default_branch) -i'
alias grma='GIT_SEQUENCE_EDITOR=: git rebase  $(get_default_branch) -i --autosquash'
alias gprom='git fetch origin $(get_default_branch) && git rebase origin/$(get_default_branch) && git update-ref refs/heads/$(get_default_branch) origin/$(get_default_branch)' # Rebase with latest remote

# reset
alias gus='git reset HEAD'
alias gpristine='git reset --hard && git clean -dfx'

# status
alias gs='git status'
alias gss='git status -s'

# shortlog
alias gcount='git shortlog -sn'
alias gsl='git shortlog -sn'

# show
alias gsh='git show'

# svn
alias gsd='git svn dcommit'
alias gsr='git svn rebase' # Git SVN

# stash
alias gst='git stash'
alias gstb='git stash branch'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'  # kept due to long-standing usage
alias gstpo='git stash pop' # recommended for it's symmetry with gstpu (push)

## 'stash push' introduced in git v2.13.2
alias gstpu='git stash push'
alias gstpum='git stash push -m'

## 'stash save' deprecated since git v2.16.0, alias is now push
alias gsts='git stash push'
alias gstsm='git stash push -m'

# submodules
alias gsu='git submodule update --init --recursive'

# switch
# these aliases requires git v2.23+
alias gsw='git switch'
alias gswc='git switch --create'
alias gswm='git switch $(get_default_branch)'
alias gswt='git switch --track'

# tag
alias gt='git tag'
alias gta='git tag -a'
alias gtd='git tag -d'
alias gtl='git tag -l'

case $OSTYPE in
	darwin*)
		alias gtls="git tag -l | gsort -V"
		;;
	*)
		alias gtls='git tag -l | sort -V'
		;;
esac

# functions
function gdv() {
	git diff --ignore-all-space "$@" | vim -R -
}

function get_default_branch() {
	if git branch | grep -q '^. main\s*$'; then
		echo main
	else
		echo master
	fi
}

# ----------------------- kubectl ----------------------

alias kc='kubectl'
alias kcgp='kubectl get pods'
alias kcgd='kubectl get deployments'
alias kcgn='kubectl get nodes'
alias kcdp='kubectl describe pod'
alias kcdd='kubectl describe deployment'
alias kcdn='kubectl describe node'
alias kcgpan='kubectl get pods --all-namespaces'
alias kcgdan='kubectl get deployments --all-namespaces'


which lazygit &>/dev/null && alias ll=lazygit
