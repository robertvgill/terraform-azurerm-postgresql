## azure postgresql
resource "azurerm_postgresql_server" "apg" {
  for_each   = var.psqls_single_servers

  depends_on = [
    data.azurerm_key_vault_secret.admin_username,
    data.azurerm_key_vault_secret.admin_password,
    azurerm_private_dns_zone.apgdz,
    azurerm_private_dns_zone_virtual_network_link.apgdzvlink,
  ]

  resource_group_name               = var.rg_resource_group_name
  location                          = var.rg_location

  name                              = each.value.name
  administrator_login               = data.azurerm_key_vault_secret.admin_username[0].value
  administrator_login_password      = data.azurerm_key_vault_secret.admin_password[0].value
  sku_name                          = var.psqls_single_config.sku_name
  version                           = var.psqls_single_config.version
  storage_mb                        = var.psqls_single_config.storage_mb
  auto_grow_enabled                 = var.psqls_single_config.auto_grow_enabled
  backup_retention_days             = var.psqls_single_config.backup_retention_days
  geo_redundant_backup_enabled      = var.psqls_single_config.geo_redundant_backup_enabled
  infrastructure_encryption_enabled = var.psqls_single_config.infrastructure_encryption_enabled
  public_network_access_enabled     = var.psqls_single_config.public_network_access_enabled
  ssl_enforcement_enabled           = var.psqls_single_config.ssl_enforcement_enabled
  ssl_minimal_tls_version_enforced  = var.psqls_single_config.ssl_minimal_tls_version_enforced
  create_mode                       = var.psqls_single_config.create_mode
  creation_source_server_id         = var.psqls_single_config.create_mode != "Default" ? var.psqls_creation_source_server_id : null
  restore_point_in_time             = var.psqls_single_config.create_mode == "PointInTimeRestore" ? var.psqls_restore_point_in_time : null

  dynamic "identity" {
    for_each = var.psqls_identity == true ? [1] : [0]
    content {
      type = "SystemAssigned"
    }
  }

  dynamic "threat_detection_policy" {
    for_each = var.psqls_enable_threat_detection_policy == true ? [1] : []
    content {
      enabled                    = var.psqls_enable_threat_detection_policy
      disabled_alerts            = var.psqls_disabled_alerts
      email_account_admins       = var.psqls_email_addresses_for_alerts != null ? true : false
      email_addresses            = var.psqls_email_addresses_for_alerts
      retention_days             = var.psqls_log_retention_days
    }
  }
}
