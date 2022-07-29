output "bastion" {
  value = aws_instance.Bastion_host.public_ip
}


output "privateInstance" {
  value = aws_instance.private_instance.private_ip
}