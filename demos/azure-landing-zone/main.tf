# Print active sub details for confirmation

# To change the target subscription if needed:

# az account list --output table
# az account set --subscription "Correct Sub Name"

data "azurerm_client_config" "current" {}

data "azurerm_subscription" "current" {}

output "active_subscription" {
    value = {
        Subscription_ID = data.azurerm_subscription.current.subscription_id
        Subscription_Name = data.azurerm_subscription.current.display_name
        Tenant_ID = data.azurerm_client_config.current.tenant_id
        Logged_In_As = data.azurerm_client_config.current.object_id
    }
    # precond = [] # Displays on 'plan' and 'apply' jobs
}

resource "azurerm_resource_group" "rg_hub" {
    name     = "rg-celito-demo-hub"
    location = var.location

    tags = {
        environment = "lab"
        owner       = "celito-demo"
    }
}

resource "azurerm_resource_group" "rg_spoke1" {
    name     = "rg-celito-demo-${var.spoke1_tenant_name}"
    location = var.location

    tags = {
        environment = "lab"
        owner       = "celito-demo"
        tenant      = var.spoke1_tenant_name
    }
}

resource "azurerm_virtual_network" "vnet_hub" {
    name                = "vnet-celito-demo-hub"
    location            = azurerm_resource_group.rg_hub.location
    resource_group_name = azurerm_resource_group.rg_hub.name
    address_space       = ["10.0.0.0/16"]

    tags = {
        environment = "lab"
        owner       = "celito-demo"
    }
}

resource "azurerm_virtual_network" "vnet_spoke1" {
    name                = "vnet-celito-demo-${var.spoke1_network_name}"
    location            = azurerm_resource_group.rg_spoke1.location
    resource_group_name = azurerm_resource_group.rg_spoke1.name
    address_space       = ["10.1.0.0/16"]

    tags = {
        environment = "lab"
        owner       = "celito-demo"
        tenant      = var.spoke1_tenant_name
    }
}

resource "azurerm_virtual_network_peering" "hub_to_spoke1" {
    name                        = "peer-hub-to-spoke1"
    resource_group_name         = azurerm_resource_group.rg_hub.name
    virtual_network_name        = azurerm_virtual_network.vnet_hub.name
    remote_virtual_network_id   = azurerm_virtual_network.vnet_spoke1.id
    allow_forwarded_traffic     = true
    allow_gateway_transit       = false
    use_remote_gateways         = false
}

resource "azurerm_virtual_network_peering" "spoke1_to_hub" {
    name                        = "peer-spoke1-to-hub"
    resource_group_name         = azurerm_resource_group.rg_spoke1.name
    virtual_network_name        = azurerm_virtual_network.vnet_spoke1.name
    remote_virtual_network_id   = azurerm_virtual_network.vnet_hub.id
    allow_forwarded_traffic     = true
    allow_gateway_transit       = false
    use_remote_gateways         = false
}