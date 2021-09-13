/*resource "aws_network_interface" "opstrain-public-eni" {
  subnet_id       = var.opstrain-public1
  #private_ips     = ["10.0.0.50"]
  #security_groups = [aws_security_group.web.id]

  attachment {
    instance     = var.app_server
    device_index = 1
  }
}

output "opstrain-public-eni" {
  value = aws_network_interface.opstrain-public-eni.id
}

resource "aws_network_interface" "opstrain-private1-eni" {
  subnet_id       = var.opstrain-private1
  #private_ips     = ["10.0.0.50"]
  #security_groups = [aws_security_group.web.id]

  attachment {
    instance     = var.opstrain-ec2-private1
    device_index = 2
  }
}

output "opstrain-private1-eni" {
  value = aws_network_interface.opstrain-private1-eni.id
}

resource "aws_network_interface" "opstrain-private2-eni" {
  subnet_id       = var.opstrain-private2
  #private_ips     = ["10.0.0.50"]
  #security_groups = [aws_security_group.web.id]

  attachment {
    instance     = var.opstrain-ec2-private2
    device_index = 3
  }
}

output "opstrain-private2-eni" {
  value = aws_network_interface.opstrain-private2-eni.id
}*/