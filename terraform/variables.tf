variable "region" {
  default = "eu-west-1"
}

// Canonical, Ubuntu, 20.04 LTS, amd64 focal image build on 2024-02-28
variable "ami" {
  default = "ami-030f8f64679a7bef6"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "vpc_cidr_block" {
  default = "10.10.0.0/16"
}

variable "subnet_cidr_block" {
  default = "10.10.1.0/24"
}