#!/bin/zsh
# Install all files from dotfiles/, by linking them to $HOME dir.

cd $(dirname $0)

for F in dotfiles/.* secrets/dotfiles/.*; do
  BASE=$(basename $F)
  FULL=$PWD/$F

  if [[ -h "$HOME/$BASE" ]]; then  # it's a symlink
    L=$(readlink "$HOME/$BASE")
    if [[ "$L" != "$FULL" ]]; then
      >&2 echo "$HOME/$BASE already exists and link to a wrong file ($L != $FULL), remove it first"
    else
      #>&2 echo "$HOME/$F is already linked"
    fi
  elif [[ -f "$HOME/$BASE" ]]; then  # it's a regular file
    >&2 echo "$HOME/$BASE already exists, remove it first"
  else
    echo "Linking $HOME/$BASE -> $FULL"
    ln -s "$FULL" "$HOME/$BASE"
  fi
done
