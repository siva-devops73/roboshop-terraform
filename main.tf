module "vpc" {
  source         = "git::https://github.com/siva-devops73/tf-module-vpc.git"

  for_each       = var.vpc
  cidr_block     = each.value["cidr_block"]
  subnets        = each.value["subnets"]

  env            = var.env
  tags           = var.tags
  default_vpc_id = var.default_vpc_id
  default_vpc_rpt = var.default_vpc_rpt
}


#module "app_server" {
#  source      = "git::https://github.com/siva-devops73/tf-module-app.git"

#  env            = var.env
#  tags           = var.tags
#  components     = "test"
#  subnet_id      = lookup(lookup(lookup(lookup(module.vpc, "main", null), "subnet_ids", null), "app", null), "subnet_ids", null)

output "subnets_ids" {
  value = module.vpc
}