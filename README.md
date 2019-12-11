# efs-provisioner

Modified version of the [Kubernetes efs-provisioner](https://github.com/kubernetes-incubator/external-storage/tree/master/aws/efs) to run as non-root user.

## Setup

Deployment is based on the [official Helm chart](https://github.com/helm/charts/tree/master/stable/efs-provisioner).

Before deploying, use `kubectl apply -f efs-provisioner-psp.yaml` to create the required `PodSecurityPolicy`.

After modifying `values.yaml` to use your `efsFileSystemId` and `awsRegion`, use `helm template efs-provisioner stable/efs-provisioner -f values.yaml > helm-manifest.yaml` to generate a manifest file. From there, a few modifications are required:

1. Add `securityContext` to the Pod specification so that `fsGroup` and `runAsUser` are both set to 2000.
2. Comment out the entire `initContainer` block.

Use `kubectl apply -f helm-manifest.yaml` to deploy.