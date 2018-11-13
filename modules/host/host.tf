resource "aws_vpc" "mainvpc" {
  cidr_block = "${var.cidr_block}"
}

resource "aws_internet_gateway" "dcgateway" {
  vpc_id = "${aws_vpc.mainvpc.id}"
}

resource "aws_route_table" "public_subnet_route_table" {
  vpc_id = "${aws_vpc.mainvpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.dcgateway.id}"
  }
}

resource "aws_route_table_association" "dcroute-public" {
  subnet_id      = "${aws_subnet.dcsubnet_public.id}"
  route_table_id = "${aws_route_table.public_subnet_route_table.id}"
}

resource "aws_subnet" "dcsubnet_public" {
  vpc_id                  = "${aws_vpc.mainvpc.id}"
  cidr_block              = "${cidrsubnet("${var.cidr_block}", 8, 1)}"
  map_public_ip_on_launch = true
}

resource "aws_security_group" "host" {
  tags {
    Name = "Host SG"
  }

  name   = "Host SG"
  vpc_id = "${aws_vpc.mainvpc.id}"
}

resource "aws_security_group_rule" "ingress_rule1" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["5.148.131.186/32"]
  security_group_id = "${aws_security_group.host.id}"
}

resource "aws_security_group_rule" "ingress_rule2" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["5.148.131.186/32"]
  security_group_id = "${aws_security_group.host.id}"
}

resource "aws_security_group_rule" "ingress_rule3" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["5.148.131.186/32"]
  security_group_id = "${aws_security_group.host.id}"
}

resource "aws_security_group_rule" "egress_rule1" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.host.id}"
}

data "aws_ami" "ubuntu-ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "ubuntu" {
  ami                    = "${data.aws_ami.ubuntu-ami.id}"
  instance_type          = "t2.micro"
  key_name               = "${var.key_name}"
  subnet_id              = "${aws_subnet.dcsubnet_public.id}"
  vpc_security_group_ids = ["${aws_security_group.host.id}"]

  tags {
    Name = "Ubuntu"
  }
}

output "image_id" {
  value = "${data.aws_ami.ubuntu-ami.id}"
}
