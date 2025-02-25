variable "zone_name" {
  type        = string
  description = "Route53 zone name"
}

variable "cname_record_name" {
  type        = string
  description = "CNAME record name"
}

variable "ttl" {
  type        = number
  description = "Time to live (TTL) in seconds for DNS record"
}

variable "alb_dns_name" {
  type        = string
  description = "ALB DNS record name"
}