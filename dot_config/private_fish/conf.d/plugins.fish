set plugins edc/bass jorgebucaran/nvm.fish jethrokuan/z franciscolourenco/done PatrickF1/fzf.fish

if command -v fzf >/dev/null
    set -gx FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border'
    set -gx FZF_CTRL_T_OPTS '--preview "bat --color=always --style=numbers --line-range=:500 {}"'
    set -gx FZF_ALT_C_OPTS '--preview "tree -C {} | head -200"'
end

if test -d ~/.config/fish/completions
    set -gx fish_complete_path ~/.config/fish/completions $fish_complete_path
end
