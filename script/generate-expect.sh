#! /usr/bin/env bash

rm -f expect.sh

cp core.sh expect.sh
echo >> expect.sh

for matcher in matchers/*
do
  cat "$matcher" >> expect.sh
  echo >> expect.sh
done

echo Done