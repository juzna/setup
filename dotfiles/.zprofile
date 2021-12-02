export EDITOR=nano
export VAULT_ADDR="https://vault.skypicker.com"
export PATH=$HOME/go/bin:$PATH

# Unlimited history
export HISTSIZE=
export HISTFILESIZE=
export HISTTIMEFORMAT="[%F %T] "


# Use kiwi-scripts
for f in ~/projects/platform/kiwi-scripts/scripts/*; do
  source $f
done
