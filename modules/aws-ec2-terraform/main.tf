
resource "aws_security_group" "default" {
  count = var.sourceID == false ? 1 : 0
  name = "${var.name}-Security"
  vpc_id = var.vpc_id
  #CIDR ingress
  dynamic "ingress" {
    for_each = var.sg_ingress_cidr
    content {
      description     = ingress.value.description
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = ingress.value.protocol
      cidr_blocks     = [ingress.value.cidr_blocks]
    }
  }
  #egress
  dynamic "egress" {
    for_each = var.sg_egress
    content {
      description = egress.value.description
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = [egress.value.cidr_blocks]
    }
  }
}

#security group
resource "aws_security_group" "sourcing" {
  count = var.sourceID == false ? 0 : 1
  name = "${var.name}-Security"
  vpc_id = var.vpc_id
  #CIDR ingress
  dynamic "ingress" {
    for_each = var.sg_ingress_sgid
    content {
      description     = ingress.value.description
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = ingress.value.protocol
      security_groups = [ingress.value.security_groups]
    }
  }
  #egress
  dynamic "egress" {
    for_each = var.sg_egress
    content {
      description = egress.value.description
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = [egress.value.cidr_blocks]
    }
  }
}


/*#instance role
resource "aws_iam_role" "default" {
  name               = "${var.name}-Role"
  path               = "/"
  assume_role_policy = var.assume_role_policy
}

#instance profile
resource "aws_iam_instance_profile" "runner_profile" {
  name        = "${var.name}-Instance_profile"
  role        = aws_iam_role.default.name
}

#role policy for the iam role/instance profile
resource "aws_iam_role_policy" "policy_runner_role" {
  name        = "${var.name}-Role_policy"
  role        = aws_iam_role.default.id
  policy      = var.iam_role_policy_file
} */

data aws_security_group "default"{
    name = "${var.name}-Security"
    vpc_id = var.vpc_id
  depends_on = [aws_security_group.default, aws_security_group.sourcing]
}

#build server cicd
resource "aws_instance" "default" {
  ami                     = var.ami_id
  instance_type           = var.instance_type
  user_data               = var.user_data
  subnet_id               = var.private_subnets[0]
  security_groups         = [data.aws_security_group.default.id]
  //iam_instance_profile    = aws_iam_instance_profile.runner_profile.name
  key_name                = var.key_name

  root_block_device {
    volume_size = var.volume_size
    delete_on_termination = var.delete_on_termination
  }

  tags  = merge(
    var.tags,
    var.custom_tags
  )
}

resource "aws_route53_record" "default" {
  count = var.create_record == true ? 1 : 0
  zone_id = var.zone_id
  records = [aws_instance.default.private_ip]
  name = "${var.name}."
  type = "A"
  ttl = var.ttl
  depends_on = [aws_instance.default]
}
