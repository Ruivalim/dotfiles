if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx NVM_AUTO_USE true
set -gx LANG en_US.UTF-8
set -gx EDITOR nvim
set -gx TERM xterm-256color

if test (uname) = Linux
    if not pgrep -u (id -u) ssh-agent >/dev/null
        eval (ssh-agent -c)
        set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
        set -Ux SSH_AGENT_PID $SSH_AGENT_PID
    end
else if test (uname) = Darwin
    if not set -q SSH_AUTH_SOCK
        eval (ssh-agent -c) >/dev/null
        set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
        set -Ux SSH_AGENT_PID $SSH_AGENT_PID
    end
    ssh-add --apple-use-keychain ~/.ssh/id_* 2>/dev/null
end
if set -q SSH_CONNECTION
    set -gx TERM xterm
end

set -gx PATH $HOME/.bum/bin $PATH
set -gx BUM_INSTALL $HOME/.bum

set -gx SDKMAN_DIR $HOME/.sdkman
if test -s $HOME/.sdkman/bin/sdkman-init.sh
    bass source $HOME/.sdkman/bin/sdkman-init.sh
end

set -gx NVM_DIR $HOME/.nvm
if test -s $NVM_DIR/nvm.sh
    bass source $NVM_DIR/nvm.sh
end
if test -s $NVM_DIR/bash_completion
    bass source $NVM_DIR/bash_completion
end

if command -v zoxide >/dev/null
    zoxide init fish | source
end

set -gx FZF_COMPLETION_OPTS '--border --info=inline'

if test -f ~/.config/fish/aliases.fish
    source ~/.config/fish/aliases.fish
end

if test -f ~/.config/fish/functions.fish
    source ~/.config/fish/functions.fish
end

if test -s /Users/ruivalim/.bun/_bun
    bass source /Users/ruivalim/.bun/_bun
end

bind \e\e\eOC forward-word
bind \e\e\eOD backward-word
