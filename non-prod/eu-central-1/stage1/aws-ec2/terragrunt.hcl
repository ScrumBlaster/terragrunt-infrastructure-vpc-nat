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
  source = "../../../../modules/aws-ec2-terraform/"
}

dependency "public_subnet1" {
  config_path = "${get_terragrunt_dir()}/../../common/vpc-subnets/"
  mock_outputs = {
    public_subnet1 = "rt-aw123456qrwr"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan" ,"validate-all", "plan-all", "destroy", "destroy-all"]
  skip_outputs = false
}

dependency "public_subnet2" {
  config_path = "${get_terragrunt_dir()}/../../common/vpc-subnets/"
  mock_outputs = {
    public_subnet2 = "rt-aw12653qrwr"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan" ,"validate-all", "plan-all", "destroy", "destroy-all"]
  skip_outputs = false
}

dependency "public_subnet3" {
  config_path = "${get_terragrunt_dir()}/../../common/vpc-subnets/"
  mock_outputs = {
    public_subnet3 = "rt-aw1234qrwr"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan" ,"validate-all", "plan-all", "destroy", "destroy-all"]
  skip_outputs = false
}

dependency "private_subnet1" {
  config_path = "${get_terragrunt_dir()}/../../common/vpc-subnets/"
  mock_outputs = {
    private_subnet1 = "rt-aw1234qrwr"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan" ,"validate-all", "plan-all", "destroy", "destroy-all"]
  skip_outputs = false
}

dependency "private_subnet2" {
  config_path = "${get_terragrunt_dir()}/../../common/vpc-subnets/"
  mock_outputs = {
    private_subnet2 = "rt-aw1234qrwr"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan" ,"validate-all", "plan-all", "destroy", "destroy-all"]
  skip_outputs = false
}

dependency "private_subnet3" {
  config_path = "${get_terragrunt_dir()}/../../common/vpc-subnets/"
  mock_outputs = {
    private_subnet3 = "rt-aw1234qrwr"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan" ,"validate-all", "plan-all", "destroy", "destroy-all"]
  skip_outputs = false
}

dependency "vpc_id" {
  config_path = "${get_terragrunt_dir()}/../../common/vpc-subnets/"
  mock_outputs = {
    vpc_id = "vpc-aw123qrwr"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan" ,"validate-all", "plan-all", "destroy", "destroy-all"]
  skip_outputs = false
}


inputs = {
  instance_type         = "t2.micro"
  vpc_id                = dependency.vpc_id.outputs.vpc_id
  private_subnets       = [dependency.private_subnet1.outputs.private_subnet1]
  ami_id                = "ami-0b418580298265d5c"
  volume_size           = 10
  delete_on_termination = true
  user_data             = file("user-data/user_data.sh")
  iam_role_policy_file  = file("iam-policies/iam_role_policy")
  assume_role_policy    = file("iam-policies/assume_role_policy")
  key_name              = "minus5"



  name = local.name
  #Create record in private zone----------------------
  create_record        = false #set to true if you want to create a A record into private hosted zone.
  zone_id              = ""
  type                 = "A"



  #Security group sourcing
  sourceID             = false # set this to true if you want to use source sg-id

  #security group settings:         #add more blocks for more rules
  #----------------------CIDR---------------------#
  sg_ingress_cidr = [

    {
      description = "ingress port 22"
      from_port   = "22"
      to_port     = "22"
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  #egres rules
  sg_egress = [
    {
      description = "all"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  #----------------------SOURCE---------------------#
  # set variable "sourceID" to "true" if you want to source a security group
  sg_ingress_sgid = [
    {
      description = "all"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      security_groups = ""
    },
  ]
  #egres rules
  sg_egress = [
    {
      description = "all"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  #Tags:
  tag_Name    = "history"
  tag_Project = "SBP1"
  tag_Owner   = "Marko"
  tag_Action  = "test"

  custom_tags = {
    Name = "${local.name}_TF"
  }
}