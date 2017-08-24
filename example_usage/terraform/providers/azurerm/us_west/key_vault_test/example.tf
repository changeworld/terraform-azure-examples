variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
}

resource "azurerm_resource_group" "test" {
  name     = "testKeyVault"
  location = "West US"
}

resource "azurerm_key_vault" "test" {
  name                = "testKeyVaultWestUS"
  location            = "West US"
  resource_group_name = "${azurerm_resource_group.test.name}"

  sku {
    name = "standard"
  }

  tenant_id = "${var.tenant_id}"

  access_policy {
    tenant_id = "${var.tenant_id}"
    object_id = "d746815a-0433-4a21-b95d-fc437d2d475b"

    key_permissions = [
      "all",
    ]

    secret_permissions = [
      "get",
    ]
  }

  enabled_for_disk_encryption = true

  tags {
    environment = "Test"
  }
}
