source ~/.aliases
source ~/.secrets


bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line


# Kiwi.com SSH
kiwi-vault-okta-login() {
    echo "Vault login with your Okta credentials"
    vault login \
        -address=https://vault-prod.skypicker.com \
        -method=oidc \
        -no-print
    return $?
}

kiwi-vault-ssh() {
    local ssh_private_key=~/.ssh/id_ed25519
    local vault_ssh_role="root-everywhere"

    echo "Signing ${ssh_private_key}.pub ssh key with vault"

    vault write \
        -address=https://vault-prod.skypicker.com \
        -field=signed_key \
        "ssh/sign/${vault_ssh_role}" public_key="@${ssh_private_key}.pub" \
        > "${ssh_private_key}-cert.pub" && \
        ssh-keygen -Lf "${ssh_private_key}-cert.pub"
}

fetch_gitlab_env() {
    source ~/.secrets
    curl \
      -s --header "PRIVATE-TOKEN: $GITLAB_TOKEN" \
      "https://gitlab.skypicker.com/api/v4/projects/$1/variables" \
    | jq -r 'to_entries[] | "export " + .value.key + "=" + "\"" + (.value.value|tostring) + "\""'
}

cdmk() {
  mkdir -p $1 && cd $1
}

# Google Accounts
google_user_info() {
  local TOKEN=${1:-$ACCESS_TOKEN}
  if [[ -z $TOKEN ]]; then
    echo "ERROR: No token provided; pass it via arg or \$ACCESS_TOKEN"
    return 1
  fi
  curl -H "Authorization: Bearer $TOKEN" https://www.googleapis.com/oauth2/v1/userinfo
}

google_token_info() {
  local TOKEN=${1:-$ACCESS_TOKEN}
  if [[ -z $TOKEN ]]; then
    echo "ERROR: No token provided; pass it via arg or \$ACCESS_TOKEN"
    return 1
  fi
  curl -H "Authorization: Bearer $TOKEN" https://www.googleapis.com/oauth2/v1/tokeninfo
}


#source ~/.iterm2_shell_integration.bash

# Fuzzy search
#[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Direnv
eval "$(direnv hook zsh)"


# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


# ZSH
export ZSH="/Users/juzna/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

unsetopt inc_append_history
unsetopt share_history

export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"


# GCloud
export PATH="$PATH:/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin/"
source /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc

# pipx
export PATH="/Users/juzna/.local/bin:$PATH"

# Krew (Kubernetes package manager)
export PATH="$PATH:${HOME}/.krew/bin"


# Android Studio
export PATH="$PATH:/Users/juzna/Library/Android/sdk/platform-tools"


# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/juzna/projects/platform/sls/aws/bacchus/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/juzna/projects/platform/sls/aws/bacchus/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/juzna/projects/platform/sls/aws/bacchus/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/juzna/projects/platform/sls/aws/bacchus/node_modules/tabtab/.completions/sls.zsh
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /Users/juzna/projects/platform/sls/aws/bacchus/node_modules/tabtab/.completions/slss.zsh ]] && . /Users/juzna/projects/platform/sls/aws/bacchus/node_modules/tabtab/.completions/slss.zsh


export USE_GKE_GCLOUD_AUTH_PLUGIN=True


. "$HOME/.cargo/env"


# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/juzna/.cache/lm-studio/bin"
