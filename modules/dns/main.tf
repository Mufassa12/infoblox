variable "environments" {
  type = map(object({
    dns_view = string
    zone     = string
    network  = string
  }))
}

# Create DNS Views
resource "infoblox_dns_view" "views" {
  for_each = toset(["Internal", "Cloud"])
  name     = each.key
}

# Create parent DNS zone
resource "infoblox_zone_auth" "parent_zone" {
  fqdn        = "corp.local"
  zone_format = "FORWARD"
  dns_view    = "Internal"
  depends_on  = [infoblox_dns_view.views]
}

# Create DNS zones for each environment
resource "infoblox_zone_auth" "env_zones" {
  for_each    = var.environments
  fqdn        = each.value.zone
  zone_format = "FORWARD"
  dns_view    = each.value.dns_view
  depends_on  = [infoblox_dns_view.views, infoblox_zone_auth.parent_zone]
}

output "dns_views" {
  value = infoblox_dns_view.views
}
