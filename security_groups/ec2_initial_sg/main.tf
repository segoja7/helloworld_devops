resource "aws_security_group" "ec2_innitial" {
  name        = "ec2_innitial sg"
  description = "Allow inbound traffic"
  vpc_id      = "vpc-0f57277a8dc511b06"

  ingress {
    description      = "SSH from internet"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks       = ["181.51.32.229/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}