terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "atg-digital"

    workspaces {
      prefix = "catalogue-service--"
    }
  }
}

provider "aws" {
  region              = var.region
  allowed_account_ids = [var.aws_accounts[terraform.workspace]]

  assume_role {
    role_arn = "arn:aws:iam::${var.aws_accounts[terraform.workspace]}:role/${local.terraform_role_iam_name}"
  }
}

provider "cloudflare" {}