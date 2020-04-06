module "sample_cluster" {
    source = "./sample-cluster"

    mysql_admin_name = "${var.mysql_admin_name}"
    mysql_admin_password = "${var.mysql_admin_password}"
    ec2-instance-pubkey = "${var.ec2-instance-pubkey}"
    ssh-cidr = "${var.ssh-cidr}"
    aws-region ="${var.aws-region}"
}
