#!/usr/bin/env bash

set -o errexit
set -o nounset

main() {
  local num="$1"
  local out=""

  (( num % 3 == 0 )) && out+="Pling"
  (( num % 5 == 0 )) && out+="Plang"
  (( num % 7 == 0 )) && out+="Plong"

  if [[ -z $out ]]; then
    echo $num
  else
    echo $out
  fi
}

main "$@"
