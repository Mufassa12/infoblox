variable "environments" {
  type = map(object({
    dns_view = string
    zone     = string
    network  = string
  }))
}

# Create networks for each environment
resource "infoblox_network" "env_networks" {
  for_each     = var.environments
  network_view = "default"
  network      = each.value.network
  comment      = "Network for ${each.key} environment"
}

output "networks" {
  value = infoblox_network.env_networks
}
