kpn() {
  kubectl get pods --all-namespaces --field-selector spec.nodeName=$1
}

kdp () {
  error=$1
  kubectl get pod | grep $1 | awk '{print $1;}' | xargs -I {} kubectl delete pod  {}
}

kpe () {
	_pod=$1
	_command="${2:-bash}"
	_container=$3
	selected_pod=$(kubectl get pod | grep "$_pod" | awk '{print $1;}' | fzf)
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

kpd () {
	_pod=$1
	_command="${2:-bash}"
	selected_pod=$(kubectl get pod | grep "$_pod" | awk '{print $1;}' | fzf)
	if [ -z "$selected_pod" ]
	then
		echo "No pod selected."
		return 1
	fi
	kubectl describe pod "$selected_pod"
}

kpl () {
	_pod=$1
	_command="${2:-bash}"
	selected_pod=$(kubectl get pod | grep "$_pod" | awk '{print $1;}' | fzf)
	if [ -z "$selected_pod" ]
	then
		echo "No pod selected."
		return 1
	fi
	kubectl logs -f "$selected_pod"
}

update_abi () {
  current_date=$(date +"%d-%m-%y")
  abi leaves -f "brew-formula-$current_date"
  abi cask -f "brew-cask-$current_date"
}
