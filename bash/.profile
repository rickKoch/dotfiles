# This file is only here because some brain-dead
# applications require it.
export BASH_SILENCE_DEPRECATION_WARNING=1

if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi
. "$HOME/.cargo/env"
