resource "aws_instance" "ec2" {
    ami = "ami-0e2c8caa4b6378d8c"
    instance_type = "t2.micro"
    depends_on = [ aws_security_group.sec ]
    vpc_security_group_ids = [aws_security_group.sec.id]
    user_data = file("./user_data.sh")
}

resource "aws_security_group" "sec" {
    name = "ec2_sec"

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
