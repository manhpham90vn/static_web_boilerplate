resource "aws_wafv2_web_acl" "wafv2_web_acl" {
  provider = aws.global
  name     = "waf-acl"
  scope    = "CLOUDFRONT"
  default_action {
    allow {}
  }
  rule {
    name     = "AWS-AWSManagedRulesCommonRuleSet"
    priority = 1
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }
    override_action {
      none {}
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesCommonRuleSet"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AWS-AWSManagedRulesSQLiRuleSet"
    priority = 2
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesSQLiRuleSet"
        vendor_name = "AWS"
      }
    }
    override_action {
      none {}
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesSQLiRuleSet"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "RateLimitRule"
    priority = 3
    statement {
      rate_based_statement {
        limit              = 1000
        aggregate_key_type = "IP"
      }
    }
    action {
      block {}
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "RateLimitRule"
      sampled_requests_enabled   = true
    }
  }

  token_domains = [var.domain_name, "www.${var.domain_name}"]

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "waf"
    sampled_requests_enabled   = true
  }
}
