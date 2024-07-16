env = "prod"

tags = {
  company_name = "Siva Infotech"
  buisness = "Ecommerce"
  project_name = "RoboShop"
}

vpc = {
  main = {
    cidr_block = "10.10.0.0/16"
    subnets = {
      web    = { cidr_block = [ "10.10.0.0/24", "10.10.1.0/24" ] }
      app    = { cidr_block = [ "10.10.2.0/24", "10.10.3.0/24" ] }
      db     = { cidr_block = [ "10.10.4.0/24", "10.10.5.0/24" ] }
      public = { cidr_block = [ "10.10.6.0/24", "10.10.7.0/24" ] }
    }
  }
}

default_vpc_id = "vpc-0a0f029426bb6712b"
default_vpc_rt = "rtb-0bfd661b06433b242"
zone_id        = "Z07939863Q47686AYR05W"
kms_key_id     = "4c8938fc-8309-49ca-b140-218281d4c8da"
kms_key_arn    = "arn:aws:kms:us-east-1:904827379241:key/4c8938fc-8309-49ca-b140-218281d4c8da"
allow_ssh_cidr = [ "172.31.9.143/32" ]
allow_prometheus_cidr = ["172.31.85.119/32"]

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
    instance_class = "db.t3.medium"

  }
}

documentdb = {
  main = {
    component = "docdb"
    engine    = "docdb"
    engine_version = "4.0.0"
    db_instance_count = 1
    instance_class = "db.t3.medium"
  }
}

elasticache = {
  main = {
    component = "elasticache"
    engine    = "redis"
    engine_version = "6.x"
    node_type  = "cache.t3.medium"
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
    internal            =  true
    load_balancer_type  = "application"
    subnet_ref          = "app"
  }
}

apps = {
  cart = {
    component = "cart"
    app_port  = 8080
    instance_type = "t3.micro"
    desired_capacity = 2
    max_size = 5
    min_size = 2
    subnet_ref = "app"
    lb_ref     = "private"
    lb_rule_priority = 101
  }
  catalogue = {
    component = "catalogue"
    app_port  = 8080
    instance_type = "t3.small"
    desired_capacity = 2
    max_size = 5
    min_size = 2
    subnet_ref = "app"
    lb_ref     = "private"
    lb_rule_priority = 102
    extra_param_access = ["arn:aws:ssm:us-east-1:904827379241:parameter/roboshop.prod.docdb.*"]
  }
  user = {
    component = "user"
    app_port  = 8080
    instance_type = "t3.small"
    desired_capacity = 2
    max_size = 5
    min_size = 2
    subnet_ref = "app"
    lb_ref     = "private"
    lb_rule_priority = 103
    extra_param_access = ["arn:aws:ssm:us-east-1:904827379241:parameter/roboshop.prod.docdb.*"]
  }
  shipping = {
    component = "shipping"
    app_port  = 8080
    instance_type = "t3.medium"
    desired_capacity = 3
    max_size = 6
    min_size = 3
    subnet_ref = "app"
    lb_ref     = "private"
    lb_rule_priority = 104
    extra_param_access = ["arn:aws:ssm:us-east-1:904827379241:parameter/roboshop.prod.mysql.*"]
  }
  payment = {
    component = "payment"
    app_port  = 8080
    instance_type = "t3.small"
    desired_capacity = 2
    max_size = 5
    min_size = 2
    subnet_ref = "app"
    lb_ref     = "private"
    lb_rule_priority = 105
  }
  dispatch = {
    component = "dispatch"
    app_port  = 8080
    instance_type = "t3.micro"
    desired_capacity = 2
    max_size = 5
    min_size = 2
    subnet_ref = "app"
    lb_ref     = "private"
    lb_rule_priority = 106
  }
  frontend = {
    component = "frontend"
    app_port  = 80
    instance_type = "t3.small"
    desired_capacity = 2
    max_size = 5
    min_size = 2
    subnet_ref = "web"
    lb_ref     = "public"
    lb_rule_priority = 100
  }
}

eks = {
  main = {
    subnet_ref = "app"
    min_size   = 2
    max_size   = 2
    capacity_type = "SPOT"
    instance_types  = ["t3.xlarge", "t3.large", "t3.medium"]
  }
}