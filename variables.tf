## resource group
variable "rg_resource_group_name" {
  description = "The name of the resource group in which to create the storage account."
  type        = string
  default     = null
}

variable "rg_location" {
  description = "Specifies the supported Azure location where the resource should be created."
  type        = string
  default     = null
}

## key vault
variable "akv_key_vault_name" {
  description = "The name of the Azure Key Vault for PostgreSQL."
  type        = string
}

## virtual network
variable "nw_virtual_network_name" {
  description = "The name of the Virtual Network."
  type        = string
  default     = null
}

variable "nw_vnet_subnet_aks" {
  description = "The name of the subnet for AKS."
  type        = string
}

variable "nw_vnet_subnet_sql" {
  description = "The name of the subnet for PostgresSQL."
  type        = string
}

## azure postgresql single
variable "psqls_single_create" {
  description = "Controls if PostgreSQL Server should be created."
  type        = bool
  default     = false
}

variable "psqls_database_create" {
  description = "Controls if PostgreSQL Database should be created."
  type        = bool
  default     = false
}

variable "psqls_single_servers" {
  description = "For each postgresql, create an object that contain fields."
  default     = {}
}

variable "psqls_single_config" {
  description = "PostgreSQL server configuration."
  type = object({
    version                           = string
    sku_name                          = string
    auto_grow_enabled                 = bool
    backup_retention_days             = number
    charset                           = string
    collation                         = string
    database_name                     = string
    geo_redundant_backup_enabled      = bool
    create_mode                       = string
    infrastructure_encryption_enabled = bool
    public_network_access_enabled     = bool
    ssl_enforcement_enabled           = bool
    ssl_minimal_tls_version_enforced  = string
    storage_mb                        = number
  })
  default = null
}

variable "psqls_private_dns_zone_name" {
  description = "The name of the Private DNS zone for PostgreSQL."
  default     = null
}

variable "psqls_does_private_dns_zone_exist" {
  type        = bool
  default     = false
}

variable "psqls_enable_private_endpoint" {
  description = "Manages a Private Endpoint to Azure database for PostgreSQL."
  default     = false
}

variable "psqls_firewall_rules" {
  description = "Range of IP addresses to allow firewall connections."
  type = map(object({
    start_ip_address = string
    end_ip_address   = string
  }))
  default = null
}

variable "psqls_key_vault_secret_admin_username" {
  description = "The name of the secret associated with the administrator login."
  default     = null  
}

variable "psqls_key_vault_secret_admin_password" {
  description = "The name of the secret associated with the administrator password."
  default     = null  
}

variable "psqls_identity" {
  description = "If you want your SQL Server to have an managed identity. Defaults to false."
  default     = false
}

variable "psqls_enable_threat_detection_policy" {
  description = "Threat detection policy configuration, known in the API as Server Security Alerts Policy."
  default     = true
}

variable "psqls_creation_source_server_id" {
  description = "For creation modes other than `Default`, the source server ID to use."
  default     = null
}

variable "psqls_ignore_missing_vnet_service_endpoint" {
  description = "Should the Virtual Network Rule be created before the Subnet has the Virtual Network Service Endpoint enabled?"
  default     = false
}

variable "psqls_restore_point_in_time" {
  description = "When `create_mode` is `PointInTimeRestore`, specifies the point in time to restore from `creation_source_server_id`"
  default     = null
}

variable "psqls_email_addresses_for_alerts" {
  description = "A list of email addresses which alerts should be sent to."
  type        = list(any)
  default     = []
}

variable "psqls_disabled_alerts" {
  description = "Specifies an array of alerts that are disabled. Allowed values are: Sql_Injection, Sql_Injection_Vulnerability, Access_Anomaly, Data_Exfiltration, Unsafe_Action."
  type        = list(any)
  default     = []
}

variable "psqls_log_retention_days" {
  description = "Specifies the number of days to keep in the Threat Detection audit logs"
  default     = "30"
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}