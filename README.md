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

Test NVIDIA GPUs (from the `demo-ocp-gpu` repo)

- Follow the [Various Commands](https://github.com/redhat-na-ssa/demo-ocp-gpu/tree/v0.90#various-commands) for GPUs
- Execute the notebooks under the [notebooks](https://github.com/redhat-na-ssa/demo-ocp-gpu/tree/v0.90/notebooks) dir

Launch DevSpaces (from the `demo-ocp-gpt2-keras-nlp` repo)

- Launch the [science/notebooks](science/notebooks)

## Additional Resources

[Configure Dev Spaces with Auth](https://eclipse.dev/che/docs/stable/end-user-guide/using-a-git-provider-access-token/)
