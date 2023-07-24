module "vpc" {
  source         = "git::https://github.com/siva-devops73/tf-module-vpc.git"

  for_each       = var.vpc
  cidr_block     = each.value["cidr_block"]
  subnets        = each.value["subnets"]

  env            = var.env
  tags           = var.tags
  default_vpc_id = var.default_vpc_id
}


#module "vpc" {
#  source      = "git::https://github.com/siva-devops73/tf-module-app.git"

#  env            = var.env
#  tags           = var.tags
 # components     = var.components
 # subnet_id      =

output "subnets_ids" {
  value = module.vpc
}