provider "aws" {
  version = ">= 2.11"
  region  = var.aws-region
}

provider "http" {}

module "vpc" {
  source                  = "./vpc"
  availability-zones      = data.aws_availability_zones.available.names
  cluster-name            = var.cluster-name
  aws-region              = var.aws-region
  vpc-subnet-cidr         = var.vpc-subnet-cidr
  private-subnet-cidr     = var.private-subnet-cidr
  public-subnet-cidr      = var.public-subnet-cidr
}