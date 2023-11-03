# GPT2 Text Generation w/ KerasNLP on OpenShift

This repo demos the use of the [GPT2 Text Generation w/ KerasNLP](https://keras.io/examples/generative/gpt2_text_generation_with_kerasnlp/)
on Red Hat OpenShift with NVIDIA GPUs.

![GPT2 Text Generation Concept Diagram](<science/docs/GPT2 Text Generation with KerasNLP.png>)

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


# Installation

## Prerequisites

```bash
OCP 4 Cluster
Cluster admin privs
```

## From your terminal

```
# oc login to your cluster
$ git clone https://github.com/redhat-na-ssa/demo-ai-gitops-catalog.git
$ bash
$ source scripts/functions.sh 
$ apply_firmly clusters/default/
```

## From the OCP Web Console in the Web Terminal

go to your console and launch the web terminal (from the web terminal operator)
```
$ cd gitops
$ run get_functions
$ run scripts/bootstrap

# apply_firmly demos/devspaces-nvidia-gpu-autoscale/ 
# apply_firmly components/configs/kustomized/minio
```

## Installation Verification

Something to checkout
1. from the waffle menu check the argocd UI
1. monitor the progress from the OCP Administrator console
1. events
1. installed operators
1. machinesets
1. nodes
1. from waffle menu > click on DevSpaces 
1. go to project 'minio'
1. go to routes and click on the 'minio-console' route
1. go to secrets and click on the 'minio-root-user' and reveal the values for the u/pass
1. check for a bucket call 'models'

# Quickstart

## Launch DevSpaces (from the `demo-ocp-gpt2-keras-nlp` repo)

- Launch the [science/notebooks](science/notebooks)

## Test NVIDIA GPUs (from the `demo-ocp-gpu` repo)

- Follow the [Various Commands](https://github.com/redhat-na-ssa/demo-ocp-gpu/tree/v0.90#various-commands) for GPUs
- Execute the notebooks under the [notebooks](https://github.com/redhat-na-ssa/demo-ocp-gpu/tree/v0.90/notebooks) dir

## Additional Resources

[Configure Dev Spaces with Auth](https://eclipse.dev/che/docs/stable/end-user-guide/using-a-git-provider-access-token/)
