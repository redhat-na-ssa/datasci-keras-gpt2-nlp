ARG BASE_IMAGE=registry.access.redhat.com/ubi8/ubi:latest

FROM base as base-amd64

LABEL name="udi-cuda-python-3.9" \
      summary="CUDA Python 3.9 base image for UDI" \
      description="CUDA Python 3.9 builder image for UDI" \
      io.k8s.display-name="CUDA Python 3.9 base image for UDI" \
      io.k8s.description="CUDA Python 3.9 builder image for UDI" \
      authoritative-source-url="https://github.com/redhat-na-ssa/demo-ocp-gpu" \
      io.openshift.build.commit.ref="main" \
      io.openshift.build.source-location="https://github.com/redhat-na-ssa/demo-ocp-gpu/tree/main/udi-cuda-addon" \
      io.openshift.build.image="ghcr.io/redhat-na-ssa/udi-cuda:latest"


# Install CUDA base from:
# https://gitlab.com/nvidia/container-images/cuda/-/blob/master/dist/12.2.0/ubi8/base/Dockerfile
USER 0
WORKDIR /usr/local/bin

# install python
RUN yum install -y libGL python39 bash-completion && \
    alternatives --set python /usr/bin/python3.9 && \
    ln -s /usr/bin/pip3.9 /usr/bin/pip && \
    yum clean all && \
    rm -rf /var/cache/yum/*

ENV NVARCH x86_64
ENV NVIDIA_REQUIRE_CUDA "cuda>=12.2 brand=tesla,driver>=450,driver<451 brand=tesla,driver>=470,driver<471 brand=unknown,driver>=470,driver<471 brand=nvidia,driver>=470,driver<471 brand=nvidiartx,driver>=470,driver<471 brand=geforce,driver>=470,driver<471 brand=geforcertx,driver>=470,driver<471 brand=quadro,driver>=470,driver<471 brand=quadrortx,driver>=470,driver<471 brand=titan,driver>=470,driver<471 brand=titanrtx,driver>=470,driver<471 brand=tesla,driver>=525,driver<526 brand=unknown,driver>=525,driver<526 brand=nvidia,driver>=525,driver<526 brand=nvidiartx,driver>=525,driver<526 brand=geforce,driver>=525,driver<526 brand=geforcertx,driver>=525,driver<526 brand=quadro,driver>=525,driver<526 brand=quadrortx,driver>=525,driver<526 brand=titan,driver>=525,driver<526 brand=titanrtx,driver>=525,driver<526"
ENV NV_CUDA_CUDART_VERSION 12.2.53-1

COPY cuda.repo-x86_64 /etc/yum.repos.d/cuda.repo

LABEL maintainer "NVIDIA CORPORATION <sw-cuda-installer@nvidia.com>"

RUN NVIDIA_GPGKEY_SUM=d0664fbbdb8c32356d45de36c5984617217b2d0bef41b93ccecd326ba3b80c87 && \
    curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/rhel8/${NVARCH}/D42D0685.pub | sed '/^Version/d' > /etc/pki/rpm-gpg/RPM-GPG-KEY-NVIDIA && \
    echo "$NVIDIA_GPGKEY_SUM  /etc/pki/rpm-gpg/RPM-GPG-KEY-NVIDIA" | sha256sum -c --strict -

ENV CUDA_VERSION 12.2.0

# For libraries in the cuda-compat-* package: https://docs.nvidia.com/cuda/eula/index.html#attachment-a
RUN yum upgrade -y && yum install -y \
    cuda-cudart-12-2-${NV_CUDA_CUDART_VERSION} \
    cuda-compat-12-2 \
    && ln -s cuda-12.2 /usr/local/cuda \
    && yum clean all \
    && rm -rf /var/cache/yum/*


# nvidia-docker 1.0
RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
    echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64

COPY NGC-DL-CONTAINER-LICENSE /

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

# Install CUDA runtime from:
# https://gitlab.com/nvidia/container-images/cuda/-/blob/master/dist/12.2.0/ubi8/runtime/Dockerfile
ENV NV_NVTX_VERSION 12.2.53-1
ENV NV_LIBNPP_VERSION 12.1.1.14-1
ENV NV_LIBNPP_PACKAGE libnpp-12-2-${NV_LIBNPP_VERSION}
ENV NV_LIBCUBLAS_VERSION 12.2.1.16-1

LABEL maintainer "NVIDIA CORPORATION <sw-cuda-installer@nvidia.com>"

RUN yum install -y \
    cuda-libraries-12-2-${NV_CUDA_LIB_VERSION} \
    cuda-nvtx-12-2-${NV_NVTX_VERSION} \
    ${NV_LIBNPP_PACKAGE} \
    libcublas-12-2-${NV_LIBCUBLAS_VERSION} \
    && yum clean all \
    && rm -rf /var/cache/yum/*

# Install CUDA devel from:
# https://gitlab.com/nvidia/container-images/cuda/-/blob/master/dist/11.4.2/ubi8/devel/Dockerfile
ENV NV_CUDA_LIB_VERSION 12.2.0-1
ENV NV_NVPROF_VERSION 12.2.60-1
ENV NV_NVPROF_DEV_PACKAGE cuda-nvprof-12-2-${NV_NVPROF_VERSION}
ENV NV_CUDA_CUDART_DEV_VERSION 12.2.53-1
ENV NV_NVML_DEV_VERSION 12.2.81-1
ENV NV_LIBCUBLAS_DEV_VERSION 12.2.1.16-1
ENV NV_LIBNPP_DEV_VERSION 12.1.1.14-1
ENV NV_LIBNPP_DEV_PACKAGE libnpp-devel-12-2-${NV_LIBNPP_DEV_VERSION}
ENV NV_CUDA_NSIGHT_COMPUTE_VERSION 12.2.0-1
ENV NV_CUDA_NSIGHT_COMPUTE_DEV_PACKAGE cuda-nsight-compute-12-2-${NV_CUDA_NSIGHT_COMPUTE_VERSION}

LABEL maintainer "NVIDIA CORPORATION <sw-cuda-installer@nvidia.com>"

RUN yum install -y \
    make \
    findutils \
    cuda-command-line-tools-12-2-${NV_CUDA_LIB_VERSION} \
    cuda-libraries-devel-12-2-${NV_CUDA_LIB_VERSION} \
    cuda-minimal-build-12-2-${NV_CUDA_LIB_VERSION} \
    cuda-cudart-devel-12-2-${NV_CUDA_CUDART_DEV_VERSION} \
    ${NV_NVPROF_DEV_PACKAGE} \
    cuda-nvml-devel-12-2-${NV_NVML_DEV_VERSION} \
    libcublas-devel-12-2-${NV_LIBCUBLAS_DEV_VERSION} \
    ${NV_LIBNPP_DEV_PACKAGE} \
    ${NV_CUDA_NSIGHT_COMPUTE_DEV_PACKAGE} \
    && yum clean all \
    && rm -rf /var/cache/yum/*

ENV LIBRARY_PATH /usr/local/cuda/lib64/stubs

# Install CUDA devel cudnn8 from:
# https://gitlab.com/nvidia/container-images/cuda/-/blob/master/dist/12.2.0/ubi8/devel/Dockerfile
ENV NV_CUDA_LIB_VERSION 12.2.0-1
ENV NV_NVPROF_VERSION 12.2.60-1
ENV NV_NVPROF_DEV_PACKAGE cuda-nvprof-12-2-${NV_NVPROF_VERSION}
ENV NV_CUDA_CUDART_DEV_VERSION 12.2.53-1
ENV NV_NVML_DEV_VERSION 12.2.81-1
ENV NV_LIBCUBLAS_DEV_VERSION 12.2.1.16-1
ENV NV_LIBNPP_DEV_VERSION 12.1.1.14-1
ENV NV_LIBNPP_DEV_PACKAGE libnpp-devel-12-2-${NV_LIBNPP_DEV_VERSION}
ENV NV_CUDA_NSIGHT_COMPUTE_VERSION 12.2.0-1
ENV NV_CUDA_NSIGHT_COMPUTE_DEV_PACKAGE cuda-nsight-compute-12-2-${NV_CUDA_NSIGHT_COMPUTE_VERSION}

LABEL maintainer "NVIDIA CORPORATION <sw-cuda-installer@nvidia.com>"

RUN yum install -y \
    make \
    findutils \
    cuda-command-line-tools-12-2-${NV_CUDA_LIB_VERSION} \
    cuda-libraries-devel-12-2-${NV_CUDA_LIB_VERSION} \
    cuda-minimal-build-12-2-${NV_CUDA_LIB_VERSION} \
    cuda-cudart-devel-12-2-${NV_CUDA_CUDART_DEV_VERSION} \
    ${NV_NVPROF_DEV_PACKAGE} \
    cuda-nvml-devel-12-2-${NV_NVML_DEV_VERSION} \
    libcublas-devel-12-2-${NV_LIBCUBLAS_DEV_VERSION} \
    ${NV_LIBNPP_DEV_PACKAGE} \
    ${NV_CUDA_NSIGHT_COMPUTE_DEV_PACKAGE} \
    && yum clean all \
    && rm -rf /var/cache/yum/*

ENV XLA_FLAGS=--xla_gpu_cuda_data_dir=/usr/local/cuda

# install: oc,tkn
ARG OC4_URL="https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/stable/openshift-client-linux.tar.gz"
ARG TKN_URL="https://mirror.openshift.com/pub/openshift-v4/clients/pipeline/latest/tkn-linux-amd64.tar.gz"

RUN curl -sL "${OC4_URL}" | \
      tar -C /usr/local/bin -vzxf- oc kubectl && \
      /usr/local/bin/oc completion bash > /etc/bash_completion.d/oc && \
      echo "source /etc/bash_completion.d/oc" >> /home/user/.bashrc && \
    curl -sL "${TKN_URL}" | \
      tar -C /usr/local/bin -vzxf- tkn && \
      /usr/local/bin/tkn completion bash > /etc/bash_completion.d/tkn && \
      echo "source /etc/bash_completion.d/tkn" >> /home/user/.bashrc

# Restore notebook user workspace
USER 1001
WORKDIR /projects
