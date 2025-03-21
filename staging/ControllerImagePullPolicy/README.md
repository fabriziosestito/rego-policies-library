# Container Image Pull Policy

This Policy is to ensure you are setting a value for your `imagePullPolicy`. 

The `imagePullPolicy` and the tag of the image affect when the kubelet attempts to pull the specified image.

`imagePullPolicy`: IfNotPresent: the image is pulled only if it is not already present locally.

`imagePullPolicy`: Always: every time the kubelet launches a container, the kubelet queries the container image registry to resolve the name to an image digest. If the kubelet has a container image with that exact digest cached locally, the kubelet uses its cached image; otherwise, the kubelet downloads (pulls) the image with the resolved digest, and uses that image to launch the container.

`imagePullPolicy` is omitted and either the image tag is :latest or it is omitted: `imagePullPolicy` is automatically set to Always. Note that this will not be updated to IfNotPresent if the tag changes value.

`imagePullPolicy` is omitted and the image tag is present but not :latest: `imagePullPolicy` is automatically set to IfNotPresent. Note that this will not be updated to Always if the tag is later removed or changed to :latest.

`imagePullPolicy`: Never: the image is assumed to exist locally. No attempt is made to pull the image.


Ensure you have an imagePullPolicy set that matches your policy. 
```
...
  spec:
    containers:
    - imagePullPolicy: <policy>
```
https://kubernetes.io/docs/concepts/configuration/overview/#container-images


# Settings
```yaml
  settings:
    parameters:
      - name: policy
        type: string
        required: true
        value: Always
      - name: exclude_namespaces
        type: array
        required: false
        value:
      - name: exclude_label_key
        type: string
        required: false
        value:
      - name: exclude_label_value
        type: string
        required: false
        value:
```

# Resources
Policy applies to resources kinds:
`Deployment`, `Job`, `ReplicationController`, `ReplicaSet`, `DaemonSet`, `StatefulSet`, `CronJob`
