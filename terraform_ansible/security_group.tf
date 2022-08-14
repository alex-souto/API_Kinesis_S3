resource "aws_security_group" "sg_example" {
  name = "sg_example_name"
  description = "Allow TLS and SSH inbound trafic to the machine"

  vpc_id = aws_vpc.sample_vpc.id

  ingress {
    description = "Allow TLS Connections"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow HTTP Connections" # Certbot needs http to verify the certificate
    from_port   = 80
    to_port     = 80
    protocol    = "tcp" 
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow SSH Connections"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Challenge_sg"
  }
}

resource "aws_vpc" "sample_vpc" {
 cidr_block = "192.168.2.0/24"

 
  tags = {
        Name = "Challenge_vpc"
    }
}

resource "aws_subnet" "public_subnet" {
  cidr_block = "192.168.2.0/24"
  vpc_id = aws_vpc.sample_vpc.id
  map_public_ip_on_launch = true
  availability_zone = "${var.availability_zone}a"

  tags = {
        Name = "Challenge_subnet"
    }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.sample_vpc.id

  tags = {
        Name = "Challenge_gw"
    }
}

resource "aws_route_table" "r" {
  vpc_id = aws_vpc.sample_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
        Name = "Challenge_route_table"
    }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.r.id

}