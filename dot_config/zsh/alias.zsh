if command -v lsd &> /dev/null; then
  alias ls="lsd -la"
else
  alias ls="ls -lah"
fi
alias work="cd ~/work"
alias config="cd ~/.config"
alias finder="open -a Finder ."
if [ $TERM = "xterm-kitty" ]; then
  alias ssh="kitty +kitten ssh"
fi
