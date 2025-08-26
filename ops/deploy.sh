#!/bin/bash
set -e

echo "==============================================="
echo "Starting fresh deployment with clean Kubernetes"
echo "==============================================="

# Delete existing cluster if it exists
if kind get clusters | grep -q "appbuilder"; then
  echo "Deleting existing Kind cluster 'appbuilder'..."
  kind delete cluster --name appbuilder
fi

# Build Docker images for backend and frontend
echo "Building backend Docker image..."
docker build -f ops/Dockerfile.backend.prod -t applicationbuilder-backend:latest .

echo "Building frontend Docker image..."
docker build -f ops/Dockerfile.frontend.prod -t applicationbuilder-frontend:latest .

# Create new cluster with proper configuration
echo "Creating new Kind cluster with ingress port configuration..."
kind create cluster --name appbuilder --config ops/kind-config.yaml

# Wait for the cluster to be ready
echo "Waiting for Kubernetes API to be available..."
kubectl wait --for=condition=available deployment/coredns --namespace kube-system --timeout=120s

# Load Docker images into Kind cluster
echo "Loading Docker images into Kind cluster..."
kind load docker-image applicationbuilder-backend:latest --name appbuilder
kind load docker-image applicationbuilder-frontend:latest --name appbuilder

# Install ingress-nginx controller
echo "Installing NGINX ingress controller..."
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

# Wait for ingress controller to be ready
echo "Waiting for ingress controller to be ready..."
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=180s

# Create namespace if it doesn't exist
kubectl create namespace appbuilder --dry-run=client -o yaml | kubectl apply -f -

# Apply secrets first
echo "Applying database secrets..."
kubectl apply -f ops/postgres-secrets.yaml

# Apply ConfigMaps
echo "Applying frontend configuration..."
kubectl apply -f ops/frontend-config.yaml

# Deploy database
echo "Deploying PostgreSQL database..."
kubectl apply -f ops/postgres-deploy.yaml

# Wait for PostgreSQL to be ready
echo "Waiting for PostgreSQL to be ready..."
kubectl wait --namespace appbuilder --for=condition=ready pod -l app=postgres --timeout=120s

# Deploy backend
echo "Deploying backend service..."
kubectl apply -f ops/backend-deploy.yaml

# Wait for backend to be ready
echo "Waiting for backend to be ready..."
if ! kubectl wait --namespace appbuilder --for=condition=ready pod -l app=backend --timeout=180s; then
  echo "Backend service failed to become ready within timeout. Checking logs..."
  BACKEND_POD=$(kubectl get pods -n appbuilder -l app=backend -o jsonpath="{.items[0].metadata.name}")
  kubectl logs -n appbuilder $BACKEND_POD
  echo "To check the status manually, run: kubectl get pods -n appbuilder"
  echo "To see detailed pod info, run: kubectl describe pod -n appbuilder $BACKEND_POD"
  echo "Continuing with deployment despite backend issues..."
fi

# Deploy frontend
echo "Deploying frontend service..."
kubectl apply -f ops/frontend-deploy.yaml

# Apply Ingress
echo "Applying Ingress configuration..."
kubectl apply -f ops/ingress.yaml

# Display information about the services
echo "Deployment complete. Service information:"
kubectl get services -n appbuilder
kubectl get pods -n appbuilder

echo
echo "To access your application:"
echo "1. Access via ingress: Open http://app.local in your browser"
echo "   (Make sure app.local points to 127.0.0.1 in your /etc/hosts file)"
echo "2. For direct access, run: kubectl port-forward -n appbuilder service/frontend 8080:80"
echo "3. For backend API access: kubectl port-forward -n appbuilder service/backend 9090:8080"