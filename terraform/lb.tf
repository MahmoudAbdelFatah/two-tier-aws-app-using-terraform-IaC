resource "aws_lb" "alb" {
  load_balancer_type = "application"
  subnets = [ module.network.public_subnet_1, module.network.public_subnet_2 ]
  enable_deletion_protection = false
  security_groups = [ aws_security_group.sg1.id ]
}