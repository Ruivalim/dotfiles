zhelp () {
  echo "c => cat file | pbcopy"
  echo "update_abi => abi leaves && abi cask"
  echo "kgp => kubectl get pod"
  echo "kdlp => kubectl delete pod "
  echo "kexp => kubectl exec pod"
  echo "kdcp => kubectl describe pod"
  echo "kdcn => kubectl describe node"
  echo "klp => kubectl log -f "
  echo "kgcm => kubectl get configmap -oyaml "
  echo "kgs => kubectl get secret -oyaml "
  echo "kdebug => kubectl debug"
}

c () {
  if [ ! -f "$1" ]; then
    echo "File not found: $1"
    return 1
  fi

  case "$(uname -s)" in
    Darwin)
      cat "$1" | pbcopy
      ;;
    Linux)
      if command -v wl-copy &> /dev/null; then
        cat "$1" | wl-copy
        echo "Copied $1 to clipboard (Wayland)"
      elif command -v xclip &> /dev/null; then
        cat "$1" | xclip -selection clipboard
        echo "Copied $1 to clipboard (X11)"
      else
        echo "Error: Neither wl-copy nor xclip found."
        echo "Install: sudo apt install wl-clipboard  # or xclip"
        return 1
      fi
      ;;
    CYGWIN*|MINGW*|MSYS*)
      # Windows (Git Bash, WSL, etc.)
      cat "$1" | clip.exe
      echo "Copied $1 to clipboard (Windows)"
      ;;
    *)
      echo "Unsupported OS: $(uname -s)"
      return 1
      ;;
  esac
}

kdebug () {
  kubectl run debug-pod --image=praqma/network-multitool --restart=Never --command -- /bin/sh -c "while true; do sleep 3600; done" 
  sleep 4
  kubectl exec -it debug-pod -- /bin/sh
}

kgp () {
  kubectl get pod $1
}

kdlp () {
  kubectl get pod | fzf | awk '{print $1;}' | xargs -I {} kubectl delete pod  {}
}

kexp () {
	_command="${1:-bash}"
	_container=$2
	selected_pod=$(kubectl get pod | fzf)
	if [ -z "$selected_pod" ]
	then
		echo "No pod selected."
		return 1
	fi
	selected_pod=$(echo $selected_pod | awk '{print $1;}' )
	if [ -n "$_container" ]
	then
		kubectl exec -it "$selected_pod" -c "$_container" -- $_command
	else
		kubectl exec -it "$selected_pod" -- $_command
	fi
}

kdcn () {
	selected_pod=$(kubectl get node | fzf)
	if [ -z "$selected_pod" ]
	then
		echo "No pod selected."
		return 1
	fi
	selected_pod=$(echo $selected_pod | awk '{print $1;}' )
	kubectl describe node "$selected_pod"
}

kdcp () {
	selected_pod=$(kubectl get pod | fzf)
	if [ -z "$selected_pod" ]
	then
		echo "No pod selected."
		return 1
	fi
	selected_pod=$(echo $selected_pod | awk '{print $1;}' )
	kubectl describe pod "$selected_pod"
}

klp () {
	selected_pod=$(kubectl get pod | fzf)
	if [ -z "$selected_pod" ]
	then
		echo "No pod selected."
		return 1
	fi
	selected_pod=$(echo $selected_pod | awk '{print $1;}' )
	kubectl logs -f "$selected_pod"
}

kgcm () {
	selected_configmap=$(kubectl get configmap | awk '{print $1;}' | fzf)
	if [ -z "$selected_configmap" ]
	then
		echo "No configmap selected."
		return 1
	fi
	kubectl get configmap "$selected_configmap" -oyaml | bat -l yaml
}

kgs () {
	_command="${1:-bat -l yaml}"
	selected_secret=$(kubectl get secret | awk '{print $1;}' | fzf)
	if [ -z "$selected_secret" ]
	then
		echo "No secret selected."
		return 1
	fi
  kubectl get secret "$selected_secret" -oyaml | eval "$_command" 
}

kgaz () {
	_command="${1:-bat -l yaml}"
	selected_secret=$(kubectl get azurekeyvaultsecrets | awk '{print $1;}' | fzf)
	if [ -z "$selected_secret" ]
	then
		echo "No secret selected."
		return 1
	fi
  kubectl get azurekeyvaultsecrets "$selected_secret" -oyaml | eval "$_command" 
}

kdaz () {
	_command="${1:-bat -l yaml}"
	selected_secret=$(kubectl get azurekeyvaultsecrets | awk '{print $1;}' | fzf)
	if [ -z "$selected_secret" ]
	then
		echo "No secret selected."
		return 1
	fi
  kubectl describe azurekeyvaultsecrets "$selected_secret" | eval "$_command" 
}

update_abi () {
  current_date=$(date +"%d-%m-%y")
  abi leaves -f "brew-formula-$current_date"
  abi cask -f "brew-cask-$current_date"
}

path_exists() {
    local path="$1"

    if [ -e "$path" ]; then
        return 0  
    else
        return 1 
    fi
}

## Lazy load nvm when needed
## https://www.reddit.com/r/node/comments/4tg5jg/comment/d5ib9fs/?rdt=37136
if path_exists "~/.nvm/versions/node"; then
  declare -a NODE_GLOBALS=(`find ~/.nvm/versions/node -maxdepth 3 -type l -wholename '*/bin/*' | xargs -n1 basename | sort | uniq`)

  NODE_GLOBALS+=("node")
  NODE_GLOBALS+=("nvm")

load_nvm () {
    export NVM_DIR=~/.nvm
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
}

for cmd in "${NODE_GLOBALS[@]}"; do
    eval "${cmd}(){ unset -f ${NODE_GLOBALS}; load_nvm; ${cmd} \$@ }"
done
fi

edit_nvim () {
  nvim ~/.config/nvim
}

edit_zsh () {
  nvim ~/.config/zsh
}
