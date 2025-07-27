#added a comment
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.37.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = "66bc95b7-5c49-4ea6-abcc-38ae21688cf2"
   features {
    # Example: Customizing Key Vault behavior
    key_vault {
      purge_soft_delete_on_destroy = true
    }

    # Example: Customizing Virtual Machine behavior
    virtual_machine_scale_set {
      force_delete = true
    }
  }
}

resource "azurerm_resource_group" "RG-Terraform" {
  name     = "test-rg"
  location = "south india"
}

 resource "azurerm_management_lock" "rg_lock" {
 name       = "anti-delete"
  scope      = azurerm_resource_group.RG-Terraform.id
  lock_level = "CanNotDelete" // or "ReadOnly"
  notes      = "This lock prevents accidental deletion of the resource group."
}

 resource "azurerm_storage_account" "blob" {
  name                     = "testrgterraformtfstate"
  resource_group_name      = azurerm_resource_group.RG-Terraform.name
  location                 = azurerm_resource_group.RG-Terraform.location
  account_tier             = "Standard"
  account_replication_type = "LRS" 

  blob_properties {
    delete_retention_policy {
      days = 111
    }

       container_delete_retention_policy {
      days = 111 // Retain deleted containers for 111 days
    }
  } 
  }

