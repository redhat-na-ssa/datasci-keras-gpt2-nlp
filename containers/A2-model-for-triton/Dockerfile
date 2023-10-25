ARG IMAGE_NAME=image-registry.openshift-image-registry.svc:5000/registry/s2i-triton:latest
FROM ${IMAGE_NAME}

# use a dockerfile or s2i source build to put a model in a container image
COPY models/ /models

# What does this get me?
# 1. Triton inferencing server
# 2. A model included in the same container as Triton server
