resource "aws_db_instance" "mysql_db" {
  allocated_storage      = 10
  db_name                = var.name
  username               = var.username
  password               = var.password
  engine                 = var.engine_mysql
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  parameter_group_name   = var.parameter_group_name_mysql
  vpc_security_group_ids = [aws_security_group.sg2.id]
  db_subnet_group_name   = aws_db_subnet_group.mysql-subnet.name
  publicly_accessible = true
  
}

resource "aws_db_subnet_group" "mysql-subnet" {
  name       = "mysql-subnet"
  subnet_ids = [module.network.private_subnet_1, module.network.private_subnet_2]
}

resource "aws_elasticache_cluster" "redis_elastic_cluster" {
  cluster_id           = var.cluster_id
  engine               = var.engine_redis
  node_type            = var.node_type
  num_cache_nodes      = var.num_cache_nodes
  parameter_group_name = var.parameter_group_name_redis
  security_group_ids   = [aws_security_group.sg2.id]
  subnet_group_name    = aws_elasticache_subnet_group.redis-subnet.name
  port = var.port
}

resource "aws_elasticache_subnet_group" "redis-subnet" {
  name       = "redis-subnet"
  subnet_ids = [module.network.private_subnet_1, module.network.private_subnet_1]
}