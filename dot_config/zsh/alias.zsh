alias ls="lsd -la"
alias work="cd ~/work"
alias finder="open -a Finder ."
if [ $TERM = "xterm-kitty" ]; then
  alias ssh="kitty +kitten ssh"
fi
