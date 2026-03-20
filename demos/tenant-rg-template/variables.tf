variable "location" {
    type        = string
    description = "Azure region for celito-demo resources."
    default     = "eastus2"
    validation {
        condition       = contains(["eastus2", "eastus"], var.location)
        error_message   = "Location must be eastus2 or eastus."
    }
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

variable "tenant_name" {
    type        = string
    description = "Customer short name, e.g., 'Acme'."
    default     = "acme-corp"
}

variable "environment" {
    type    = string
    default = "prod"
}

variable "tenant_octet" {
    type        = number
    description = "Unique octet for tenant address space, e.g., 1 = 10.100.1.0/16."
    default     = 1
}