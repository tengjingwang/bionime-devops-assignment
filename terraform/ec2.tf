# FIXME
# # IAM
# resource "aws_iam_role" "cloudwatch_role" {
#   name = "cloudwatch_role"

#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": "sts:AssumeRole",
#       "Principal": {
#         "Service": "ec2.amazonaws.com"
#       },
#       "Effect": "Allow",
#       "Sid": ""
#     }
#   ]
# }
# EOF

#   tags = {
#     tag-key = "tag-value"
#   }
# }

# AMI
data "aws_ami" "ubuntu-1804" {
  most_recent = true
  owners      = ["${var.ubuntu_account_number}"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

variable "ubuntu_account_number" {
  default = "099720109477"
}


# EC2
resource "aws_instance" "ec2-instance" {
  ami           = "${data.aws_ami.ubuntu-1804.id}"
  instance_type = "t2.micro"
  subnet_id     = "${aws_subnet.bionime_assi_public.id}"
  key_name = "${aws_key_pair.ec2-instance.key_name}"
  # FIXME: debug purpose, not inside assignment specification, remove before delivery
  associate_public_ip_address = true

  tags = {
    Name = "bionime_assi_instance"
  }
}

resource "aws_key_pair" "ec2-instance" {
  key_name   = "bionime-assignent-${uuid()}"
  public_key = "${var.ec2-instance-pubkey}"
}
