resource "aws_route53_record" "elb_alias" {
  zone_id = data.aws_route53_zone.public.zone_id
  name    = "*"
  type    = "A"

  alias {
    name                   = aws_lb.k3s-elb.dns_name
    zone_id                = aws_lb.k3s-elb.zone_id
    evaluate_target_health = true
  }
}