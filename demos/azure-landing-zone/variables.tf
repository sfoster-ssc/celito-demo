variable "location" {
    type        = string
    description = "Azure region for celito-demo resources."
    default     = "eastus2"
}

variable "spoke1_tenant_name" {
    type        = string
    description = "Logical tenant name for the first spoke."
    default     = "tenant-a"
}

variable "spoke1_network_name" {
    type        = string
    description = "Logical network name for the first spoke."
    default     = "network-a"
}