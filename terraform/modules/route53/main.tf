# Fetch the hosted zone for your domain
data "aws_route53_zone" "tm_app_zone" {
  name = var.zone_name
}

# Create a CNAME record for demo.lab-yonisomar.com
resource "aws_route53_record" "tm_cname_record" {
  zone_id = data.aws_route53_zone.tm_app_zone.id
  name    = var.cname_record_name # Subdomain you want to create
  type    = "CNAME"
  ttl     = var.ttl            # Time to live (TTL) in seconds
  records = [var.alb_dns_name] # Using ALB DNS name from the ALB resource
}
