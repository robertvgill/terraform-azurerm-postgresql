## key vault
data "azurerm_key_vault" "akv" {
  count               = var.psqls_single_create ? 1 : 0

  name                = format("%s", var.akv_key_vault_name)
  resource_group_name = var.rg_resource_group_name
}

data "azurerm_key_vault_secret" "admin_username" {
  count               = var.akv_key_vault_name != null ? 1 : 0

  name                = format("%s", var.psqls_key_vault_secret_admin_username)
  key_vault_id        = data.azurerm_key_vault.akv[0].id
}

data "azurerm_key_vault_secret" "admin_password" {
  count               = var.akv_key_vault_name != null ? 1 : 0

  name                = format("%s", var.psqls_key_vault_secret_admin_password)
  key_vault_id        = data.azurerm_key_vault.akv[0].id
}

## vnet
data "azurerm_virtual_network" "vnet" {
  count               = var.psqls_single_create ? 1 : 0

  name                = format("%s", var.nw_virtual_network_name)
  resource_group_name = var.rg_resource_group_name
}

## subnet
data "azurerm_subnet" "aks" {
  count      = var.psqls_single_create ? 1 : 0

  name                 = format("%s", var.nw_vnet_subnet_aks)
  virtual_network_name = var.nw_virtual_network_name
  resource_group_name  = var.rg_resource_group_name
}

data "azurerm_subnet" "sql" {
  count      = var.psqls_single_create ? 1 : 0

  name                 = format("%s", var.nw_vnet_subnet_sql)
  virtual_network_name = var.nw_virtual_network_name
  resource_group_name  = var.rg_resource_group_name
}

## private dns
data "azurerm_private_dns_zone" "apgdz" {
  count               = var.psqls_single_create && var.psqls_does_private_dns_zone_exist ? 1 : 0

  name                = format("%s", lower("private.postgres.database.azure.com"))
  resource_group_name = var.rg_resource_group_name
}