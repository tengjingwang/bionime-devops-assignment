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
data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

# EC2
resource "aws_instance" "ec2-instance" {
  ami                    = "${data.aws_ami.amazon-linux-2.id}"
  instance_type          = "t2.micro"
  subnet_id              = "${aws_subnet.bionime_assi_public.id}"
  key_name               = "${aws_key_pair.ec2-instance.key_name}"
  vpc_security_group_ids = ["${aws_security_group.ssh.id}"]
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

# FIXME: remove me later
resource "aws_security_group" "ssh" {
  name        = "ssh"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${aws_vpc.bionime_assi.id}"

  ingress {
    description = "ssh from me"
    from_port   = 0
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["114.35.102.230/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
