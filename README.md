# terraform-DMS
Common terraform module for AWS Data Migration Service


## Overview

- Create DMS task with source as document db and target as s3 bucket

- Optional, Create replication instance


`````terraform

terraform {
  backend "s3" {
    encrypt = true
  }
}

provider "aws" {
  region = var.region
}

locals {
  # Common tags to be assigned to all resources
  common_tags = {
    Project     = var.project
    Environment = var.env
    CreatedBy   = "Terraform"
  }
}

data "template_file" "table_mappings" {
  template = file("${path.module}/table_mappings.json")
}

module "DMS" {
  source                         = "git@github.levi-site.com:LSCO/terraform-DMS.git?ref=<TAG>"
  project                        = var.project 
  env                            = var.env 
  source_endpoint_id             = <SOURCE-ENDPOINT-NAME> // Source endpoint name 
  source_engine_name             = var.source_engine_name
  source_database_name           = var.source_database_name
  source_password                = var.source_password
  source_port                    = var.source_port 
  source_server_name             = var.source_server_name
  source_username                = var.source_username
  target_endpoint_id             = <TARGET-ENDPOINT-NAME> // Target endpoint name
  target_engine_name             = var.target_engine_name
  target_service_access_role_arn = <IAM-ROLE> //IAM role
  target_bucket_name             = <S3-bucket-name> //Target s3 bucket name
  target_compression_type        = var.target_compression_type
  replication_task_id            = <REPLICATION-TASK-NAME> // Replication task name
  migration_type                 = var.migration_type // Migration type
  create_replication_instance    = false // set true, if replication instance needs to be created
  subnet_ids                     = [<SUBNET-HERE>] // Optional, if create_replication_instance = true
  instance_security_group_id     = [<SECURITY-GROUP-ID>] // Optional, if create_replication_instance = true
  replication_instance_arn       = var.replication_instance_arn // If create_replication_instance = false 
  table_mappings                 = data.template_file.table_mappings.rendered
  replication_task_settings      = "<REPLICATION-TASK-SETTINGS-HERE>" // Optional, provide replication task settings as json
  common_tags                    = local.common_tags
}

``````