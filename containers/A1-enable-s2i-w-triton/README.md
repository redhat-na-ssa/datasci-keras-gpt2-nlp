# s2i patch - triton model serving

This project consists of how to create a container with a model for serving on triton

## Folder Info

Triton model folder structure:

```
models (provide this dir as source / MODEL_REPOSITORY )
└─ [ model name ]
    └─ 1 (version)
        └── model.savedmodel
            ├── saved_model.pb
```

## Usage

NOTE: `oc new-app` commands will error before the image is built; be patient.

### Build S2I Image

Setup new project

```
# new project
NAMESPACE=model-serving

oc new-project "${NAMESPACE}" \
  --description "A collection of model serving examples" \
  --display-name "Model Serving"
```

Build s2i image in Openshift

```
oc new-build \
  -n "${NAMESPACE}" \
  https://github.com/codekow/s2i-patch.git \
  --name s2i-triton \
  --context-dir /s2i-triton \
  --strategy docker
```

### Use S2I Image to serve models

Deploy model via git repo

```
APP_NAME=triton-server-git
APP_LABEL="app.kubernetes.io/part-of=${APP_NAME}"

oc new-app \
  -n "${NAMESPACE}" \
  s2i-triton:latest~https://github.com/codekow/s2i-patch.git \
  --name "${APP_NAME}" \
  -l "${APP_LABEL}" \
  --strategy source \
  --context-dir /s2i-triton/models
```

Deploy model via s3

```
APP_NAME=trition-server-s3
APP_LABEL="app.kubernetes.io/part-of=${APP_NAME}"

oc new-app \
  -n "${NAMESPACE}" \
  s2i-triton:latest \
  --name "${APP_NAME}" \
  -l "${APP_LABEL}"

oc set env \
  -n "${NAMESPACE}" \
  "deployment/${APP_NAME}" \
  AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION} \
  AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
  AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
  MODEL_REPOSITORY=s3://bucket/triton/models
```

Deploy model via local folder

```
APP_NAME=model-server-embedded
APP_LABEL="app.kubernetes.io/part-of=${APP_NAME}"

# configure new build config
oc new-build \
  -n "${NAMESPACE}" \
  --name "${APP_NAME}" \
  -l "${APP_LABEL}" \
  --image-stream s2i-triton:latest \
  --strategy source \
  --binary \
  --context-dir .
```

```
# start build from local folder
oc start-build \
  -n "${NAMESPACE}" \
  "${APP_NAME}" \
  --follow \
  --from-dir models
```

```
# deploy from model image
oc new-app \
  -n "${NAMESPACE}" \
  "${APP_NAME}" \
  -l "${APP_LABEL}" \
  --allow-missing-imagestream-tags

# fix: crashing on gpu nodes
oc set env deployment "${APP_NAME}" \
  -n "${NAMESPACE}" \
  --env TF_GPU_ALLOCATOR=cuda_malloc_async
```

Expose API / model server - Route

```
oc expose service \
  -n "${NAMESPACE}" \
  "${APP_NAME}" \
  -l "${APP_LABEL}" \
  --port 8000 \
  --overrides='{"spec":{"tls":{"termination":"edge"}}}'
```

Expose metrics  - Route (optional)

```
oc expose service \
  -n "${NAMESPACE}" \
  "${APP_NAME}" \
  --name "${APP_NAME}-metrics" \
  --port 8002 \
  --overrides='{"spec":{"tls":{"termination":"edge"}}}'

HOST=$(oc get route "${APP_NAME}-metric" --template={{.spec.host}})
curl -s https://${HOST}/metrics | python -m json.tool
```

Test model server / metrics

```
APP_NAME=model-server

# test via route
HOST=$(oc get route "${APP_NAME}" --template={{.spec.host}})

curl -s https://${HOST}/v2 | python -m json.tool
curl -s https://${HOST}/v2/models/< model name > | python -m json.tool > model.json


# https://docs.nvidia.com/deeplearning/triton-inference-server/user-guide/docs/protocol/extension_model_repository.html#index
curl -X POST -H "Content-Type: application/json" \
     -d @scripts/model.json \
     ${HOST}:8000/v2/models/fingerprint/infer | python -m json.tool
```

```
{
  "model_name": "fingerprint",
  "model_version": "1",
  "outputs": [
    {
      "name": "dense_5",
      "datatype": "FP32",
      "shape": [
        1,
        1
      ],
      "data": [
        1
      ]
    }
  ]
}
```

```
# test via localhost
oc get pods

oc exec deploy/${APP_NAME} -- curl -s localhost:8000/metrics
oc exec deploy/${APP_NAME} -- curl -s localhost:8000/v2
oc exec deploy/${APP_NAME} -- curl -s localhost:8000/v2/repository/index
oc exec deploy/${APP_NAME} -- curl -s localhost:8000/v2/models/< model name >
oc exec deploy/${APP_NAME} -- curl -s localhost:8000/v2/models/< model name >/config
```

## Links

- https://github.com/redhat-na-ssa/s2i-patch
- https://github.com/triton-inference-server/server
- https://github.com/openshift/source-to-image
- https://github.com/sclorg/container-common-scripts
