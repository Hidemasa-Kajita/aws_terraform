variable "access_key" {}
variable "secret_key" {}
variable "region" {}
variable "availability_zone" {}
variable "env" {}
variable "public_subnets" {}
variable "private_subnets" {}
variable "created_by" {}
variable "db_name" {}
variable "db_username" {}
variable "db_password" {}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

module "app_dev" {
  source            = "./modules"
  env               = var.env
  availability_zone = var.availability_zone // vpcのavailability_zone
  public_subnets    = var.public_subnets
  private_subnets   = var.private_subnets
  created_by        = var.created_by
  db_name           = var.db_name
  db_username       = var.db_username
  db_password       = var.db_password
}
