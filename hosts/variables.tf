variable "aws_access_key" {
  description = "AWS Access key"
}

variable "aws_secret_key" {
  description = "AWS Secret key"
}

variable "aws_region" {
  default = "us-west-2"
}

variable "key_name" {
  description = "AWS User keys"
}

variable "cidr_block" {
  default = "10.91.0.0/16"
}
