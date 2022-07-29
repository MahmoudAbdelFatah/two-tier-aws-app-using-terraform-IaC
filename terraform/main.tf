module "network" {
  source = "./network"
  #pass args from variables file
  region = var.region
}