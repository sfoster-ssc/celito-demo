# MSP Tenant RG Template

Basic template for SMB Azure clients:

## Prerequisites
- [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli)
- [Terraform](https://www.terraform.io/downloads.html) (v1.5+)
- Azure subscription (Contributor role)

## Bastion-secure NSG baseline

Parameterized tenant_name, environment, address_space
MSP compliance tags

```bash
terraform init
terraform plan -out hub.tfplan     # Preview changes, including target tenant/subscription
terraform apply -var="tenant_name=acme-corp" -var="tenant_octet=1"       # Deploy!

## Design

└── Tenant VNet (10.$.0.0/16) _]

## Destroy (Cost Control)

terraform plan -destroy -out=destroy.plan
terraform apply "destroy.plan"

## Notes for Production Use:
Plans saved as .tfplan - peer review before applying
State local (terraform.tfstate) - backup for team use
Parameterize tenants and commonly reused elements via variables.tf
Produces: rg-acme-corp-prod + locked NSG (Bastion RDP only).
