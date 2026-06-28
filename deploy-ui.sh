#!/usr/bin/env bash
set -e

RED="\033[0;31m"
RESET="\033[0m"

echo -e "${RED}Building image${RESET}"
docker build -t ui:dev .
echo -e "${RED}Loading image${RESET}"
kind load docker-image ui:dev --name cortex
kubectl apply -f ../kind-dev-cluster/cortex/ui.yaml
kubectl rollout restart deployment ui -n ui
kubectl rollout status deployment ui -n ui
kubectl get pods -n ui