terraform {
  cloud {
    organization = "your-org-name"
    workspaces {
      name = "infoblox-infrastructure"
    }
  }

  required_providers {
    infoblox = {
      source  = "infoblox/infoblox"
      version = "~> 2.0"
    }
  }
}

provider "infoblox" {
  server     = var.infoblox_server
  username   = var.infoblox_username
  password   = var.infoblox_password
  sslverify  = false
}

module "dns" {
  source       = "./modules/dns"
  environments = var.environments
}

module "network" {
  source       = "./modules/network"
  environments = var.environments
}

module "services" {
  source       = "./modules/services"
  environments = var.environments
  networks     = module.network.networks
  depends_on   = [module.dns]
}
