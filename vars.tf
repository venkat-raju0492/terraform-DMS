variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map
}

variable "create_replication_instance" {
  description = "create_replication_instance"
  default = true
}

variable "replication_subnet_group_id" {
  description = "replication_subnet_group_id"
  default = ""
}

variable "project" {
  description = "project"
}

variable "env" {
  description = "env"
}

variable "subnet_ids" {
  description = "subnet_ids"
  type = list(string)
  default = []
}

variable "replication_instance_id" {
  description = "replication_instance_id"
  default = ""
}


variable "allocated_storage" {
  description = "allocated storage"
  default = "50"
}

variable "apply_immediately" {
  description = "apply_immediately"
  default = true
}

variable "auto_minor_version_upgrade" {
  description = "auto_minor_version_upgrade"
  default = false
}

variable "availability_zone" {
  description = "availability_zone"
  default = null
}

variable "engine_version" {
  description = "engine_version"
  default = null
}

variable "kms_key_arn" {
  description = "kms_key_arn"
  default = null
}

variable "multi_az" {
  description = "multi_az"
  default = true
}

variable "preferred_maintenance_window" {
  description = "preferred_maintenance_window"
  default = null
}

variable "publicly_accessible" {
  description = "publicly_accessible"
  default = false
}

variable "replication_instance_class" {
  description = "replication_instance_class"
  default = "dms.t2.medium"
}

variable "instance_security_group_id" {
  description = "instance_security_group_id"
  type = list
  default = []
}

variable "source_endpoint_id" {
  description = "source_endpoint_id"
}

variable "source_engine_name" {
  description = "source_engine_name"
}

variable "source_database_name" {
  description = "source_database_name"
}

variable "source_password" {
  description = "source_password"
}

variable "source_port" {
  description = "source_port"
}

variable "source_server_name" {
  description = "source_server_name"
}

variable "source_ssl_mode" {
  description = "source_ssl_mode"
  default = "none"
}

variable "source_username" {
  description = "source_username"
}

variable "source_auth_type" {
  description = "source_auth_type"
  default = "PASSWORD"
}

variable "source_auth_mechanism" {
  description = "source_auth_mechanism"
  default = "DEFAULT"
}

variable "source_nesting_level" {
  description = "source_nesting_level"
  default = "ONE"
}

variable "source_docs_to_investigate" {
  description = "docs_to_investigate"
  default = "1000"
}

variable "source_extract_doc_id" {
  description = "extract_doc_id"
  default = "false"
}

variable "source_auth_source" {
  description = "source_auth_source"
  default = "admin"
}

variable "target_endpoint_id" {
  description = "target_endpoint_id"
}

variable "target_engine_name" {
  description = "target_engine_name"
}

variable "target_extra_connection_attributes" {
  description = "target_extra_connection_attributes"
  default = ""
}

variable "target_service_access_role_arn" {
  description = "target_service_access_role_arn"
}

variable "target_bucket_name" {
  description = "target_bucket_name"
}

variable "target_compression_type" {
  description = "target_compression_type"
}

variable "migration_type" {
  description = "migration_type"
}

variable "replication_instance_arn" {
  description = "replication_instance_arn"
}

variable "replication_task_id" {
  description = "replication_task_id"
}

variable "table_mappings" {
  description = "table_mappings"
}

variable "replication_task_settings" {
  description = "replication_task_settings"
  default = null
}