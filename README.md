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

## Local Setup

from a terminal

```bash
# create a local working directory

WORKING_DIR=local_working_dir
mkdir $WORKING_DIR
cd $WORKING_DIR

# clone the git repo into your working directory

git clone https://github.com/redhat-na-ssa/demo-ocp-gpt2-keras-nlp.git

# login to your cluster and monitor the events

oc login
```

## Kickoff Installation
```bash
# Step 1) run the scripts/bootstrap.sh in bash

bash
./scripts/bootstrap.sh
```
