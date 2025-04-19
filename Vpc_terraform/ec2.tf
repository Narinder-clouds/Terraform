resource "aws_instance" "ec2" {
    instance_type = "t2.micro"
    ami = "ami-0e2c8caa4b6378d8c"
    depends_on = [ aws_security_group.sec ]
    vpc_security_group_ids = [aws_security_group.sec.id]
    subnet_id = aws_subnet.Public.id
    #associate_public_ip_address = "true"

}
resource "aws_security_group" "sec" {
    vpc_id = aws_vpc.MyVpc.id
    depends_on = [ aws_vpc.MyVpc ]

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = var.x
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = var.x
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = var.x
    }
}