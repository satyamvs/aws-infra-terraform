#Create a new load balancer
resource "aws_elb" "opstrain-webapp" {
  name = "opstrain-elb"
  security_groups = [var.opstrain-ec2-sg]
  subnets =[var.opstrain-public1,var.opstrain-private1]
  #availability_zones = ["us-east-1a","us-east-1b","us-east-1c"]

  /*access_logs {
    bucket = "foo"
    bucket_prefix = "bar"
    interval = 60
  }*/

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
    #ssl_certificate_id = "arn:aws:iam::123456789012:server-certificate/certName"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTP:80/"
    interval = 30
  }

  #number_of_instances = 2
  instances = [var.opstrain-ec2-app_server,var.opstrain-ec2-private1]
  cross_zone_load_balancing = true
  idle_timeout = 400
  connection_draining = true
  connection_draining_timeout = 400

  tags = {
    Name = "opstrain-webapp"
    application = "opstrain"
  }

}

output "opstrain-webapp" {
  value = aws_elb.opstrain-webapp.id
}


/*# Create a new load balancer attachment
resource aws_elb_attachment "opstain-webapp-attachment1" {

  elb      = aws_elb.opstrain-webapp.id
  #number_of_instances = 2
  instance = var.opstrain-ec2-private1
}

/*output "opstrain-webapp-attachment1" {
  value = aws_elb_attachment.opstrain-webapp-attachment1.id
}


resource aws_elb_attachment "opstain-webapp-attachment2" {

  elb      = aws_elb.opstrain-webapp.id
  #number_of_instances = 2
  instance = var.opstrain-ec2-private2
}

/*output "opstrain-webapp-attachment2" {
  value = aws_elb_attachment.opstrain-webapp-attachment2.id
}*/
