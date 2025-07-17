if command -v lsd >/dev/null
    alias ls "lsd -la"
else
    alias ls "ls -lah"
end

alias work "cd ~/work"
alias config "nvim ~/.config"
alias finder "open -a Finder ."
alias sudovim "sudo -E nvim"
