# AMI
data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]

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
  iam_instance_profile   = "${aws_iam_instance_profile.cloudwatch_logs.id}"
  # WONTFIX: Easier for you to verify.
  associate_public_ip_address = true

  tags = {
    Name = "bionime_assi_instance"
  }
}

resource "aws_key_pair" "ec2-instance" {
  key_name   = "bionime-assignent-${uuid()}"
  public_key = "${var.ec2-instance-pubkey}"
}

# Remove me if you don't want ssh access
resource "aws_security_group" "ssh" {
  name        = "ssh"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${aws_vpc.bionime_assi.id}"

  ingress {
    description = "ssh from me"
    from_port   = 0
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.ssh-cidr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh"
  }
}

resource "aws_iam_instance_profile" "cloudwatch_logs" {
  name = "cloudwatch_logs"
  role = "${aws_iam_role.cloudwatch_logs.name}"
}

resource "aws_iam_role" "cloudwatch_logs" {
  name = "cloudwatch_logs"
  path = "/"

  assume_role_policy    = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
  force_detach_policies = true
}

resource "aws_iam_role_policy" "cloudwatch_logs" {
  name = "cloudwatch_logs"
  role = "${aws_iam_role.cloudwatch_logs.id}"

  policy = <<-EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogStreams"
    ],
      "Resource": [
        "*"
    ]
  }
 ]
}
  EOF
}
