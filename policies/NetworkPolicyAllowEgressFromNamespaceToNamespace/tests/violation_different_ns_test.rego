package policy

test_violation_different_ns {
  testcase = {
    "parameters": {
      "src_namespace": "ns1",
      "dst_namespace": "ns2",
      "exclude_label_key": "test_label",
      "exclude_label_value": "OK"
    },
    "review": {
      "object": {
        "apiVersion": "networking.k8s.io/v1",
        "kind": "NetworkPolicy",
        "metadata": {
          "name": "allow-egress-from-namespace-to-another",
          "namespace": "ns1"
        },
        "spec": {
          "podSelector": {},
          "egress": [
            {
              "to": [
                {
                  "namespaceSelector": {
                    "matchLabels": {
                      "kubernetes.io/metadata.name": "ns3"
                    }
                  }
                }
              ]
            }
          ],
          "policyTypes": [
            "Egress"
          ]
        }
      }
    }
  }

  violation with input as testcase
}