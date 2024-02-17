export FZF_COMPLETION_OPTS='--border --info=inline'

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Based on https://stackoverflow.com/a/64416946/14249484
f() {
    if [ $# -eq 0 ]
    then
        fzf | sort
        return 0
    fi

    # store the program
    program="$1"

    # remove first argument off the list
    shift

    # store the arguments from fzf
    arguments=$(/opt/homebrew/bin/fzf --multi)

    # if no arguments passed (e.g. if Esc pressed), return to terminal
    if [ -z "${arguments}" ]; then
        return 1
    fi

    # if the program is on the GUI list, add a '&'
    if [[ "$program" =~ ^(nautilus|zathura|evince|vlc|eog|kolourpaint)$ ]]; then
        arguments="$arguments &"
    fi

    # execute program
    $program $arguments
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
