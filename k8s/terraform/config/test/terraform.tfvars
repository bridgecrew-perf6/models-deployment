/********************************************
    PROJECT VARIABLES CONFIGURATION
********************************************/

project_id  = "ismael-dev-test"
environment = "dev"


/********************************************
    NETWORK VARIABLES CONFIGURAION
********************************************/

network_vpc_name     = "dev-com-svpc"
subnet_name          = "dev-ismael-snet-nodes"
subnet_pods_name     = "dev-ismael-snet-pods"
subnet_services_name = "dev-ismael-snet-services"


/********************************************
    GKE VARIABLES CONFIGURATION
********************************************/


cluster_configuration = {
  gke_version              = "1.19.9-gke.1400"
  master_cidr_block        = "192.168.0.0/28"
  networking_mode          = "VPC_NATIVE"
  logging_service          = false
  monitoring_service       = false
  shielded_nodes           = false
  remove_default_node_pool = true
  vertical_pod_autoscaling = false
  private_nodes            = true
  private_endpoint         = false
  initial_node_count       = 1
  max_pods_per_node        = 30
  create_external_ip       = true
}

#nodepools configuration

node_pools = [
  {
    node_pool_name     = "main-nodepool"    
    initial_node_count = "1"
    min_node_count     = "1"
    max_node_count     = "10"
    instance_type      = "e2-standard-2"
    node_per_zone      = false
    auto_repair        = true
    auto_upgrade       = false
    labels             = [{
      environment = "dev",
      owner       = "Terraform",
      node_type   = "main"
    }]
    taint              = []
  }, {
    node_pool_name     = "test-nodepool"
    initial_node_count = "0"
    min_node_count     = "0"
    max_node_count     = "3"
    instance_type      = "e2-standard-2"
    node_per_zone      = false
    auto_repair        = true
    auto_upgrade       = false
    labels             = [{
      environment = "test",
      owner       = "Terraform",
      node_type   = "test"
    }]
    taint              = [{
      key    = "node_type",
      value  = "tests",
      effect = "NO_SCHEDULE"
    }]
  }
]

