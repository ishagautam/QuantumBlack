provider "aws" {
  version = "= 1.42.0"

  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

terraform {
  backend "s3" {}
}

module "host" {
  source         = "../modules/host"
  aws_access_key = "${var.aws_access_key}"
  aws_secret_key = "${var.aws_secret_key}"
  aws_region     = "${var.aws_region}"
  key_name       = "${var.key_name}"
  cidr_block     = "${var.cidr_block}"
}
