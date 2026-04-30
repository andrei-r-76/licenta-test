resource "aws_s3_bucket" "test_bucket" {
    bucket="licentatestterraformbucket"
}
resource "aws_key_pair" "test_key_pair" {
    key_name=var.test_key_name
    public_key=file("${path.module}/test_key.pub")
}

resource "aws_vpc" "test_vpc" {
    cidr_block=var.test_vpc_cidr_block
}

resource "aws_security_group" "acces_ssh" {
    name="Accepta SSH"
    description="Accepta acces SSH (port 22)"
    vpc_id=aws_vpc.test_vpc.id
}

resource "aws_security_group" "acces_http" {
    name="Accepta HTTP"
    description="Accepta acces HTTP (port 80)"
    vpc_id=aws_vpc.test_vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "accepta_ssh" {
    security_group_id = aws_security_group.acces_ssh.id
    cidr_ipv4="0.0.0.0/0"
    from_port=22
    ip_protocol="tcp"
    to_port=22
}

resource "aws_vpc_security_group_egress_rule" "accepta_outbound" {
    security_group_id = aws_security_group.acces_ssh.id
    cidr_ipv4="0.0.0.0/0"
    ip_protocol="-1"
}

resource "aws_vpc_security_group_ingress_rule" "accepta_http" {
    security_group_id = aws_security_group.acces_http.id
    cidr_ipv4="0.0.0.0/0"
    from_port=80
    ip_protocol="tcp"
    to_port=80
}

resource "aws_subnet" "test_subnet" {
    vpc_id=aws_vpc.test_vpc.id
    cidr_block=var.test_vpc_cidr_block
    map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "test_gateway" {
    vpc_id=aws_vpc.test_vpc.id
}

resource "aws_route_table" "test_public_route_table" {
    vpc_id=aws_vpc.test_vpc.id
}

resource "aws_route" "test_public_route" {
    route_table_id=aws_route_table.test_public_route_table.id
    destination_cidr_block="0.0.0.0/0"
    gateway_id=aws_internet_gateway.test_gateway.id
}

resource "aws_route_table_association" "test_association" {
  subnet_id=aws_subnet.test_subnet.id
  route_table_id=aws_route_table.test_public_route_table.id
}

resource "aws_instance" "licenta_test_VMRunner" {
    ami=var.test_ami
    instance_type=var.test_runner_instance
    tags={
        Name=var.test_runner_name
        description=var.test_runner_desc
    }
    vpc_security_group_ids=[aws_security_group.acces_ssh.id]
    key_name=aws_key_pair.test_key_pair.key_name
    subnet_id=aws_subnet.test_subnet.id
}

resource "aws_instance" "licenta_test_VMapp" {
    ami=var.test_ami
    instance_type=var.test_instance_type
    tags={
        Name=var.test_app_name
        description=var.test_app_desc
    }
    vpc_security_group_ids=[aws_security_group.acces_ssh.id, aws_security_group.acces_http.id]
    key_name=aws_key_pair.test_key_pair.key_name
    subnet_id=aws_subnet.test_subnet.id
}