provider "aws" {}

#############################################################
# Data sources to get VPC and default security group details
#############################################################
data "aws_vpc" "default" {
  default = true
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = "${data.aws_vpc.default.id}"
}

###########################
# Security groups examples
###########################

#######
# HTTP
#######
module "https_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "https-sg"
  description = "Security group with HTTPS ports open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id      = "${data.aws_vpc.default.id}"

  # Open for all CIDRs defined in ingress_cidr_blocks
  ingress_rules = ["https-443-tcp"]

  ingress_cidr_blocks = ["0.0.0.0/0"]
}
