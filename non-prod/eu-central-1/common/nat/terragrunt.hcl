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
  source = "../../../../modules/aws-natgw-terraform/"
}

dependencies {
  paths = ["../vpc-subnets"]
}


dependency "vpc_id" {
  config_path = "${get_terragrunt_dir()}/../vpc-subnets/"
  mock_outputs = {
    vpc_id = "vpc-aw123qrwr"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan" ,"validate-all", "plan-all", "destroy", "destroy-all"]
  skip_outputs = false
}

dependency "igw_id" {
  config_path = "${get_terragrunt_dir()}/../vpc-subnets/"
  mock_outputs = {
    igw_id = "igw-aw123qrwr"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan" ,"validate-all", "plan-all", "destroy", "destroy-all"]
  skip_outputs = false

}

dependency "route_table_id" {
  config_path = "${get_terragrunt_dir()}/../vpc-subnets/"
  mock_outputs = {
    route_table_id = "rt-aw123qrwr"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan" ,"validate-all", "plan-all", "destroy", "destroy-all"]
  skip_outputs = false
}

dependency "public_subnet1" {
  config_path = "${get_terragrunt_dir()}/../vpc-subnets/"
  mock_outputs = {
    public_subnet1 = "rt-aw123456qrwr"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan" ,"validate-all", "plan-all", "destroy", "destroy-all"]
  skip_outputs = false
}

dependency "public_subnet2" {
  config_path = "${get_terragrunt_dir()}/../vpc-subnets/"
  mock_outputs = {
    public_subnet2 = "rt-aw12653qrwr"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan" ,"validate-all", "plan-all", "destroy", "destroy-all"]
  skip_outputs = false
}

dependency "public_subnet3" {
  config_path = "${get_terragrunt_dir()}/../vpc-subnets/"
  mock_outputs = {
    public_subnet3 = "rt-aw1234qrwr"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan" ,"validate-all", "plan-all", "destroy", "destroy-all"]
  skip_outputs = false
}

dependency "private_subnet1" {
  config_path = "${get_terragrunt_dir()}/../vpc-subnets/"
  mock_outputs = {
    private_subnet1 = "rt-aw1234qrwr"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan" ,"validate-all", "plan-all", "destroy", "destroy-all"]
  skip_outputs = false
}

dependency "private_subnet2" {
  config_path = "${get_terragrunt_dir()}/../vpc-subnets/"
  mock_outputs = {
    private_subnet2 = "rt-aw1234qrwr"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan" ,"validate-all", "plan-all", "destroy", "destroy-all"]
  skip_outputs = false
}

dependency "private_subnet3" {
  config_path = "${get_terragrunt_dir()}/../vpc-subnets/"
  mock_outputs = {
    private_subnet3 = "rt-aw1234qrwr"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan" ,"validate-all", "plan-all", "destroy", "destroy-all"]
  skip_outputs = false
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  #ELASTIC IP
  how_many = 3  #(count)

  #NAT
  public_subnets = [dependency.public_subnet1.outputs.public_subnet1, dependency.public_subnet2.outputs.public_subnet2, dependency.public_subnet3.outputs.public_subnet3]
  vpc_id         = dependency.vpc_id.outputs.vpc_id
  igw_id         = dependency.igw_id.outputs.igw_id

  #Route Table
  route_table_id = dependency.route_table_id.outputs.route_table_id
  private_subnets = [dependency.private_subnet1.outputs.private_subnet1, dependency.private_subnet2.outputs.private_subnet2, dependency.private_subnet3.outputs.private_subnet3]
  #------------------------------------------------------------------
  tags = {
    Name  = "${local.name}_TF",
  }
}