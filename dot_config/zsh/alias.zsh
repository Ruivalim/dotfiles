if command -v lsd &> /dev/null; then
  alias ls="lsd -la"
else
  alias ls="ls -lah"
fi
alias work="cd ~/work"
alias config="nvim ~/.config"
alias finder="open -a Finder ."
alias sudovim="sudo -E nvim"

if [ $TERM = "xterm-kitty" ]; then
  alias ssh="kitty +kitten ssh"
fi

