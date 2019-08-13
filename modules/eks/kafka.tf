
### kafka hosts
module "kafka-asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 3.0"
  name    = "ec2private-asg"

  lc_name = "ec2private-lc"

  image_id                     = data.aws_ami.bastion.id
  instance_type                = "t2.micro"
  security_groups              = [data.aws_security_group.ec2private.id]
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
  asg_name                  = "kafka"
  vpc_zone_identifier       = data.aws_subnet_ids.private.ids
  health_check_type         = "EC2"
  min_size                  = 4
  max_size                  = 4
  desired_capacity          = 4
  wait_for_capacity_timeout = 0
  key_name                  = var.ec2-key

  tags = [
    {
      key                 = "Name"
      value               = "kafka"
      propagate_at_launch = true
    }
  ]

}