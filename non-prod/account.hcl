
locals {
  account_name   = "xxxx"
  aws_account_id = "xxxxx"
  aws_profile    = "xxxxx"
}

inputs = {

  vpc_cidr_block       = "10.0.0.0/16"
  stage                = "common"

  priv_sub_cidr_block  = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]
  pub_sub_cidr_block   = [
    "10.0.4.0/24",
    "10.0.5.0/24",
    "10.0.6.0/24"
  ]
}