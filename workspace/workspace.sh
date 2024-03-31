#!/bin/bash
set -e

cmds="help image push all"
if test -n "$COMP_LINE"; then
  pre="${COMP_LINE##* }"
  for c in ${cmds}; do
    test -z "${pre}" -o "${c}" != "${c#${pre}}" && echo "$c"
  done
  exit
fi

case "$1" in

h*|usage)
  echo "image - docker build the image"
  echo "push  - docker push the image"
  echo "all   - go, utils, image, push"
  ;;

image)
  echo "Creating the container image."
  docker build -t workspace -t rickkoch/workspace .
  ;;

push)
  echo "Pushing the container image to Docker."
  docker push rickkoch/workspace
  ;;

all)
  $0 image
  $0 push
  ;;

*) $0 image ;;

esac
