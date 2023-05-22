module "log" {
  source       = "../../modules/log"
  name         = "loki"
  ingress_host = "grafana.lab.eduardo-santos.click"
}