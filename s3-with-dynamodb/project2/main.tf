resource "aws_instance" "server2" {
     instance_type = "t2.micro"
     ami = "ami-0e2c8caa4b6378d8c"
     tags = {
       "name" = "ec2 of project-2"
     }
}
terraform {
  backend "s3" {
    bucket = "aizenn"
    key = "terraform/terrafrom.tfstate"
    region = "us-east-1"
    dynamodb_table = "locking-file-table"
  }
}