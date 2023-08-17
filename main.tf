module "vpc" {
  source         = "git::https://github.com/siva-devops73/tf-module-vpc.git"

  for_each       = var.vpc
  cidr_block     = each.value["cidr_block"]
  subnets        = each.value["subnets"]

  env            = var.env
  tags           = var.tags
  default_vpc_id = var.default_vpc_id
  default_vpc_rt = var.default_vpc_rt
}


#module "rabbitmq" {
  #source          = "git::https://github.com/siva-devops73/tf-module-rabbitmq.git"

  #for_each        = var.rabbitmq
  #component       = each.value["component"]
  #instance_type   = each.value["instance_type"]

  #sg_subnet_cidr  = lookup(lookup(lookup(lookup(var.vpc, "main", null), "subnets", null), "app", null), "cidr_block", null)
  #vpc_id          = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
  #subnet_id       = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnet_ids", null), "db", null), "subnet_ids", null)[0]

  #env             = var.env
  #tags            = var.tags
  #allow_ssh_cidr  = var.allow_ssh_cidr
  #zone_id         = var.zone_id
  #kms_key_id      = var.kms_key_id

#}


#module "rds" {
  #source = "git::https://github.com/siva-devops73/tf-module-rds.git"

  #for_each          = var.rds
  #component         = each.value["component"]
  #engine            = each.value["engine"]
  #engine_version    = each.value["engine_version"]
  #database_name     = each.value["database_name"]
  #instance_count    = each.value["instance_count"]
  #instance_class    = each.value["instance_class"]

  #subnet_ids        = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnet_ids", null), "db", null), "subnet_ids", null)
  #vpc_id            = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
  #sg_subnet_cidr    = lookup(lookup(lookup(lookup(var.vpc, "main", null), "subnets", null), "app", null), "cidr_block", null)

  #kms_key_arn       = var.kms_key_arn
  #env               = var.env
  #tags              = var.tags

#}


#module "documentdb" {
  #source = "git::https://github.com/siva-devops73/tf-module-documentdb.git"

  #for_each          = var.documentdb
  #component         = each.value["component"]
  #engine            = each.value["engine"]
  #engine_version    = each.value["engine_version"]
  #instance_count    = each.value["instance_count"]
  #instance_class    = each.value["instance_class"]

  #subnet_ids        = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnet_ids", null), "db", null), "subnet_ids", null)
  #vpc_id            = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
  #sg_subnet_cidr    = lookup(lookup(lookup(lookup(var.vpc, "main", null), "subnets", null), "app", null), "cidr_block", null)

  #kms_key_arn       = var.kms_key_arn
  #env               = var.env
  #tags              = var.tags

#}


#module "elasticache" {
  #source = "git::https://github.com/siva-devops73/tf-module-elasticache.git"

  #for_each               = var.elasticache
  #component              = each.value["component"]
  #engine                 = each.value["engine"]
  #engine_version         = each.value["engine_version"]
  #node_type              = each.value["node_type"]
  #num_node_groups        = each.value["num_node_groups"]
  #replicas_per_node_group = each.value["replicas_per_node_group"]


  #subnet_ids              = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnet_ids", null), "db", null), "subnet_ids", null)
  #vpc_id                  = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
  #sg_subnet_cidr          = lookup(lookup(lookup(lookup(var.vpc, "main", null), "subnets", null), "app", null), "cidr_block", null)

  #kms_key_arn             = var.kms_key_arn
  #env                     = var.env
  #tags                    = var.tags

#}


module "alb" {
  source = "git::https://github.com/siva-devops73/tf-module-alb.git"

  for_each                  = var.alb
  name                      = each.value["name"]
  internal                  = each.value["internal"]
  load_balancer_type        = each.value["load_balancer_type"]


  vpc_id                  = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
  sg_subnet_cidr          = each.value["name"] == "public" ? ["0.0.0.0/0"] : local.app_web_subnet_cidr
  subnets                 = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnet_ids", null), each.value["subnet_ref"], null), "subnet_ids", null)


  env                     = var.env
  tags                    = var.tags

}


module "apps" {
  source      = "git::https://github.com/siva-devops73/tf-module-app.git"

  for_each         =  var.apps
  app_port         = each.value["app_port"]
  desired_capacity = each.value["desired_capacity"]
  instance_type   = each.value["instance_type"]
  max_size        = each.value["max_size"]
  min_size        = each.value["min_size"]
  component      = each.value["component"]


  sg_subnets_cidr = lookup(lookup(lookup(lookup(var.vpc, "main", null), "subnets", null), each.value["subnet_ref"], null), "cidr_block", null)
  subnets         = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnet_ids", null), each.value["subnet_ref"], null), "subnet_ids", null)
  vpc_id          = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
  //module.vpc["subnet_ids"]["app"]["subnet_ids'][0]

  env            = var.env
  tags           = var.tags
  kms_key_id     = var.kms_key_arn
  allow_ssh_cidr = var.allow_ssh_cidr
}





