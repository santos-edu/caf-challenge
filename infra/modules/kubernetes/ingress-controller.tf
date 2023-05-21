# resource "helm_release" "ingress-nginx-external" {
#   name             = "ingress-nginx-external"
#   repository       = "https://kubernetes.github.io/ingress-nginx"
#   chart            = "ingress-nginx"
#   version          = "4.6.1"
#   namespace        = "ingress-nginx-external"
#   create_namespace = true
#   values = [<<EOF
# controller:
#   config:
#     server-tokens: "false"
#     use-proxy-protocol: "true"
#   ingressClassResource:
#     name: nginx-external
#     enabled: true
#     default: true
#     controllerValue: "k8s.io/ingress-nginx-external"
#   admissionWebhooks:
#     enabled: false
#   service:
#     externalIPs:
#     - 3.129.56.247
# EOF
#   ]
# }
