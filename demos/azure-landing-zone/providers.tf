terraform {
    required_version = ">= 1.3.0"

    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = ">= 3.74.0"
        }
    }
}

provider "azurerm" {
    features {}
    # skip_provider_registration = true         # Prevents auto-registration before resource providers are needed
    #
    resource_provider_registrations = "all"    # Auto-registers resource providers as needed
}