khelp () {
  echo "kgp => kubectl get pod"
  echo "kdlp => kubectl delete pod "
  echo "kexp => kubectl exec pod"
  echo "kdcp => kubectl describe pod"
  echo "klp => kubectl log -f "
  echo "kgcm => kubectl get configmap -oyaml "
  echo "kgs => kubectl get secret -oyaml "
}

kgp () {
  kubectl get pod $1
}

kdlp () {
  kubectl get pod | awk '{print $1;}' | fzf | xargs -I {} kubectl delete pod  {}
}

kexp () {
	_command="${1:-bash}"
	_container=$2
	selected_pod=$(kubectl get pod | awk '{print $1;}' | fzf)
	if [ -z "$selected_pod" ]
	then
		echo "No pod selected."
		return 1
	fi
	if [ -n "$_container" ]
	then
		kubectl exec -it "$selected_pod" -c "$_container" -- $_command
	else
		kubectl exec -it "$selected_pod" -- $_command
	fi
}

kdcp () {
	selected_pod=$(kubectl get pod | awk '{print $1;}' | fzf)
	if [ -z "$selected_pod" ]
	then
		echo "No pod selected."
		return 1
	fi
	kubectl describe pod "$selected_pod"
}

klp () {
	selected_pod=$(kubectl get pod | awk '{print $1;}' | fzf)
	if [ -z "$selected_pod" ]
	then
		echo "No pod selected."
		return 1
	fi
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

## Lazy load nvm when needed
## https://www.reddit.com/r/node/comments/4tg5jg/comment/d5ib9fs/?rdt=37136
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

