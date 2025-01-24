variable "infoblox_server" {
  description = "Infoblox NIOS Grid Manager"
  type        = string
}

variable "infoblox_username" {
  description = "Username for Infoblox authentication"
  type        = string
}

variable "infoblox_password" {
  description = "Password for Infoblox authentication"
  type        = string
  sensitive   = true
}

variable "environments" {
  description = "Environment configurations"
  type = map(object({
    dns_view = string
    zone     = string
    network  = string
  }))
  default = {
    onprem = {
      dns_view = "Internal"
      zone     = "corp.local"
      network  = "172.16.0.0/24"
    }
    aws = {
      dns_view = "Cloud"
      zone     = "aws.corp.local"
      network  = "10.1.0.0/24"
    }
    azure = {
      dns_view = "Cloud"
      zone     = "azure.corp.local"
      network  = "10.2.0.0/24"
    }
  }
}
