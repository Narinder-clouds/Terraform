data "aws_ami" "example" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
    }
}
data "aws_subnets" "subnet" {
  filter {
    name   = "vpc-id"
    values = ["vpc-0cf616bda57c2b0e7"]
  }
}
resource "aws_instance" "ec2" {
  instance_type = "t2.micro"
  ami = data.aws_ami.example.id
  subnet_id = data.aws_subnets.subnet.ids[0]
}