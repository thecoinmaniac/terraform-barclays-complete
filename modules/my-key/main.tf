resource "aws_key_pair" "bastion-key" {
  key_name   = "${var.key-name}"
  public_key = "${var.public-key-file-name}"
}

