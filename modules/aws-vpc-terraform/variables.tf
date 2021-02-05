variable "vpc_cidr_block" {
  type = string
  default = "10.0.0.0/16"
}

variable "priv_sub_cidr_block" {
  type = list(string)
}

variable "pub_sub_cidr_block" {
  type = list(string)
}

variable "region" {
  type = string
  default = "eu-central-1"
}

variable "name" {
  type = string
  default = ""
}


variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)"
}

variable "enable_dns_hostnames" {
  type = bool
  default = true
}

variable "enable_dns_support" {
  type = bool
  default = true
}