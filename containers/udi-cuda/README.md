# Info

Using upstream container build from Nvidia

## Quickstart

```
cd 12.2.0/ubi8/base
podman build -t . udi-cuda:base

cd ../runtime
podman build -t . udi-cuda:runtime

cd ../devel
podman build -t . udi-cuda:devel
```

## Links

- [Container Source - cuda/dist/12.2.0/ubi8/base](https://gitlab.com/nvidia/container-images/cuda.git)
