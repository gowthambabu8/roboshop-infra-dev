terraform {
 required_providers {
   aws = {
     source = "hashicorp/aws"
     version = "~> 6.0"
   }
 }

#  backend "s3" {
#     bucket = "happielearning-dev-state-file"
#     key = "remote-state-module.tfstate"
#     encrypt = true
#     region = "us-east-1"
#     use_lockfile = true
#  }
}

provider "aws" {
 region = "us-east-1"
}