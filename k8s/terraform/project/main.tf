module "kubernetes_cluster" {
  source = "./gke"

  # Network Configuration 
  host_project_name = var.host_project_name
  project_id        = var.project_id
  region            = var.region
  available_zones   = var.zones
  environment       = var.environment
  prefix_name       = var.prefix_name
  network_name      = var.network_vpc_name
  subnetwork_name   = var.subnet_name

  # Cluster configuration
  cluster_configuration = var.cluster_configuration
  subnet_pods_name     = var.subnet_pods_name
  subnet_services_name = var.subnet_services_name

  #Nodepool configuration
  node_pools = var.node_pools

 
}
