resource "aws_security_group" "sg1" {
  name   = "allow_ssh_http"
  vpc_id = module.network.vpc_id
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow_http"
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow_ssh"
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "publicInstanceSG"
  }

}

resource "aws_security_group" "sg2" {
  name   = "allow_ssh_with_port"
  vpc_id = module.network.vpc_id
  ingress {
    description     = "allow_ssh"
    from_port       = 22
    protocol        = "tcp"
    to_port         = 22
    security_groups = [aws_security_group.sg1.id]
  }
  ingress {
    description     = "allow_port"
    from_port       = 3000
    protocol        = "tcp"
    to_port         = 3000
    security_groups = [aws_security_group.sg1.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "privateInstanceSG"
  }
}