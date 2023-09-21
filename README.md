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

## Get Started

from a terminal


```python
# 1. login to your OCP cluster
oc login

# 2. create a working directory 
mkdir 'demo-ocp-gpt2-kerasnlp'

# 3. change into your working directory


# 4. git clone this repo git@github.com:redhat-na-ssa/demo-ai-gitops-catalog.git
# 5. run the scripts/bootstrap.sh
```