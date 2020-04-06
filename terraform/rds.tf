resource "aws_db_instance" "mysql-rdb" {
    allocated_storage    = 20
    storage_type         = "gp2"
    engine               = "mysql"
    engine_version       = "5.7"
    instance_class       = "db.t2.micro"
    name                 = "mydb"
    skip_final_snapshot  = true
    username             = "${var.mysql_admin_name}"
    password             = "${var.mysql_admin_password}"
    parameter_group_name = "default.mysql5.7"
    db_subnet_group_name = "${aws_db_subnet_group.private.name}"
    vpc_security_group_ids = ["${aws_security_group.rds.id}"]

    tags = {
        Name = "bionime_assi"
    }
}

resource "aws_db_subnet_group" "private" {
    name = "rdb_subnet_group"
    subnet_ids = [
        "${aws_subnet.bionime_assi_private.id}",
        "${aws_subnet.bionime_assi_private_extra.id}",
    ]

    tags = {
        Name = "bionime_assi"
    }
}

resource "aws_security_group" "rds" {
  name        = "rds"
  description = "Allow MySQL inbound traffic"
  vpc_id      = "${aws_vpc.bionime_assi.id}"

  ingress {
    description = "alow mysql connection in VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "TCP"
    cidr_blocks = ["10.0.0.0/16"]
  }
egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bionime-assi"
  }
}
