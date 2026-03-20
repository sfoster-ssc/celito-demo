# Celito Demo: Azure Hub-Spoke Landing Zone

Mini Azure hub-spoke landing zone for MSP hybrid tenants using shared services.

## Prerequisites
- [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli)
- [Terraform](https://www.terraform.io/downloads.html) (v1.5+)
- Azure subscription (Contributor role)

## Deploy Hub-Spoke
```bash
terraform init
terraform plan -out hub.plan     # Preview changes, including target tenant/subscription
terraform apply "hub.plan"       # Deploy!

## Architecture
Hub RG (rg-celito-demo-hub)
└── VNet Hub (10.0.0.0/16) <─> peering <─> VNet Spoke1 (10.1.0.0/16) [rg-celito-demo-spoke1]

## Destroy (Cost Control)
```bash
terraform plan -destroy -out=destroy.plan
terraform apply "destroy.plan"

## Notes for Production Use:
Plans saved as .tfplan - peer review before applying
State local (terraform.tfstate) - backup for team use
Parameterize tenants and commonly reused elements via variables.tf
