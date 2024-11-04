path_exists() {
    local path="$1"

    if [ -e "$path" ]; then
        return 0  
    else
        return 1 
    fi
}

# ZSH Auto-suggestions
zsh_as="${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

if ! path_exists "$zsh_as"; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

# ZSH NVM
zsh_nvm="${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-nvm"

if ! path_exists "$zsh_nvm"; then
  git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm
fi


