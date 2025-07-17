function zhelp
    echo "c => cat file | pbcopy"
    echo "update_abi => abi leaves && abi cask"
    echo ""
    echo "== Pod functions =="
    echo "kgp => kubectl get pod"
    echo "kdlp => kubectl delete pod (with fzf)"
    echo "kexp => kubectl exec pod (with fzf)"
    echo "kdcp => kubectl describe pod (with fzf)"
    echo "klp => kubectl log -f (with fzf)"
    echo ""
    echo "== ConfigMap functions =="
    echo "kgcm => kubectl get configmap -oyaml (with fzf)"
    echo "kdcm => kubectl describe configmap (with fzf)"
    echo "kdlcm => kubectl delete configmap (with fzf)"
    echo ""
    echo "== Secret functions =="
    echo "kgs => kubectl get secret -oyaml (with fzf)"
    echo "kds => kubectl describe secret (with fzf)"
    echo "kdls => kubectl delete secret (with fzf)"
    echo ""
    echo "== Other kubectl functions =="
    echo "kdcn => kubectl describe node (with fzf)"
    echo "kgsa => kubectl get serviceaccount (with fzf)"
    echo "kgdp => kubectl get deployment (with fzf)"
    echo "kgep => kubectl get endpoints (with fzf)"
    echo "kgns => change namespace (with fzf)"
    echo "ktop => kubectl top pods"
    echo "ktopn => kubectl top nodes"
    echo "kdebug => kubectl debug pod"
    echo "kgaz => get azurekeyvaultsecrets (with fzf)"
    echo "kdaz => describe azurekeyvaultsecrets (with fzf)"
end

function c
    set input
    if isatty stdin
        set input $argv[1]
    else
        set input (cat)
    end

    switch (uname -s)
        case Darwin
            echo $input | pbcopy
        case Linux
            if command -v wl-copy >/dev/null
                echo $input | wl-copy
            else if command -v xclip >/dev/null
                echo $input | xclip -selection clipboard
            else
                echo "Error: Neither wl-copy nor xclip found."
                echo "Install: sudo apt install wl-clipboard  # or xclip"
                return 1
            end
        case 'CYGWIN*' 'MINGW*' 'MSYS*'
            echo $input | clip.exe
        case '*'
            echo "Unsupported OS: "(uname -s)
            return 1
    end
end

function kdebug
    kubectl run debug-pod --image=praqma/network-multitool --restart=Never --command -- /bin/sh -c "while true; do sleep 3600; done"
    sleep 4
    kubectl exec -it debug-pod -- /bin/sh
end

function kgp
    kubectl get pod $argv[1]
end

function kdlp
    kubectl get pod | fzf | awk '{print $1;}' | xargs -I {} kubectl delete pod {}
end

function kexp
    set _command $argv[1]
    if test -z "$_command"
        set _command bash
    end
    set _container $argv[2]

    set selected_pod (kubectl get pod | fzf)
    if test -z "$selected_pod"
        echo "No pod selected."
        return 1
    end
    set selected_pod (echo $selected_pod | awk '{print $1;}')

    if test -n "$_container"
        kubectl exec -it $selected_pod -c $_container -- $_command
    else
        kubectl exec -it $selected_pod -- $_command
    end
end

function kdcn
    set selected_node (kubectl get node | fzf)
    if test -z "$selected_node"
        echo "No node selected."
        return 1
    end
    set selected_node (echo $selected_node | awk '{print $1;}')
    kubectl describe node $selected_node
end

function kdcp
    set selected_pod (kubectl get pod | fzf)
    if test -z "$selected_pod"
        echo "No pod selected."
        return 1
    end
    set selected_pod (echo $selected_pod | awk '{print $1;}')
    kubectl describe pod $selected_pod
end

function klp
    set selected_pod (kubectl get pod | fzf)
    if test -z "$selected_pod"
        echo "No pod selected."
        return 1
    end
    set selected_pod (echo $selected_pod | awk '{print $1;}')
    kubectl logs -f $selected_pod
end

function kgaz
    set _command $argv[1]
    if test -z "$_command"
        set _command "bat -l yaml"
    end
    set selected_secret (kubectl get azurekeyvaultsecrets | awk '{print $1;}' | fzf)
    if test -z "$selected_secret"
        echo "No secret selected."
        return 1
    end
    kubectl get azurekeyvaultsecrets $selected_secret -oyaml | eval $_command
end

function kdaz
    set _command $argv[1]
    if test -z "$_command"
        set _command "bat -l yaml"
    end
    set selected_secret (kubectl get azurekeyvaultsecrets | awk '{print $1;}' | fzf)
    if test -z "$selected_secret"
        echo "No secret selected."
        return 1
    end
    kubectl describe azurekeyvaultsecrets $selected_secret | eval $_command
end

function update_abi
    set current_date (date +"%d-%m-%y")
    abi leaves -f "brew-formula-$current_date"
    abi cask -f "brew-cask-$current_date"
end

function edit_nvim
    nvim ~/.config/nvim
end

function edit_fish
    nvim ~/.config/fish
end

function kdcm
    set selected_configmap (kubectl get configmap | awk '{print $1;}' | fzf)
    if test -z "$selected_configmap"
        echo "No configmap selected."
        return 1
    end
    kubectl describe configmap $selected_configmap
end

function kds
    set selected_secret (kubectl get secret | awk '{print $1;}' | fzf)
    if test -z "$selected_secret"
        echo "No secret selected."
        return 1
    end
    kubectl describe secret $selected_secret
end

function kdls
    set selected_secret (kubectl get secret | awk '{print $1;}' | fzf)
    if test -z "$selected_secret"
        echo "No secret selected."
        return 1
    end
    kubectl delete secret $selected_secret
end

function kdlcm
    set selected_configmap (kubectl get configmap | awk '{print $1;}' | fzf)
    if test -z "$selected_configmap"
        echo "No configmap selected."
        return 1
    end
    kubectl delete configmap $selected_configmap
end

function kgs
    set selected_secret (kubectl get secret | awk '{print $1;}' | fzf)
    if test -z "$selected_secret"
        echo "No secret selected."
        return 1
    end
    kubectl get secret $selected_secret -o jsonpath='{.data}' | jq -r 'to_entries[] | "\(.key): \(.value | @base64d)"'
end

function kgcm
    set selected_configmap (kubectl get configmap | awk '{print $1;}' | fzf)
    if test -z "$selected_configmap"
        echo "No configmap selected."
        return 1
    end
    kubectl get configmap $selected_configmap -o jsonpath='{.data}' | jq -r 'to_entries[] | "\(.key):\n\(.value)\n---"'
end

function kgsa
    kubectl get serviceaccount | fzf | awk '{print $1;}' | xargs -I {} kubectl get serviceaccount {} -oyaml | bat -l yaml
end

function kgdp
    kubectl get deployment | fzf | awk '{print $1;}' | xargs -I {} kubectl get deployment {} -oyaml | bat -l yaml
end

function kgep
    kubectl get endpoints | fzf | awk '{print $1;}' | xargs -I {} kubectl get endpoints {} -oyaml | bat -l yaml
end

function kgns
    kubectl get namespace | fzf | awk '{print $1;}' | xargs -I {} kubectl config set-context --current --namespace={}
end

function ktop
    kubectl top pods --sort-by=cpu | bat
end

function ktopn
    kubectl top nodes --sort-by=cpu | bat
end

function screen_reset
    hyprctl keyword monitor ,preferred,auto,1
end

function screen_fhd
    hyprctl keyword monitor ,1920x1080@60,0x0,1
end

# FZF utility function
function f
    if test (count $argv) -eq 0
        fzf | sort
        return 0
    end

    set program $argv[1]
    set -e argv[1]

    set arguments (fzf --multi)

    if test -z "$arguments"
        return 1
    end

    # GUI programs that need background execution
    if string match -q -r '^(nautilus|zathura|evince|vlc|eog|kolourpaint)$' $program
        eval "$program $arguments &"
    else
        eval "$program $arguments"
    end
end

# FZF completion functions
function _fzf_compgen_path
    fd --hidden --follow --exclude ".git" . $argv[1]
end

function _fzf_compgen_dir
    fd --type d --hidden --follow --exclude ".git" . $argv[1]
end
