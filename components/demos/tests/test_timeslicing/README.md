# Verifying the GPU Time-Slicing Configuration

Per the NVIDIA docs to [Verify the GPU time-slicing configuration](https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/gpu-sharing.html#verifying-the-gpu-time-slicing-configuration)

see Deploy a workload to validate GPU time-slicing:

## Automated Steps

```shell
# apply the kustomize
oc apply -k test_timeslicing

# check the pods and logs
oc get pods
oc logs deploy/time-slicing-verification

# delete the kustomize
oc delete -k test_timeslicing
```

## Manual Steps
Create a file, such as time-slicing-verification.yaml, with contents like the following:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: time-slicing-verification
  labels:
    app: time-slicing-verification
spec:
  replicas: 5
  selector:
    matchLabels:
      app: time-slicing-verification
  template:
    metadata:
      labels:
        app: time-slicing-verification
    spec:
      tolerations:
        - key: nvidia.com/gpu
          operator: Exists
          effect: NoSchedule
      hostPID: true
      containers:
        - name: cuda-sample-vector-add
          image: "nvcr.io/nvidia/k8s/cuda-sample:vectoradd-cuda11.7.1-ubuntu20.04"
          command: ["/bin/bash", "-c", "--"]
          args:
            - while true; do /cuda-samples/vectorAdd; done
          resources:
           limits:
             nvidia.com/gpu: 1
```

Create the deployment with multiple replicas:

```shell
oc apply -f time-slicing-verification.yaml
```

Verify that all five replicas are running:

```shell
oc get pods
```

View the logs from one of the pods:

```shell
oc logs deploy/time-slicing-verification
```

Stop the deployment:

```shell
oc delete -f time-slicing-verification.yaml
```
