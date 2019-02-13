#!/usr/bin/env bash

set -o errexit
set -o nounset

main() {
  local out=""
  [[ $(($1 % 3)) -eq 0 ]] && out="${out}Pling"
  [[ $(($1 % 5)) -eq 0 ]] && out="${out}Plang"
  [[ $(($1 % 7)) -eq 0 ]] && out="${out}Plong"

  if [[ -z $out ]]; then
    echo $1
  else
    echo $out
  fi
}

main "$@"
