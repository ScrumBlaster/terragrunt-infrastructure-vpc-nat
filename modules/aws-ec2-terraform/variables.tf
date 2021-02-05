variable "region" {
  type = string
  description = "region"
  default = "eu-central-1"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)"
}

variable "custom_tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)"
}

variable "sg_ingress_cidr" {
  type = list(map(string))
  default = [
    {
      description = ""
      from_port = ""
      to_port = ""
      protocol = ""
      cidr_blocks = ""
    }]
}

variable "sg_ingress_sgid" {
  type = list(map(string))
  default = [
    {
      description = ""
      from_port = ""
      to_port = ""
      protocol = ""
      security_groups = ""
    }]
}

variable "sg_egress" {
  type = list(map(string))
  default = [
    {
      description = ""
      from_port = ""
      to_port = ""
      protocol = ""
      cidr_blocks = ""
    }]
}
/*variable "ingress_security_groups_ec2" {
  type = list(object({
    from_port       = number
    to_port         = number
    protocol        = string
    security_groups = list(string)
    description     = string
  }))
  default     = []
  description = "Define allowed security group ids as list of objects that will be used as ingress rule defined for Autoscaling Launch Configuration security group."
}

variable "ingress_cidr_blocks_ec2" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default     = []
  description = "Define allowed cidr blocks as list of objects that will be used as ingress rule defined in Autoscaling Launch Configuration security group."
}*/

variable "create_record" {
  type = bool
  default = false
}

variable "vpc_id" {
  type        = string
  description = "VPC ID to associte hosted zone with"
  default     = null
}

variable "availability_zones" {
  type        = string
  default     = null
}

variable "private_subnets" {
  type        = list(string)
  description = "List of private subnets to place the instance"
}

variable "ami_id" {
  type = string
  description = "the ami-ID of the OS for example;Ubuntu"
}

variable "instance_type" {
  type = string
}

variable "user_data" {
  type = string
  default = ""
}

variable "iam_role_policy_file" {
  type = string
  default = ""
}

variable "assume_role_policy" {
  type = string
  default = ""
}

variable "key_name" {
  type = string
}

variable "zone_id" {
  type = string
}

variable "ttl" {
  type = number
  default = 300
}

variable "type" {
  type = string
}

variable "tag_Name" {
  type = string
}

variable "tag_Owner" {
  type = string
}

variable "tag_Project" {
  type = string
}

variable "tag_Action" {
  type = string
}

variable "name" {
  type = string
}

variable "sourceID" {
  type = bool
}

variable "delete_on_termination" {
  type = bool
}

variable "volume_size" {
  type = number
}