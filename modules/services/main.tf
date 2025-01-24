variable "environments" {
  type = map(object({
    dns_view = string
    zone     = string
    network  = string
  }))
}

variable "networks" {
  type = map(any)
}

# Example service deployment in each environment
resource "infoblox_ip_allocation" "services" {
  for_each     = var.environments
  network_view = "default"
  cidr         = var.networks[each.key].network
  dns_view     = each.value.dns_view
  enable_dns   = true
  fqdn         = "service.${each.value.zone}"
}

# Create conditional forwarders for cloud zones
resource "infoblox_zone_forward" "cloud_forwards" {
  for_each = {
    for k, v in var.environments : k => v
    if v.dns_view == "Cloud"
  }
  
  fqdn         = each.value.zone
  dns_view     = "Internal"
  forward_to   = ["${cidrhost(each.value.network, 2)}"]
  forward_type = "FORWARD_ONLY"
}
