data "aws_ami" "bastion" {
  most_recent = true
  owners      = ["137112412989"]

  filter {
    name = "name"

    values = [
      "amzn2-ami-hvm-*-x86_64-gp2",
    ]
  }
}


data "aws_security_group" "bastion" {
  vpc_id = data.aws_vpc.eks.id
  name   = "${module.ssh_sg.this_security_group_name}"
}

data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.eks.id

  tags = {
    Name = "${var.cluster-name}-eks-public"
  }
}

##########################

variable "vpc_id" {}

variable "ec2-key" {}
