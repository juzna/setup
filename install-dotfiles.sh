#!/bin/zsh
#
# Install all files from dotfiles/, by linking them to $HOME dir.
#

cd $(dirname $0)

for F in dotfiles/.*; do
  F=$(basename $F)
  FULL=$PWD/dotfiles/$F

  if [[ -h "$HOME/$F" ]]; then  # it's a symlink
    L=$(readlink "$HOME/$F")
    if [[ "$L" != "$FULL" ]]; then
      >&2 echo "$HOME/$F already exists and link to a wrong file ($L != $FULL), remove it first"
    else
      #>&2 echo "$HOME/$F is already linked"
    fi
  elif [[ -f "$HOME/$F" ]]; then  # it's a refular file
    >&2 echo "$HOME/$F already exists, remove it first"
  else
    echo "Linking $HOME/$F -> $FULL"
    ln -s "$FULL" "$HOME/$F"
  fi
done
