#! /usr/bin/env bash
folder="${1:-spec}"
find "$folder" -type f -iname "*.spec.sh" | xargs -n1 ./vendor/microspec