# modules/route53/main.tf
resource "aws_route53_record" "app" {
  zone_id = var.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = "dualstack.${var.alb_dns_name}"
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}