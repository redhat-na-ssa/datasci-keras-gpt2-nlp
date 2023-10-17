Concepts:
For IT Ops customizing a vanilla cluster with Kustomize/GitOps

- add NFD and NVIDIA operators
- add gpu node telsa t4
- configure node selector for gpu pod placement
- configure gpu autoscale
Transition for DS
- create project (call out isolation and quotas)
- test pods against gpu node
- scale up and down from 0
  - single 1:1 Pod:GPU
  - timeslice 6:4 Pods:GPUs
  - talk to MIG a30/100
- show GPU monitoring
  - admin console
  - developer/ds console
  - nvidia-smi
- different ways for DS to develop against OCP
  - RH OCP IDE Toolkits
  - RH OCP DevSpaces
  - RH OCP AI RHODS
- different ways for DS/ML Eng/App Dev to deploy models
  - On-Cluster
    - load model at runtime
    - serverless function
  - Off-Cluster/On-Device
    - containerize