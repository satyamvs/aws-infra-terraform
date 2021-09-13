# Creating VPC
resource "aws_vpc" "opstrain-vpc" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "false"
  tags = {
    Name = "opstrain-vpc"
    application = "opstrain"
  }
}
output "opstrain-vpc" {
  value = aws_vpc.opstrain-vpc.id
}

resource "aws_subnet" "opstrain-public1" {
  vpc_id     = aws_vpc.opstrain-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "opstrain-public1"
    application = "opstrain"
  }
}
output "opstrain-public1" {
  value = aws_subnet.opstrain-public1.id
}

resource "aws_subnet" "opstrain-public2" {
  vpc_id     = aws_vpc.opstrain-vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "opstrain-public2"
    application = "opstrain"
  }
}
output "opstrain-public2" {
  value = aws_subnet.opstrain-public2.id
}

resource "aws_subnet" "opstrain-public3" {
  vpc_id     = aws_vpc.opstrain-vpc.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "opstrain-public3"
    application = "opstrain"
  }
}
output "opstrain-public3" {
  value = aws_subnet.opstrain-public3.id
}

resource "aws_subnet" "opstrain-private1" {
  vpc_id     = aws_vpc.opstrain-vpc.id
  cidr_block = "10.0.10.0/24"

  tags = {
    Name = "opstrain-private1"
    application = "opstrain"
  }
}
output "opstrain-private1" {
  value = aws_subnet.opstrain-private1.id
}

resource "aws_subnet" "opstrain-private2" {
  vpc_id     = aws_vpc.opstrain-vpc.id
  cidr_block = "10.0.20.0/24"

  tags = {
    Name = "opstrain-private2"
    application = "opstrain"
  }
}
output "opstrain-private2" {
  value = aws_subnet.opstrain-private2.id
}

resource "aws_subnet" "opstrain-private3" {
  vpc_id     = aws_vpc.opstrain-vpc.id
  cidr_block = "10.0.30.0/24"

  tags = {
    Name = "opstrain-private3"
    application = "opstrain"
  }
}
output "opstrain-private3" {
  value = aws_subnet.opstrain-private3.id
}

resource "aws_nat_gateway" "opstrain-natgw" {
  allocation_id = aws_eip.opstrain-eip.id
  subnet_id     = aws_subnet.opstrain-public1.id

  tags = {
    Name = "opstrain-natgw"
    application = "opstrain"
  }
  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  #depends_on = [aws_internet_gateway.opstrain-internetgw.id]
}
output "opstrain-natgw" {
  value = aws_nat_gateway.opstrain-natgw.id
}

resource "aws_eip" "opstrain-eip" {
  vpc = true

}
output "opstrain-eip" {
  value=aws_eip.opstrain-eip.id
}

resource "aws_eip" "opstrain-ec2-eip" {
  vpc = true

}
output "opstrain-ec2-eip" {
  value=aws_eip.opstrain-ec2-eip.id
}

resource "aws_internet_gateway" "opstrain-internetgw" {
  vpc_id = aws_vpc.opstrain-vpc.id

  tags = {
    Name = "opstrain-internetgw"
    application = "opstrain"
  }
}

resource "aws_route_table" "opstrain-rtpub" {
  vpc_id = aws_vpc.opstrain-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.opstrain-internetgw.id
  }
  tags = {
    Name = "opstrain-rtpub"
    application = "opstrain"
  }
}

resource "aws_route_table" "opstrain-rtpri" {
  vpc_id = aws_vpc.opstrain-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.opstrain-natgw.id
  }

  tags = {
    Name = "opstrain-rtpri"
    application = "opstrain"
  }
}

resource "aws_route_table_association" "opstrain-rtapub1" {
  subnet_id      = aws_subnet.opstrain-public1.id
  route_table_id = aws_route_table.opstrain-rtpub.id

}

resource "aws_route_table_association" "opstrain-rtapub2" {
  subnet_id      = aws_subnet.opstrain-public2.id
  route_table_id = aws_route_table.opstrain-rtpub.id

}

resource "aws_route_table_association" "opstrain-rtapub3" {
  subnet_id      = aws_subnet.opstrain-public3.id
  route_table_id = aws_route_table.opstrain-rtpub.id

}

resource "aws_route_table_association" "opstrain-rtapri1" {
  subnet_id      = aws_subnet.opstrain-private1.id
  route_table_id = aws_route_table.opstrain-rtpri.id

}

resource "aws_route_table_association" "opstrain-rtapri2" {
  subnet_id      = aws_subnet.opstrain-private2.id
  route_table_id = aws_route_table.opstrain-rtpri.id


}

resource "aws_route_table_association" "opstrain-rtapri3" {
  subnet_id      = aws_subnet.opstrain-private3.id
  route_table_id = aws_route_table.opstrain-rtpri.id
}