### bastion security group

# BASTION
module "ssh_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.0.1"

  name        = "ssh-sg"
  description = "Security group which is to allow SSH from Bastion"
  vpc_id      = data.aws_vpc.eks.id

  ingress_cidr_blocks = ["196.192.165.10/32"]
  ingress_rules       = ["ssh-tcp"]
  egress_cidr_blocks  = ["0.0.0.0/0"]
  egress_rules        = ["all-all"]
}


### bastion hosts
module "bastion-asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 3.0"
  name    = "bastion-asg"

  lc_name = "bastion-lc"

  image_id                     = data.aws_ami.bastion.id
  instance_type                = "t2.micro"
  security_groups              = [data.aws_security_group.bastion.id]
  associate_public_ip_address  = true
  recreate_asg_when_lc_changes = true

  root_block_device = [
    {
      volume_size           = "10"
      volume_type           = "gp2"
      delete_on_termination = true
    },
  ]

  # Auto scaling group
  asg_name                  = "bastion"
  vpc_zone_identifier       = data.aws_subnet_ids.public.ids
  health_check_type         = "EC2"
  min_size                  = 1
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0
  key_name                  = var.ec2-key

  tags = [
    {
      key                 = "Name"
      value               = "bastion"
      propagate_at_launch = true
    }
  ]

}