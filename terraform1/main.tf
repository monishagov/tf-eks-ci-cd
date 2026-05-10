resource "aws_security_group" "sg" {
  name = "capstone-sg"

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2" {
  ami           = "ami-080254318c2d8932f"
  instance_type = "t3.micro"
  key_name      = "edureka"

  security_groups = [aws_security_group.sg.name]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install docker.io -y
              systemctl start docker

              docker run -d -p 3000:3000 monishashuba/abc_tech:$BUILD_NUMBER
              EOF

  tags = {
    Name = "Capstone-App"
  }
}
