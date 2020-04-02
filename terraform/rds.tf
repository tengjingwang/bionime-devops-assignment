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
#   db_subnet_group_name = "${aws_db_subnet_group.private}"
}

resource "aws_db_subnet_group" "private" {
  name = "rdb_subnet_group"
  subnet_ids = [
      "${aws_subnet.bionime_assi_private.id}",
      "${aws_subnet.bionime_assi_private_extra.id}",
]

}
