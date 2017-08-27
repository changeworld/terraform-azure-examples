resource "azurerm_redis_cache" "basic" {
  name                = "terraformrediscachebasic"
  location            = "${azurerm_resource_group.test.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"
  capacity            = 0
  family              = "C"
  sku_name            = "Basic"
  enable_non_ssl_port = false

  redis_configuration {
    maxclients = 256
  }
}

resource "azurerm_redis_cache" "standard" {
  name                = "terraformrediscachestandard"
  location            = "${azurerm_resource_group.test.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"
  capacity            = 2
  family              = "C"
  sku_name            = "Standard"
  enable_non_ssl_port = false

  redis_configuration {
    maxclients = 1000
  }
}

resource "azurerm_storage_account" "premium_with_backup" {
  name                = "terraformrediscachesa"
  resource_group_name = "${azurerm_resource_group.test.name}"
  location            = "${azurerm_resource_group.test.location}"
  account_type        = "Standard_GRS"
}

resource "azurerm_redis_cache" "premium_with_backup" {
  name                = "terraformrediscachepremiumb"
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
    rdb_storage_connection_string = "DefaultEndpointsProtocol=https;BlobEndpoint=${azurerm_storage_account.premium_with_backup.primary_blob_endpoint};AccountName=${azurerm_storage_account.premium_with_backup.name};AccountKey=${azurerm_storage_account.premium_with_backup.primary_access_key}"
  }
}

resource "azurerm_redis_cache" "premium_with_clustering" {
  name                = "terraformrediscachepremiumc"
  location            = "${azurerm_resource_group.test.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"
  capacity            = 1
  family              = "P"
  sku_name            = "Premium"
  enable_non_ssl_port = false
  shard_count         = 3

  redis_configuration {
    maxclients         = 7500
    maxmemory_reserved = 2
    maxmemory_delta    = 2
    maxmemory_policy   = "allkeys-lru"
  }
}
