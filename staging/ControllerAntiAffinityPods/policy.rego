package policy

import future.keywords.in

default exclude_namespaces := []
default exclude_label_key := ""
default exclude_label_value := ""

keys := input.parameters.keys
exclude_namespaces := input.parameters.exclude_namespaces
exclude_label_key := input.parameters.exclude_label_key
exclude_label_value := input.parameters.exclude_label_value

violation[result] {
  isExcludedNamespace == false
  not exclude_label_value == controller_input.metadata.labels[exclude_label_key]
  walk(controller_spec.affinity.podAntiAffinity, [path, value])
  key := path[count(path) - 1]
  key == "key"
  not array_contains(keys, value)
  result = {
    "issue_detected": true,
    "msg": sprintf("Expecting key '%v'; detected '%v'", [keys, value]),
    "violating_key": "spec.template.spec.affinity.podAntiAffinity"
  }
}

array_contains(array, element) {
  array[_] = element
}

# Controller input
controller_input = input.review.object

# controller_container acts as an iterator to get containers from the template
controller_spec = controller_input.spec.template.spec {
  contains_kind(controller_input.kind, {"StatefulSet" , "DaemonSet", "Deployment", "Job"})
} else = controller_input.spec {
  controller_input.kind == "Pod"
} else = controller_input.spec.jobTemplate.spec.template.spec {
  controller_input.kind == "CronJob"
}

contains_kind(kind, kinds) {
  kinds[_] = kind
}

isExcludedNamespace = true {
	controller_input.metadata.namespace
	controller_input.metadata.namespace in exclude_namespaces
} else = false
