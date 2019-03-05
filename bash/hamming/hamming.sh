#!/usr/bin/env bash

set -o errexit
set -o nounset

validate_arg_count() {
  if [[ $# -ne 2 ]]; then
    echo "Usage: hamming.sh <string1> <string2>"
    exit 1
  fi
}

validate_strands_equal_length() {
  if [[ ${#1} -ne ${#2} ]]; then
    echo "left and right strands must be of equal length"
    exit 1
  fi
}

calculate_hamming_distance() {
  local dist=0
  for (( i = 0; i < ${#1}; i++ )); do
    [[ ${1:$i:1} != ${2:$i:1} ]] && (( ++dist ))
  done
  echo $dist
}

validate_arg_count "$@"
validate_strands_equal_length "$1" "$2"
calculate_hamming_distance "$1" "$2"
