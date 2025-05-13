#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Pls provide the commit message."
  echo "sync.sh 'commit msg'"
  exit 1
fi

git status
read -p "Do you want to commit and push? (Y/N): " answer

case "$answer" in
  [Yy])
    git add .
    git status
    git commit -m "$1"
    git push
    ;;
  [Nn])
    echo "Do nothing. Bye!"
    ;;
  *)
    echo "Invalid input. Please enter Y or N."
    ;;
esac
