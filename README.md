# Celito Interview Prep: Azure MSP Patterns

Hands-on IaC demos for Senior Cloud Engineer role.

## Structure

demos/
├── azure-landing-zone/ # CAF-style hub-spoke (complex tenants using MSP shared resources)
├── tenant-rg-template/ # SMB client onboarding with network security group configured
├── lighthouse-arm-sim/ # Lighthouse MSP onboarding and management of tenants
├── m365-ca-template/   # Conditional Access template for SMB M365 tenants

## Quick Deploy

```bash
cd demos/<demo-name>
terraform init && terraform apply

Built March 2026 to demonstrate multi-tenant deployment and management patterns.
