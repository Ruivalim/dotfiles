zhelp () {
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
}

c () {
  if [ -t 0 ]; then
    input="$1"
  else
    input=$(cat)
  fi
  
  case "$(uname -s)" in
    Darwin)
      echo "$input" | pbcopy
      ;;
    Linux)
      if command -v wl-copy &> /dev/null; then
        echo "$input" | wl-copy
      elif command -v xclip &> /dev/null; then
        echo "$input" | xclip -selection clipboard
      else
        echo "Error: Neither wl-copy nor xclip found."
        echo "Install: sudo apt install wl-clipboard  # or xclip"
        return 1
      fi
      ;;
    CYGWIN*|MINGW*|MSYS*)
      echo "$input" | clip.exe
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

# Additional kubectl functions for secrets and configmaps

kdcm () {
	selected_configmap=$(kubectl get configmap | awk '{print $1;}' | fzf)
	if [ -z "$selected_configmap" ]
	then
		echo "No configmap selected."
		return 1
	fi
	kubectl describe configmap "$selected_configmap"
}

kds () {
	selected_secret=$(kubectl get secret | awk '{print $1;}' | fzf)
	if [ -z "$selected_secret" ]
	then
		echo "No secret selected."
		return 1
	fi
	kubectl describe secret "$selected_secret"
}

kdls () {
	selected_secret=$(kubectl get secret | awk '{print $1;}' | fzf)
	if [ -z "$selected_secret" ]
	then
		echo "No secret selected."
		return 1
	fi
	kubectl delete secret "$selected_secret"
}

kdlcm () {
	selected_configmap=$(kubectl get configmap | awk '{print $1;}' | fzf)
	if [ -z "$selected_configmap" ]
	then
		echo "No configmap selected."
		return 1
	fi
	kubectl delete configmap "$selected_configmap"
}

kgs () {
	selected_secret=$(kubectl get secret | awk '{print $1;}' | fzf)
	if [ -z "$selected_secret" ]
	then
		echo "No secret selected."
		return 1
	fi
	kubectl get secret "$selected_secret" -o jsonpath='{.data}' | jq -r 'to_entries[] | "\(.key): \(.value | @base64d)"'
}

kgcm () {
	selected_configmap=$(kubectl get configmap | awk '{print $1;}' | fzf)
	if [ -z "$selected_configmap" ]
	then
		echo "No configmap selected."
		return 1
	fi
	kubectl get configmap "$selected_configmap" -o jsonpath='{.data}' | jq -r 'to_entries[] | "\(.key):\n\(.value)\n---"'
}

kgsa () {
	kubectl get serviceaccount | fzf | awk '{print $1;}' | xargs -I {} kubectl get serviceaccount {} -oyaml | bat -l yaml
}

kgdp () {
	kubectl get deployment | fzf | awk '{print $1;}' | xargs -I {} kubectl get deployment {} -oyaml | bat -l yaml
}

kgep () {
	kubectl get endpoints | fzf | awk '{print $1;}' | xargs -I {} kubectl get endpoints {} -oyaml | bat -l yaml
}

kgns () {
	kubectl get namespace | fzf | awk '{print $1;}' | xargs -I {} kubectl config set-context --current --namespace={}
}

ktop () {
	kubectl top pods --sort-by=cpu | bat
}

ktopn () {
	kubectl top nodes --sort-by=cpu | bat
}

screen_reset () {
  hyprctl keyword monitor ,preferred,auto,1
}

screen_fhd () {
  hyprctl keyword monitor ,1920x1080@60,0x0,1
}

oxker () {
  docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock:ro --pull=always mrjackwills/oxker
}

