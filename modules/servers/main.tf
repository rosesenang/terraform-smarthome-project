
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical's ID - creators of the Ubuntu AMI
}

resource "aws_instance" "EC2" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id = var.subnet_id
  vpc_security_group_ids = var.securitygroupid
  associate_public_ip_address = var.assoc_public_ip
  key_name = var.key_name
  tags = {
    "Name" = var.tag_name
  }

}