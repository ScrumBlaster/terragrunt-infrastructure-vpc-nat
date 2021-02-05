locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  name   = basename(get_terragrunt_dir())
  # Extract out common variables for reuse
  env    = local.environment_vars.locals.environment
  vars   = read_terragrunt_config(find_in_parent_folders("../../account.hcl"))
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "../../../../modules/aws-vpc-terraform/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  vpc_cidr_block       = local.vars.inputs.vpc_cidr_block
  priv_sub_cidr_block  = local.vars.inputs.priv_sub_cidr_block
  pub_sub_cidr_block   = local.vars.inputs.pub_sub_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${local.name}_TF",
    Env  = local.env
  }
}