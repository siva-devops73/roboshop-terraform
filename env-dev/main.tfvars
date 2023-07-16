env = "dev"

components = {

  frontend = {
    tags = {Monitor = "true", env = "dev"}
  }
  mongodb  = {
    tags = {env = "dev"}
  }
  catalogue = {
    tags = {Monitor = "true", env = "dev"}
  }
  redis    = {
    tags = {env = "dev"}
  }
  cart     = {
    tags = {Monitor = "true", env = "dev"}
  }
  user     = {
    tags = {Monitor = "true", env = "dev"}
  }
  mysql    = {
    tags = {env = "dev"}
  }
  shipping = {
    tags = {Monitor = "true", env = "dev"}
  }
  dispatch = {
    tags = {Monitor = "true", env = "dev"}
  }
  rabbitmq = {
    tags = {env = "dev"}
  }
  payment  = {
    tags = {Monitor = "true", env = "dev"}
  }

}

tag {
  company_name = "Siva Infotech"
  buisness = "Ecommerce"
  project_name = "RoboShop"
}
