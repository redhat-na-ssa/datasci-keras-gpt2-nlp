
# Simplified Steps

If you get a `Warning` just reapply the command below.

```
oc apply -k prereqs
```

# Manual Steps

1. Install operators:
    1. NDF Operator
    1. NVIDIA GPU Operator
    1. Dev Spaces
1. Apply the operator configurations
1. Configure cluster autoscaling
1. Create the namespaces

```
# apply the kustomization
oc apply -k prereqs/00-operators

# apply the kustomization
oc apply -k prereqs/01-operator-configs

# configure autoscale
oc apply -k prereqs/02-autoscale

# create the namespaces
oc apply -k prereqs/03-namespaces
```

