resource "aws_lb_target_group" "target-group" {
  name        = "TG-alb"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = module.network.vpc_id
}

resource "aws_lb" "alb" {
  name                       = "alb"
  load_balancer_type         = "application"
  internal                   = false
  security_groups            = [aws_security_group.sg1.id]
  subnets                    = [module.network.public_subnet_1, module.network.public_subnet_2]
  enable_deletion_protection = false
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.target-group.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group_attachment" "attach-ec2" {
  target_group_arn = aws_lb_target_group.target-group.arn
  target_id        = aws_instance.Bastion_host.id
  port             = 80
}