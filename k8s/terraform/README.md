# terraform-gke-droids


 terraform-gke-droids  is a terraform project for gke deploy.

It contains all the resources to deploy or manage: 
 - GKE cluster
 - VM instance(Bastion)

## Requeriments
GOOGLE CLOUD PLATFORM - SDK

Config your GCP credentials.json in ~/.config/gloud/* directory with your GCP IAM user json.

DOCKER

Install Docker in your personal computer to instance the Terraform Container using the Makefile.

## How to use

All the 'make' commands must contain:
- the ENV argument (Possible values: dev, test, pre, pro).
- the CREDS argument (The path will always be ~/.config/gloud/*, so you have to include only the file name. Default value: credentials.json)

Important: 
All environments have the same resources with different configuration. 

### Init terraform project

```sh
make init ENV='env' CREDS='cred.json'
```

### Check plan from terraform
```sh
make plan ENV='env' CREDS='cred.json'
```

### Apply plan
```sh
make apply ENV='env' CREDS='cred.json'
```



### Configuration

Inside the project, you have the folder config/ .You will see N folders for N differents environments. 

- dev 
- pre
- pro

There is 2 files to configure the environments: 
- config_backend.tf: Terraform backend configuration.
- terraform.tf.vars: Variables to config our project. 

### Modules
in main.tf in the project folder, you can add any module for this project.

### Gke Module 
Add module for GKE:

```
module "kubernetes_cluster" {
  source = "./kubernetes_engine"

  create_cluster = var.create_cluster

  # * Network Configuration *
  host_project_name = var.host_project_name
  project_id        = var.project_id
  region            = var.region
  available_zones   = var.zones

  environment     = var.environment
  prefix_name     = var.prefix_name
  network_name    = var.network_vpc_name
  subnetwork_name = var.subnet_name

  create_external_ip = var.create_external_ip

  # * Bastion Configuration *
  create_local_bastion = var.create_local_bastion
  bastion_address      = module.bastion_ssh.bastion_address

  # * Cluster Configuration *
  gke_version = var.gke_version

  cluster_name        = "${var.prefix_name}-cluster-${var.environment}"
  cluster_description = "${upper(var.prefix_name)} Cluster for ${upper(var.environment)} Environment"

  master_ipv4_cidr_block = var.master_cidr_block
  allowed_ips_to_master  = var.allowed_ips_to_master

  subnet_pods_name     = var.subnet_pods_name
  subnet_services_name = var.subnet_services_name

  vertical_pod_autoscaling = false

  # * Node Pool Configuration *
  node_pools        = var.node_pools

  depends_on = [
    module.bastion_ssh
  ]
}
```

In your terraform.tfvars config file:

| Variable Name | resume | Values |
| --- | --- | --- |
| create_cluster | Enable o disable the creation of cluster | true or false |
| create_external_ip | Create a external ip for API | true or false |

Node_pools sections: Array of nodepool configuration with the following values:
| Variable Name | resume | Values | 
| --- | --- | --- |
| node_pool_name | Name of nodepool | String like: main-nodepool |
| initial_node_count | Number of nodes when node pool is created | Integer: 1 | 
| min_node_count   | Min num of nodes for nodepool, used for autoscaling | Integer: 1 |
| max_node_count   | Max num of nodes for nodepool in autoscaling | Integer: 5 |
| instance_type   | Type of instance | String: e2-standard-4 |
| node_per_zone   | 1 node is 3 (1 per zone) | true or false |
| auto_repair     | GKE autorepair nodes | true or false |
| auto_upgrade    | GKE can autoupgrade versions | true or false |


Labels and taints: 
We add this to options to add differents nodepool (spark, test, normal nodes): 

Example labels: 
```
labels             = [{
      environment = "dev",
      owner       = "Terraform",
      node_type   = "main"
    }]
```
example taints:
``` 
taint              = [{
      key    = "node_type",
      value  = "test",
      effect = "NO_SCHEDULE"
    }]
```
Example nodepool: 
```
/********************************************
    GKE VARIABLES CONFIGURATION
********************************************/

create_cluster     = true
create_external_ip = true

node_pools = [
  {
    node_pool_name     = "tio-nep"    
    initial_node_count = "1"
    min_node_count     = "1"
    max_node_count     = "5"
    instance_type      = "e2-standard-4"
    node_per_zone      = false
    auto_repair        = true
    auto_upgrade       = true
    labels             = [{
      environment = "dev",
      owner       = "Terraform",
      node_type   = "main"
    }]
    taint              = []
  }, 
```
