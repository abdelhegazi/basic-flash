provider "aws" {
  region = "eu-west-1"
}

/*
data "terraform_remote_state" "network" {
  backend = "s3"

  config {
    bucket = "${data.aws_caller_identity.current.account_id}-eu-west-1-terraform-state"
    key    = "utas/flask.tfstate"
    region = "eu-west-1"
  }
}*/

