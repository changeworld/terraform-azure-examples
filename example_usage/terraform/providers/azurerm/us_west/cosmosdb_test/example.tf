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
  name     = "testCosmosDB"
  location = "West Europe"
}

resource "azurerm_cosmosdb_account" "test" {
  name                = "cosmos-db-account1"
  location            = "${azurerm_resource_group.test.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"
  offer_type          = "Standard"
  consistency_policy {
    consistency_level = "Session"
  }

  failover_policy {
    location = "West Europe"
    priority = 0
  }

  failover_policy {
    location = "East US"
    priority = 1
  }

  tags {
    hello = "world"
  }
}