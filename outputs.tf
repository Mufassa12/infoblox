# DNS Outputs
output "dns_views" {
  description = "Configured DNS views in Infoblox"
  value       = module.dns.dns_views
}

output "dns_zones" {
  description = "All DNS zones created across environments"
  value = {
    for env, zone in var.environments : env => zone.zone
  }
}

# Network Outputs
output "networks" {
  description = "Network configurations for all environments"
  value       = module.network.networks
}

output "network_summary" {
  description = "Summary of network allocations by environment"
  value = {
    for env, config in var.environments : env => {
      network = config.network
      dns_view = config.dns_view
    }
  }
}

# Service Outputs
output "service_allocations" {
  description = "IP allocations for services across environments"
  value       = module.services.allocated_ips
}

output "dns_forwarders" {
  description = "Configured DNS forwarders for cloud environments"
  value       = module.services.forwarders
}
