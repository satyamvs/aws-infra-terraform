resource "aws_instance" "app_server" {
  ami           = "ami-0aeeebd8d2ab47354"
  instance_type = "t2.micro"
  security_groups = [var.ec2-sg]
  subnet_id = var.opstrain-public1
  user_data = file("./modules/ec2/ngnix_install.sh")
  key_name = "ops-train-new"
  #opstrain-ec2-eip = var.opstrain-ec2-eip.id


  tags = {
    Name = "app_server"
    application = "opstrain"
  }
}
output "app_server" {
  value = aws_instance.app_server.id
}


resource "aws_eip_association" "opstrain_eip_assoc" {
  instance_id   = aws_instance.app_server.id
  allocation_id = var.opstrain-ec2-eip
}

resource "aws_instance" "opstrain-ec2-private1" {
  ami           = "ami-0aeeebd8d2ab47354"
  instance_type = "t2.micro"
  subnet_id = var.opstrain-private1
  security_groups = [var.ec2-sg]
  key_name = "ops-train-new"

  tags = {
    Name = "opstrain-ec2-private1"
    application = "opstrain"
  }
}
output "opstrain-ec2-private1" {
  value = aws_instance.opstrain-ec2-private1.id
}
/*resource "aws_instance" "opstrain-ec2-private2" {
  ami           = "ami-0aeeebd8d2ab47354"
  instance_type = "t2.micro"
  subnet_id = var.opstrain-private2
  #security_groups = [var.ec2-sg]
  key_name = "ops-train"

  tags = {
    Name = "opstrain-ec2-private2"
    application = "opstrain"
  }
}
output "opstrain-ec2-private2" {
  value = aws_instance.opstrain-ec2-private2.id
}*/


