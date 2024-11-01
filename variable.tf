variable "s3_bucket" {
  type        = string
  description = "S3 bucket name"
  default     = ""
}

variable "domain_name" {
  type        = string
  description = "Domain name"
  default     = ""
}

variable "acm_certificate_arn" {
  type        = string
  description = "ACM certificate ARN"
  default     = ""
}
