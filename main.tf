terraform {
  required_version = ">=1.3.7"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.43.0"
    }
  }
}

locals {
  tags = {
    "Environment" = var.environment
  }
}

resource "azurerm_storage_account" "securestorage" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = var.storage_account_name
  account_tier        = "Standard"
  # If var.environment is equal Production do GRS, otherwise LBS
  account_replication_type      = var.environment == "Production" ? "GRS" : "LBS"
  public_network_access_enabled = false
  tags                          = local.tags
}