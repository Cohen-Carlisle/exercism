#!/usr/bin/env bash

set -o errexit
set -o nounset

main() {
  if [[ $# -ne 2 ]]; then
    echo "Usage: hamming.sh <string1> <string2>"
    exit 1
  fi

  local string1=$1
  local string2=$2

  if [[ ${#string1} -ne ${#string2} ]]; then
    echo "left and right strands must be of equal length"
    exit 1
  fi

  local dist=0
  for (( i = 0; i < ${#string1}; i++ )); do
    [[ ${string1:$i:1} != ${string2:$i:1} ]] && (( ++dist ))
  done

  echo $dist
}

main "$@"
