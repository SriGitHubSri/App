# App
POC
Common utility package

# Using Backstage and Kratix

# Update your platform to additionally have port 31338 open.
# Load the `backstage-image.tar` in minikube on the platform cluster.
export PLATFORM="kind-platform"
export WORKER="kind-worker"

kubectl --context $WORKER apply -f worker-service-account.yaml
kubectl --context $PLATFORM apply -f platform-service-account.yaml

sleep 5 

WORKER_TOKEN=$(kubectl --context $WORKER get secret kratix-backstage-worker-sa-token -o=jsonpath='{.data.token}' | base64 --decode)
echo $WORKER_TOKEN

PLATFORM_TOKEN=$(kubectl --context $PLATFORM get secret kratix-backstage-sa-token -o=jsonpath='{.data.token}' | base64 --decode)
echo $PLATFORM_TOKEN

# Create an `app-config.yaml` file with your backstage configuration. `app-config.example.yaml` is included in this directory.
sed "s/WORKER_TOKEN/$WORKER_TOKEN/g" app-config-test.yaml | sed "s/PLATFORM_TOKEN/$PLATFORM_TOKEN/g" > app-config.yaml

# Run `kubectl --context=$PLATFORM create configmap backstage --from-file=config=app-config.yaml`
kubectl --context=$PLATFORM create configmap backstage --from-file=config=app-config.yaml

# Deploy backstage `kubectl --context=$PLATFORM apply -f backstage-deployment.yaml`
kubectl --context=$PLATFORM apply -f backstage-deployment.yaml

6. Navigate to `http://localhost:31338` to see the Backstage UI

