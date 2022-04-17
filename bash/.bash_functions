#!/bin/bash

# Check for various OS openers. Quit as soon as we find one that works.
for opener in browser-exec xdg-open cmd.exe cygstart "start" open; do
	if command -v $opener >/dev/null 2>&1; then
		if [[ "$opener" == "cmd.exe" ]]; then
			# shellcheck disable=SC2139
			alias open="$opener /c start";
		else
			# shellcheck disable=SC2139
			alias open="$opener";
		fi
		break;
	fi
done

# Linux specific aliases, work on both MacOS and Linux.
pbcopy() {
	stdin=$(</dev/stdin);
	pbcopy="$(which pbcopy)";
	if [[ -n "$pbcopy" ]]; then
		echo "$stdin" | "$pbcopy"
	else
		echo "$stdin" | xclip -selection clipboard
	fi
}

pbpaste() {
	pbpaste="$(which pbpaste)";
	if [[ -n "$pbpaste" ]]; then
		"$pbpaste"
	else
		xclip -selection clipboard -o
	fi
}

# Create a new directory and enter it
mkd() {
	mkdir -p "$@"
	cd "$@" || exit
}

# Make a temporary directory and enter it
tmpd() {
	local dir
	if [ $# -eq 0 ]; then
		dir=$(mktemp -d)
	else
		dir=$(mktemp -d "${1}.XXXXXXXXXX")
	fi
	cd "$dir" || exit
}

# Create a .tar.gz archive, using `zopfli`, `pigz` or `gzip` for compression
targz() {
	local tmpFile="${1%/}.tar"
	tar -cvf "${tmpFile}" --exclude=".DS_Store" "${1}" || return 1

  size=$(
    stat -f"%z" "${tmpFile}" 2> /dev/null; # OS X `stat`
    stat -c"%s" "${tmpFile}" 2> /dev/null # GNU `stat`
  )

  echo "$size"

	local cmd=""
	if (( size < 52428800 )) && hash zopfli 2> /dev/null; then
		# the .tar file is smaller than 50 MB and Zopfli is available; use it
		cmd="zopfli"
	else
		if hash pigz 2> /dev/null; then
			cmd="pigz"
		else
			cmd="gzip"
		fi
	fi

	echo "Compressing .tar using \`${cmd}\`…"
	"${cmd}" -v "${tmpFile}" || return 1
	[ -f "${tmpFile}" ] && rm "${tmpFile}"
	echo "${tmpFile}.gz created successfully."
}

# Determine size of a file or total size of a directory
fs() {
	if du -b /dev/null > /dev/null 2>&1; then
		local arg=-sbh
	else
		local arg=-sh
	fi
	# shellcheck disable=SC2199
	if [[ -n "$@" ]]; then
		du $arg -- "$@"
	else
		du $arg -- .[^.]* *
	fi
}

# Create a data URL from a file
dataurl() {
	local mimeType
	mimeType=$(file -b --mime-type "$1")
	if [[ $mimeType == text/* ]]; then
		mimeType="${mimeType};charset=utf-8"
	fi
	echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

# Create a git.io short URL
gitio() {
	if [ -z "${1}" ] || [ -z "${2}" ]; then
		echo "Usage: \`$FUNCNAME slug url\`"
		return 1
	fi
	curl -i https://git.io/ -F "url=${2}" -F "code=${1}"
}

# `o` with no arguments opens the current directory, otherwise
# opens the given location
o() {
	if [ $# -eq 0 ]; then
		xdg-open .	> /dev/null 2>&1
	else
		xdg-open "$@" > /dev/null 2>&1
	fi
}

# Call from a local repo to open the repository on github/bitbucket in browser
# Modified version of https://github.com/zeke/ghwd
repo() {
	# Figure out github repo base URL
	local base_url
	base_url=$(git config --get remote.origin.url)
	base_url=${base_url%\.git} # remove .git from end of string

	# Fix git@github.com: URLs
	base_url=${base_url//git@github\.com:/https:\/\/github\.com\/}

	# Fix git://github.com URLS
	base_url=${base_url//git:\/\/github\.com/https:\/\/github\.com\/}

	# Fix git@bitbucket.org: URLs
	base_url=${base_url//git@bitbucket.org:/https:\/\/bitbucket\.org\/}

	# Fix git@gitlab.com: URLs
	base_url=${base_url//git@gitlab\.com:/https:\/\/gitlab\.com\/}

	# Validate that this folder is a git folder
	if ! git branch 2>/dev/null 1>&2 ; then
		echo "Not a git repo!"
		exit $?
	fi

	# Find current directory relative to .git parent
	full_path=$(pwd)
	git_base_path=$(cd "./$(git rev-parse --show-cdup)" || exit 1; pwd)
	relative_path=${full_path#$git_base_path} # remove leading git_base_path from working directory

	# If filename argument is present, append it
	if [ "$1" ]; then
		relative_path="$relative_path/$1"
	fi

	# Figure out current git branch
	# git_where=$(command git symbolic-ref -q HEAD || command git name-rev --name-only --no-undefined --always HEAD) 2>/dev/null
	git_where=$(command git name-rev --name-only --no-undefined --always HEAD) 2>/dev/null

	# Remove cruft from branchname
	branch=${git_where#refs\/heads\/}
	branch=${branch#remotes\/origin\/}

	[[ $base_url == *bitbucket* ]] && tree="src" || tree="tree"
	url="$base_url/$tree/$branch$relative_path"


	echo "Calling $(type open) for $url"

	open "$url" &> /dev/null || (echo "Using $(type open) to open URL failed." && exit 1);
}

# Get colors in manual pages
man() {
	env \
		LESS_TERMCAP_mb="$(printf '\e[1;31m')" \
		LESS_TERMCAP_md="$(printf '\e[1;31m')" \
		LESS_TERMCAP_me="$(printf '\e[0m')" \
		LESS_TERMCAP_se="$(printf '\e[0m')" \
		LESS_TERMCAP_so="$(printf '\e[1;44;33m')" \
		LESS_TERMCAP_ue="$(printf '\e[0m')" \
		LESS_TERMCAP_us="$(printf '\e[1;32m')" \
		man "$@"
}

# Use feh to nicely view images
openimage() {
	cd "$(dirname "$1")" || exit
	local file
	file=$(basename "$1")

	feh -q --auto-zoom \
		--sort filename --borderless \
		--scale-down --draw-filename \
		--image-bg black \
		--start-at "$file"
}

# check if uri is up
isup() {
	local uri=$1

	if curl -s --head  --request GET "$uri" | grep "200 OK" > /dev/null ; then
		notify-send --urgency=critical "$uri is down"
	else
		notify-send --urgency=low "$uri is up"
	fi
}

# go to a folder easily in your gopath
gogo(){
	local d=$1

	if [[ -z $d ]]; then
		echo "You need to specify a project name." >&2
		return 1
	fi

	if [[ "$d" == github* ]]; then
		d=$(echo "$d" | sed 's/.*\///')
	fi
	d=${d%/}

	# search for the project dir in the GOPATH
	mapfile -t path < <(find "${GOPATH}/src" \( -type d -o -type l \) -iname "$d"  | awk '{print length, $0;}' | sort -n | awk '{print $2}')

	if [ "${path[0]}" == "" ] || [ "${path[*]}" == "" ]; then
		echo "Could not find a directory named $d in $GOPATH"
		echo "Maybe you need to 'go get' it ;)"
		return 1
	fi

	# enter the first path found
	cd "${path[0]}" || return 1
}

golistdeps(){
	(
	if [[ -n "$1" ]]; then
		gogo "$@"
	fi

	go list -e -f '{{join .Deps "\n"}}' ./... | xargs go list -e -f '{{if not .Standard}}{{.ImportPath}}{{end}}'
	)
}

# get the name of a x window
xname(){
	local window_id=$1

	if [[ -z $window_id ]]; then
		echo "Please specifiy a window id, you find this with 'xwininfo'"

		return 1
	fi

	local match_string='".*"'
	local match_qstring='"[^"\\]*(\\.[^"\\]*)*"' # NOTE: Adds 1 backreference

	# get the name
	xprop -id "$window_id" | \
		sed -nr \
		-e "s/^WM_CLASS\\(STRING\\) = ($match_qstring), ($match_qstring)$/instance=\\1\\nclass=\\3/p" \
		-e "s/^WM_WINDOW_ROLE\\(STRING\\) = ($match_qstring)$/window_role=\\1/p" \
		-e "/^WM_NAME\\(STRING\\) = ($match_string)$/{s//title=\\1/; h}" \
		-e "/^_NET_WM_NAME\\(UTF8_STRING\\) = ($match_qstring)$/{s//title=\\1/; h}" \
		-e "\${g; p}"
}
