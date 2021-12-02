source ~/.aliases


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
    local ssh_private_key=~/.ssh/id_rsa
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

#source ~/.iterm2_shell_integration.bash

# Fuzzy search
#[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Direnv
eval "$(direnv hook zsh)"
