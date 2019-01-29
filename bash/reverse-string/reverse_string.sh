#!/usr/bin/env bash

set -o errexit
set -o nounset

main() {
  rev <<< "$1"
}

main "$@"
