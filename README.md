# GPT2 Test Generation w/ KerasNLP on OpenShift

This repo demos the use of the [GPT2 Test Generation w/ KerasNLP](https://keras.io/examples/generative/gpt2_text_generation_with_kerasnlp/)
on OpenShift and NVIDIA.

Key concepts:
- OpenShift Developer Tools for training
- OpenShift autoscaling GPU nodes
- OpenShift limits for GPU nodes
- Minio Object Storage
- KerasNLP for Large Language Models (LLMs)
- OpenAI GPT-2 model fine-tuning
- NVIDIA Multi-instance GPUs
- NVIDIA Time Slicing GPUs
- NVIDIA GPU Monitoring
- Online experimentation

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


## Prerequisites

1. You configured your cluster with [demo-ocp-gpu](https://github.com/redhat-na-ssa/demo-ocp-gpu)

```bash
# login to your cluster from Terminal

# clone the demo-ocp-gpu repo dependecy
git clone https://github.com/redhat-na-ssa/demo-ocp-gpu

# change into demo-ocp-gpu folder
cd demo-ocp-gpu

# run the commands in bash
bash

# quick installation
./scripts/bootstrap.sh

# aws gpu - basic autoscaling
. scripts/bootstrap.sh && ocp_aws_cluster_autoscaling

# deploy devspaces
. scripts/bootstrap.sh && setup_operator_devspaces
```

## Quickstart

Test NVIDIA Pods (from the `demo-ocp-gpu` repo)
- Follow the [Various Commands](https://github.com/redhat-na-ssa/demo-ocp-gpu/tree/main#various-commands) for GPUs
- Execute the notebooks under the notebooks/ dir

Launch DevSpaces (from the `demo-ocp-gpt2-keras-nlp` repo)
- Launch the science/notebooks


