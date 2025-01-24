# Infoblox Terraform Configuration

This Terraform configuration manages DNS and IP address management (IPAM) in Infoblox for hybrid cloud environments using Terraform Cloud for state and variable management.

## Prerequisites

- Terraform v1.0.0 or later
- Access to an Infoblox Grid Manager
- Terraform Cloud account
- Terraform Infoblox Provider v2.0 or later

## Terraform Cloud Setup

1. Create a workspace in Terraform Cloud named `infoblox-infrastructure`

2. Configure the following variables in your Terraform Cloud workspace:

   ### Environment Variables
   - `INFOBLOX_SERVER` - Your Infoblox Grid Manager URL
   - `INFOBLOX_USERNAME` - Your Infoblox username
   - `INFOBLOX_PASSWORD` - Your Infoblox password (mark as sensitive)

   ### Terraform Variables
   ```hcl
   environments = {
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
   ```

## Quick Start

1. Clone this repository

2. Login to Terraform Cloud:
   ```bash
   terraform login
   ```

3. Initialize Terraform:
   ```bash
   terraform init
   ```

4. Review the planned changes:
   ```bash
   terraform plan
   ```

5. Apply the configuration:
   ```bash
   terraform apply
   ```

## Module Details

### DNS Module
- Creates DNS views (Internal and Cloud)
- Manages parent and child DNS zones
- Supports multiple environments

### Network Module
- Manages networks for different environments
- Handles IPAM configuration
- Supports multiple network views

### Services Module
- Manages service-specific DNS records
- Handles IP allocation for services
- Configures conditional forwarders

## Environment Configuration

The configuration supports multiple environments through the `environments` variable:

```hcl
environments = {
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
```

## Adding New Environments

To add a new environment:

1. Add a new entry to the `environments` variable in `terraform.tfvars`:
   ```hcl
   environments = {
     // ...existing environments...
     gcp = {
       dns_view = "Cloud"
       zone     = "gcp.corp.local"
       network  = "10.3.0.0/24"
     }
   }
   ```

2. Apply the changes:
   ```bash
   terraform apply
   ```

## Best Practices

1. Use Terraform Cloud's VCS integration for automatic runs
2. Leverage workspace variables for environment-specific values
3. Use variable sets for common variables across workspaces
4. Enable sentinel policies for governance
5. Review plans carefully before applying changes

## Troubleshooting

Common issues and solutions:

1. Terraform Cloud Authentication:
   - Ensure you're logged in with `terraform login`
   - Verify API token permissions

2. Variable Issues:
   - Check variable configuration in Terraform Cloud
   - Verify environment variable names match configuration

3. State Issues:
   - Review state in Terraform Cloud UI
   - Use state management tools in Terraform Cloud

## Contributing

1. Fork the repository
2. Create a feature branch
3. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.