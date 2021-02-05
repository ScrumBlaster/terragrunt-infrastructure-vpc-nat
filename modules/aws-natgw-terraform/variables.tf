variable "cidr_block" {
  type = string
  default = "10.0.0.0/16"
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
}

variable "public_subnet1" {
  type = string
  default = ""
}

variable "public_subnet2" {
  type = string
  default = ""
}

variable "public_subnet3" {
  type = string
  default = ""
}

variable "how_many" {
  type = number
  default = 0
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "igw_id" {
  type = string
}

variable "route_table_id" {
  type = string
}