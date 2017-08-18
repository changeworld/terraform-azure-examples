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
  name     = "testRedisCache"
  location = "West US"
}

resource "azurerm_storage_account" "test" {
  name                = "terraformrediscachesa"
  resource_group_name = "${azurerm_resource_group.test.name}"
  location            = "${azurerm_resource_group.test.location}"
  account_type        = "Standard_GRS"
}

resource "azurerm_redis_cache" "test" {
  name                = "terraformrediscache"
  name                = "example-redis"
  location            = "${azurerm_resource_group.test.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"
  capacity            = 3
  family              = "P"
  sku_name            = "Premium"
  enable_non_ssl_port = false
  redis_configuration {
    maxclients                    = 256
    rdb_backup_enabled            = true
    rdb_backup_frequency          = 60
    rdb_backup_max_snapshot_count = 1
    rdb_storage_connection_string = "DefaultEndpointsProtocol=https;BlobEndpoint=${azurerm_storage_account.test.primary_blob_endpoint};AccountName=${azurerm_storage_account.test.name};AccountKey=${azurerm_storage_account.test.primary_access_key}"
  }
}
