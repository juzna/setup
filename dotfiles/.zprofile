export EDITOR=nano
export VAULT_ADDR="https://vault.skypicker.com"
export PATH=$HOME/go/bin:$PATH

# Unlimited history
export HISTSIZE=
export HISTFILESIZE=
export HISTTIMEFORMAT="[%F %T] "


eval "$(/opt/homebrew/bin/brew shellenv)"


# Use kiwi-scripts
if [[ -d $HOME/projects/platform/kiwi-scripts/scripts/ ]]; then
  for f in $HOME/projects/platform/kiwi-scripts/scripts/*; do
    source $f
  done
fi
