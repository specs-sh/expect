#! /usr/bin/env bash
find spec -type f -iname "*.spec.sh" | xargs ./vendor/microspec "$@"