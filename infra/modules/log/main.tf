resource "helm_release" "loki-stack" {
  name             = var.name
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "loki-stack"
  version          = "2.9.10"
  namespace        = "loki"
  create_namespace = true
  values = [<<EOF
grafana:
  enabled: true
  ingress:
    enabled: true
    path: /
    pathType: Prefix
    hosts:
      - ${var.ingress_host}
EOF
  ]
}