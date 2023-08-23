env = "dev"

tags = {
  company_name = "Siva Infotech"
  buisness = "Ecommerce"
  project_name = "RoboShop"
}

vpc = {
  main = {
    cidr_block = "10.0.0.0/16"
    subnets = {
      web    = { cidr_block = [ "10.0.0.0/24", "10.0.1.0/24" ] }
      app    = { cidr_block = [ "10.0.2.0/24", "10.0.3.0/24" ] }
      db     = { cidr_block = [ "10.0.4.0/24", "10.0.5.0/24" ] }
      public = { cidr_block = [ "10.0.6.0/24", "10.0.7.0/24" ] }
    }
  }
}

default_vpc_id = "vpc-0a0f029426bb6712b"
default_vpc_rt = "rtb-0bfd661b06433b242"
zone_id        = "Z07939863Q47686AYR05W"
kms_key_id     = "4c8938fc-8309-49ca-b140-218281d4c8da"
kms_key_arn    = "arn:aws:kms:us-east-1:904827379241:key/4c8938fc-8309-49ca-b140-218281d4c8da"
allow_ssh_cidr = [ "172.31.9.143/32" ]

rabbitmq = {
  main = {
    instance_type = "t3.small"
    component     = "rabbitmq"
  }
}


rds = {
  main = {
    component = "rds"
    engine    = "aurora-mysql"
    engine_version = "5.7.mysql_aurora.2.11.3"
    database_name = "dummy"
    instance_count = 1
    instance_class = "db.t3.small"

  }
}

documentdb = {
  main = {
    component = "docdb"
    engine    = "docdb"
    engine_version = "4.0.0"
    instance_count = 1
    instance_class = "db.t3.medium"
  }
}

elasticache = {
  main = {
    component = "elasticache"
    engine    = "redis"
    engine_version = "6.2"
    node_type  = "cache.t3.micro"
    num_node_groups = 1
    replicas_per_node_group = 1
  }
}

alb = {
  public = {
    name                = "public"
    internal            = false
    load_balancer_type  = "application"
    subnet_ref          = "public"
  }
  private = {
    name                = "private"
    internal            = false
    load_balancer_type  = "application"
    subnet_ref          = "app"
  }
}

apps = {
  cart = {
    component = "cart"
    app_port  = 8080
    instance_type = "t3.small"
    desired_capacity = 1
    max_size = 1
    min_size = 1
    subnet_ref = "app"
    lb_ref     = "private"
    lb_rule_priority = 101
  }
  catalogue = {
    component = "catalogue"
    app_port  = 8080
    instance_type = "t3.small"
    desired_capacity = 1
    max_size = 1
    min_size = 1
    subnet_ref = "app"
    lb_ref     = "private"
    lb_rule_priority = 102
  }
  user = {
    component = "user"
    app_port  = 8080
    instance_type = "t3.small"
    desired_capacity = 1
    max_size = 1
    min_size = 1
    subnet_ref = "app"
    lb_ref     = "private"
    lb_rule_priority = 103
  }
  shipping = {
    component = "shipping"
    app_port  = 8080
    instance_type = "t3.small"
    desired_capacity = 1
    max_size = 1
    min_size = 1
    subnet_ref = "app"
    lb_ref     = "private"
    lb_rule_priority = 104
  }
  payment = {
    component = "payment"
    app_port  = 8080
    instance_type = "t3.small"
    desired_capacity = 1
    max_size = 1
    min_size = 1
    subnet_ref = "app"
    lb_ref     = "private"
    lb_rule_priority = 105
  }
  dispatch = {
    component = "dispatch"
    app_port  = 8080
    instance_type = "t3.small"
    desired_capacity = 1
    max_size = 1
    min_size = 1
    subnet_ref = "app"
    lb_ref     = "private"
    lb_rule_priority = 106
  }
  frontend = {
    component = "frontend"
    app_port  = 80
    instance_type = "t3.small"
    desired_capacity = 1
    max_size = 1
    min_size = 1
    subnet_ref = "web"
    lb_ref     = "public"
    lb_rule_priority = 100
  }
}