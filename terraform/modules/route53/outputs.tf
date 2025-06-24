# modules/route53/outputs.tf
output "route53_record_fqdn" {
  value = aws_route53_record.app.fqdn
}