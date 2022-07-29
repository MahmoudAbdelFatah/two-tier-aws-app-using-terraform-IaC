output "vpc_id" {
  value = aws_vpc.vpc1.id
}

output "private_subnet_1" {
  value = aws_subnet.private-sub-1.id
}

output "private_subnet_2" {
  value = aws_subnet.private-sub-2.id
}

output "public_subnet_1" {
  value = aws_subnet.public-sub-1.id
}

output "public_subnet_2" {
  value = aws_subnet.public-sub-2.id
}