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

## Installation

### Prerequisites

- [x] Red Hat OpenShift Cluster 4.10+
- [x] Cluster admin permissions

The following cli tools are required:

- `bash`, `git`
- `oc` - Download [mac](https://formulae.brew.sh/formula/openshift-cli), [linux](https://mirror.openshift.com/pub/openshift-v4/clients/ocp), [windows](https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable/openshift-client-windows.zip)
- `kubectl` (optional) - Included in `oc` bundle
- `kustomize` (optional) - Download [mac](https://formulae.brew.sh/formula/kustomize), [linux](https://github.com/kubernetes-sigs/kustomize/releases)

NOTE: `bash`, `git`, and `oc` are available in the [OpenShift Web Terminal](https://docs.openshift.com/container-platform/4.12/web_console/web_terminal/installing-web-terminal.html)

### From your terminal

```
# start a bash shell (this means you mac users)
bash

# oc login to your cluster
oc whoami

# git clone demo
git clone https://github.com/redhat-na-ssa/demo-ocp-gpt2-keras-nlp.git
cd demo-ocp-gpt2-keras-nlp

# run setup script
./scripts/bootstrap.sh
```

### Uninstall

```
# WARNING: Be certain you want your cluster returned to a vanilla state
. ./scripts/bootstrap.sh
delete_demo
```

## Quickstart

- Launch DevSpaces from the `https://github.com/redhat-na-ssa/demo-ocp-gpt2-keras-nlp.git` repo
- Open the [science/notebooks](science/notebooks) folder
- Run the [notebooks](science/notebooks/) in order

## Additional Resources

[Configure Dev Spaces with Auth](https://eclipse.dev/che/docs/stable/end-user-guide/using-a-git-provider-access-token/)
