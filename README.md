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

```python
# 1. login to your OCP cluster
oc login
WORKING_DIR='local_working_dir'

# 2. create a working directory 
mkdir $WORKING_DIR

# 3. change into your working directory
cd $WORKING_DIR

# 4. git clone this repo 
git clone https://github.com/redhat-na-ssa/demo-ocp-gpt2-keras-nlp.git

# 5. login to your OCP cluster (you may need a ca.crt file to avoid error)
oc login
```

## Kickoff Installation
```
# 1. run the scripts/bootstrap.sh in bash
bash
./scripts/bootstrap.sh
```
