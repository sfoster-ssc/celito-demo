# 🚀 Celito Interview Prep: Azure MSP Patterns

Hands‑on Terraform demos for **Senior Cloud Engineer** role at Celito. Built March 2026.

## 🎯 What you'll find

| Demo | Purpose | When MSPs use it |
|------|---------|------------------|
| [azure-landing-zone](demos/azure-landing-zone) | Hub‑spoke with peering | Complex/hybrid tenants needing shared MSP services |
| [tenant-rg-template](demos/tenant-rg-template) | Isolated RG/VNet/NSG | Baseline clients—day‑to‑day onboarding |

## 🚀 Quick Deploy (any demo)


cd ./demos/tenant-rg-template
terraform init
terraform plan
terraform apply

Destroy:
cd .demos/tenant-rg-template
terraform destroy

## Why these patterns?
- Repeatable, extensible steps for tenant deployments
- Bite-sized, progressive complexity
- Secure baseline (locked-down RDP access for Network Security Group)
