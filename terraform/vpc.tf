data "aws_availability_zones" "available" {
  state = "available"
}

module "db_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  name = "${var.db_name}-vpc"

  cidr = var.vpc_cidr

  azs = data.aws_availability_zones.available.names

  private_subnets = [
    "${cidrsubnet(var.vpc_cidr, 8, 10)}",
    "${cidrsubnet(var.vpc_cidr, 8, 20)}",
    "${cidrsubnet(var.vpc_cidr, 8, 30)}",
  ]

  public_subnets = [
    "${cidrsubnet(var.vpc_cidr, 8, 11)}",
    "${cidrsubnet(var.vpc_cidr, 8, 21)}",
    "${cidrsubnet(var.vpc_cidr, 8, 31)}",
  ]

  enable_dns_hostnames = true

  tags = local.resource_tags
}