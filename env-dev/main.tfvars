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
    component = "mysql"
    engine    = "aurora_mysql"
    engine_version = "5.7.mysql_aurora.2.11.3"
    database_name = "dummy"
    instance_count = 1
    instance_class = "db.t3.small"

  }
}