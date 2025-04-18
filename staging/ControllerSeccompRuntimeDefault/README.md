# Containers Not Using Runtime Default Seccomp Profile

This Policy checks for runtime/default seccomp annotation. 

Seccomp stands for secure computing mode and has been a feature of the Linux kernel since version 2.6.12. It can be used to sandbox the privileges of a process, restricting the calls it is able to make from userspace into the kernel. Kubernetes lets you automatically apply seccomp profiles loaded onto a Node to your Pods and containers.


Depending on the version of Kubernetes, you either need to set an annotation or a seccomp type in your `securityContext`. 
```
metadata:
  annotations:
    seccomp.security.alpha.kubernetes.io/pod: <seccomp_annotation>
```
AND
```
...
  spec:
    seccompProfile:
      type: <seccomp_type>
```
https://kubernetes.io/docs/tutorials/clusters/seccomp/#create-pod-that-uses-the-container-runtime-default-seccomp-profile


# Settings
```yaml
  settings:
    parameters:
      - name: seccomp_annotation
        type: string
        required: true
        value: runtime/default
      - name: seccomp_type
        type: string
        required: true
        value: RuntimeDefault
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
