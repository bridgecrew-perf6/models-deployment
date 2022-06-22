/********************************************
      PROJECT VARIABLES CONFIGURATION
********************************************/

variable "project_id" {
  description = "GCP Project Name."
  type        = string
}

variable "region" {
  description = "Region where the GCP resources will be created."
  type        = string
}

variable "zones" {
  description = "Zones where the GCP resources will be created."
  type        = list(any)
}

variable "environment" {
  description = "Environment (dev, pre, pro or devops)."
  type        = string

  validation {
    condition     = contains(["dev", "pre", "pro", "devops"], var.environment)
    error_message = "Valid values for var: environment are (dev, pre, pro, devops)."
  }
}

variable "prefix_name" {
  description = "Prefix project."
  type        = string
}

variable "credentials" {
  description = "Name of the file where the GCP credential is stored."
  type        = string
}



/********************************************
      NETWORK VARIABLES CONFIGURATION
********************************************/

variable "host_project_name" {
  description = "Host Shared Project Name for Network configuration."
  type        = string
}

variable "network_vpc_name" {
  description = "Network VPC Name located in an external Host Project."
  type        = string
}

variable "subnet_name" {
  description = "Subnet where the resources will be created."
  type        = string
}

variable "subnet_pods_name" {
  description = "Subnet name where the k8s pods will be created."
  type        = string
}

variable "subnet_services_name" {
  description = "Subnet name where the k8s services will be created."
  type        = string
}


/********************************************
        GKE VARIABLES CONFIGURATION
********************************************/


variable "cluster_configuration" {
  description = "Contains all the Cluster settings."
  type        = map(any)
}

variable "ssh_bastion" {
  description = "Contains all the Bastion SSH settings."
  type        = map(any)
}

variable "allowed_ips_to_master" {
  description = "Contains all the IPs allowed to master."
  type        = list(any)
}

variable "bastion_address" {
  description = "Bastion Static Address."
  type        = string
}

variable "subnet_pods_name" {
  description = "The name of the secondary subnet ip range to use for pods."
  type        = string
}

variable "subnet_services_name" {
  description = "The name of the secondary subnet range to use for services."
  type        = string
}

variable "node_pools" {
  description = "A list that contains all the node pool definitions."
  type        = list(any)
}
