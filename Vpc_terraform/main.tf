resource "aws_vpc" "MyVpc" {
    cidr_block = "10.0.0.0/16"
}
resource "aws_subnet" "Public" {
    vpc_id = aws_vpc.MyVpc.id
    cidr_block = "10.0.0.0/17"
    depends_on = [ aws_vpc.MyVpc ]
}
resource "aws_subnet" "Private" {
    vpc_id = aws_vpc.MyVpc.id
    cidr_block = "10.0.128.0/17"
    depends_on = [ aws_vpc.MyVpc ]
}
resource "aws_internet_gateway" "gateway" {
    vpc_id = aws_vpc.MyVpc.id
    depends_on = [ aws_vpc.MyVpc ]
}
resource "aws_route_table" "route-table" {
    vpc_id = aws_vpc.MyVpc.id
    depends_on = [ aws_internet_gateway.gateway ]

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gateway.id
    } 
}
# resource "aws_internet_gateway_attachment" "gate-atachment" {
#     vpc_id = aws_vpc.MyVpc.id
#     depends_on = [ aws_internet_gateway.gateway ]
#     internet_gateway_id = aws_internet_gateway.gateway.id}


resource "aws_route_table" "private-route" {
    vpc_id = aws_vpc.MyVpc.id
    depends_on = [ aws_subnet.Private]
}
resource "aws_route_table_association" "public" {
    route_table_id = aws_route_table.route-table.id
    subnet_id =  aws_subnet.Public.id
}
resource "aws_route_table_association" "private" {
    route_table_id = aws_route_table.private-route.id
    depends_on = [ aws_route_table.private-route ]
    subnet_id = aws_subnet.Private.id
}
