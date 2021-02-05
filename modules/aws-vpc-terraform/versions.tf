terraform {
  required_version = "0.12.20"

  required_providers {
    aws      = "~> 2.70.0"
    null     = "~> 2.1.2"
    local    = "~> 1.4.0"
    random   = "~> 2.2.1"
    template = "~> 2.1.2"
    archive  = "~> 1.3.0"
  }
}