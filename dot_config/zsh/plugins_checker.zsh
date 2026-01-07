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

zsh_10k="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

if ! path_exists "$zsh_10k"; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi
