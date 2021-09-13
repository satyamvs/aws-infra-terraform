############ SECURITY GROOUP ################
resource "aws_security_group" "opstrain-ec2-sg" {
  name        = "opstrain"
  description = "HTTP traffic"
  vpc_id      = var.opstrain-vpc

  ingress {
    description      = "http traffic from VPC"
    from_port        = 5000
    to_port          = 5000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  ingress {
    description      = "ssh from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "opstrain-ec2-sg"
    application = "opstrain"
  }
}

output "opstrain-ec2-sg" {
  value = aws_security_group.opstrain-ec2-sg.id
}