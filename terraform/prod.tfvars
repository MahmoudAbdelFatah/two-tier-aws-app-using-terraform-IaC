region        = "us-east-1"
ami           = "ami-0cff7528ff583bf9a"
instance_type = "t2.micro"

engine_mysql               = "mysql"
engine_version             = "8.0.28"
instance_class             = "db.t3.micro"
name                       = "mysql_db"
username                   = "admin"
password                   = "password"
parameter_group_name_mysql = "default.mysql8.0"

cluster_id                 = "cluster-test"
engine_redis               = "redis"
node_type                  = "cache.t2.micro"
num_cache_nodes            = 1
parameter_group_name_redis = "default.redis6.x"
engine_version_redis       = "6.2"
port                       = 6379