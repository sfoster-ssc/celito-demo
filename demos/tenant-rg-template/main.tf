locals {
    common_tags = {
        msp         = "celito-demo"
        managed_by  = "sfoster"
        compliance  = "soc2-baseline"
    }
}

resource "azurerm_resource_group" "rg_tenant" {
    name     = "rg-${var.tenant_name}-${var.environment}"
    location = var.location

    tags = merge(local.common_tags, {
        tenant      = var.tenant_name
        environment = var.environment
    })
}

resource "azurerm_virtual_network" "vnet_tenant" {
    name                = "vnet-${var.tenant_name}-${var.environment}"
    location            = var.location
    resource_group_name = azurerm_resource_group.rg_tenant.name
    address_space       = ["10.${var.tenant_octet}.0.0/16"]

    tags = local.common_tags
}

resource "azurerm_subnet" "subnet_tenant" {
    name                    = "snet-${var.tenant_name}-default"
    resource_group_name     = azurerm_resource_group.rg_tenant.name
    virtual_network_name    = azurerm_virtual_network.vnet_tenant.name
    address_prefixes        = ["10.${var.tenant_octet}.0.0/24"]
}

resource "azurerm_network_security_group" "nsg_tenant" {
    name                    = "nsg-${var.tenant_name}-${var.environment}"
    location                = azurerm_resource_group.rg_tenant.location
    resource_group_name     = azurerm_resource_group.rg_tenant.name

    security_rule {
        name                        = "Allow-Bastion-RDP"
        priority                    = 1001
        direction                   = "Inbound"
        access                      = "Allow"
        protocol                    = "Tcp"
        source_port_range           = "*"
        destination_port_range      = "3389"
        source_address_prefix       = "GatewayManager" # Bastion only
        destination_address_prefix  = "*"
    }

    tags = local.common_tags
}

resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
    subnet_id                   = azurerm_subnet.subnet_tenant.id
    network_security_group_id   = azurerm_network_security_group.nsg_tenant.id
}