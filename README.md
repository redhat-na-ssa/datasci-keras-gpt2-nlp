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

## Prerequisites

- Nvidia GPU hardware
- OpenShift 4.11+ w/ cluster admin
- AWS (auto scaling, optional)
- OpenShift Dev Spaces 3.8.0+ (optional)
- Internet access

Red Hat Demo Platform Catalog (RHDP) options:

- `MLOps Demo: Data Science & Edge Practice`
- `Red Hat OpenShift Container Platform 4 Demo`

## Dependencies

1. Git clone and run the following commands from [demo-ocp-gpu](https://github.com/redhat-na-ssa/demo-ocp-gpu)

```bash
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

1. Launch DevSpaces
2. 

```bash

```


