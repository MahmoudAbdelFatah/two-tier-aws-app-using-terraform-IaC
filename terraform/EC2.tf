resource "aws_instance" "Bastion_host" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.keypair.key_name
  vpc_security_group_ids = [aws_security_group.sg1.id]
  subnet_id              = module.network.public_subnet_1
  tags = {
    "Name" = "Bastion"
  }
  provisioner "local-exec" {
    command = "echo ${self.id}"

  }
}

resource "aws_instance" "private_instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.keypair.key_name
  vpc_security_group_ids = [aws_security_group.sg2.id]
  subnet_id              = module.network.private_subnet_1
  tags = {
    "Name" = "privateInstance"
  }
}