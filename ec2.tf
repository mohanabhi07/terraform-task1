

resource "aws_instance" "web_server_a" {
  ami           = "ami-079ae45378903f993"  
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public_subnet_a.id
  associate_public_ip_address = "true"
  key_name = "Demo"
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  user_data = <<EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install httpd -y
              sudo systemctl start httpd
            EOF

  tags = {
    Name = "WebServer_a"
  }
}

resource "aws_instance" "web_server_b" {
  ami           = "ami-079ae45378903f993"  
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public_subnet_b.id
  associate_public_ip_address = "true"
  key_name = "Demo"
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install httpd -y
              sudo systemctl start httpd
            EOF

  tags = {
    Name = "WebServer_b"
  }
}

output "webserver1_public_ip" {
  value = aws_instance.web_server_a.public_ip
}

output "webserver2_public_ip" {
  value = aws_instance.web_server_b.public_ip
}

