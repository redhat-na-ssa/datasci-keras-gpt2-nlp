spec:
  instance: ''
  operand:
    image: >-
      registry.redhat.io/openshift4/ose-node-feature-discovery@sha256:531f4b32f38cd8a1f0666e22f0d7b6f7664d49928c9b57e02575aa71d618170b
    servicePort: 12000
  topologyUpdater: false
  workerConfig:
    configData: |
      core:
        sleepInterval: 60s
      sources:
        pci:
          deviceClassWhitelist:
            - "0200"
            - "03"
            - "12"
          deviceLabelFields:
            - "vendor"