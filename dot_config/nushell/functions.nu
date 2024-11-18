# Pass all arguments
export def --wrapped kgp [teste, ...args] {
    echo $teste
    kubectl get pod ...$args
}
