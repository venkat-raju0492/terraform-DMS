locals {
  replication_subnet_group_id = var.replication_subnet_group_id == ""? "${var.project}-replication-subnet-group-${var.env}" : var.replication_subnet_group_id 
  replication_instance_id = var.replication_instance_id == ""? "${var.project}-replication-instance-${var.env}" : var.replication_instance_id
}

#Replication Subnet Group
resource "aws_dms_replication_subnet_group" "this" {
  count = var.create_replication_instance? 1 : 0
  replication_subnet_group_description = local.replication_subnet_group_id
  replication_subnet_group_id          = local.replication_subnet_group_id

  subnet_ids = var.subnet_ids
  

  tags = merge(
    var.common_tags,
    {
      "Name" = local.replication_subnet_group_id
    }
  )
}

#Replication instance
resource "aws_dms_replication_instance" "this" {
  count                        = var.create_replication_instance? 1 : 0
  allocated_storage            = var.allocated_storage
  apply_immediately            = var.apply_immediately
  auto_minor_version_upgrade   = var.auto_minor_version_upgrade
  availability_zone            = var.availability_zone
  engine_version               = var.engine_version
  kms_key_arn                  = var.kms_key_arn
  multi_az                     = var.multi_az
  preferred_maintenance_window = var.preferred_maintenance_window
  publicly_accessible          = var.publicly_accessible
  replication_instance_class   = var.replication_instance_class
  replication_instance_id      = local.replication_instance_id
  replication_subnet_group_id  = aws_dms_replication_subnet_group.this[0].id

  tags = merge(
    var.common_tags,
    {
      "Name" = local.replication_instance_id
    }
  )

  vpc_security_group_ids = var.instance_security_group_id

}

#DocDB
resource "aws_dms_endpoint" "source" {
  endpoint_type = "source"
  endpoint_id   = var.source_endpoint_id
  engine_name   = var.source_engine_name
  database_name = var.source_database_name
  password      = var.source_password
  port          = var.source_port
  server_name   = var.source_server_name
  ssl_mode      = var.source_ssl_mode
  username      = var.source_username
  mongodb_settings {
    auth_type           = var.source_auth_type
    auth_mechanism      = var.source_auth_mechanism
    nesting_level       = var.source_nesting_level
    docs_to_investigate = var.source_docs_to_investigate
    extract_doc_id      = var.source_extract_doc_id
    auth_source         = var.source_auth_source
  }
  tags = merge(
    var.common_tags,
    {
      "Name" = var.source_endpoint_id
    }
  )
}

#S3
resource "aws_dms_endpoint" "target" {
  endpoint_type               = "target"
  endpoint_id                 = var.target_endpoint_id
  engine_name                 = var.target_engine_name
  extra_connection_attributes = var.target_extra_connection_attributes
  s3_settings {
    service_access_role_arn = var.target_service_access_role_arn
    bucket_name             = var.target_bucket_name
    compression_type        = var.target_compression_type
  }

  tags = merge(
    var.common_tags,
    {
      "Name" = var.target_endpoint_id
    }
  )
}

#DMS Task
resource "aws_dms_replication_task" "this" {
  migration_type            = var.migration_type
  replication_instance_arn  = var.create_replication_instance? aws_dms_replication_instance.this[0].replication_instance_arn : var.replication_instance_arn
  replication_task_id       = var.replication_task_id
  source_endpoint_arn       = aws_dms_endpoint.source.endpoint_arn
  target_endpoint_arn       = aws_dms_endpoint.target.endpoint_arn
  table_mappings            = var.table_mappings
  replication_task_settings = var.replication_task_settings
  
  tags = merge(
  var.common_tags,
  {
      "Name" = var.replication_task_id
  }
  )

  lifecycle {
    ignore_changes = [replication_task_settings]
  }
}