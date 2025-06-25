# modules/route53/outputs.tf
output "route53_record_fqdn" {
  description = "Fully qualified domain name of the Route 53 record"
  value = aws_route53_record.app.fqdn
}