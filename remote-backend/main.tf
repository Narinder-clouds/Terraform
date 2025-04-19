terraform {
  backend "s3" {
    bucket = "aizenn"
    key    = "global/terraform.tfstate"
    region = "us-east-1"
  }
}

