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
  name     = "testEventHub"
  location = "West US"
}

resource "azurerm_eventhub_namespace" "test" {
  name                = "testEventHubNamespace"
  location            = "West US"
  resource_group_name = "${azurerm_resource_group.test.name}"
  sku                 = "Basic"
  capacity            = 1

  tags {
    environment = "Test"
  }
}

resource "azurerm_eventhub" "test" {
  name                = "testEventHub"
  namespace_name      = "${azurerm_eventhub_namespace.test.name}"
  location            = "${azurerm_resource_group.test.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"
  partition_count     = 2
  message_retention   = 1
}
