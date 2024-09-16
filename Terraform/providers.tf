terraform {
  required_providers {
    azapi = {
      source  = "azure/azapi"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.1.0"
    }
  }
  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  tenant_id              = var.tenant_id  
}

provider "azapi" {
  subscription_id = var.subscription_id
  tenant_id              = var.tenant_id  
}