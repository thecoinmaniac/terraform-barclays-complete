resource "aws_key_pair" "my-key" {
  key_name   = "${var.key-name}"
  public_key = "${var.public-key-file-name}"
}
