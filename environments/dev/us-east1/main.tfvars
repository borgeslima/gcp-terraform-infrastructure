############# Configurações gerais ###############

project_id    = "finops"
gke_name      = "finops"
region        = "us-east1"
gke_num_nodes = 1

# ############## Configurações do nó ################


node_pools = {
  node_pool1 = {
    node_count   = 1
    disk_size_gb = 30
    machine_type = "n1-standard-2"
    preemptible  = true
    disk_type    = "pd-ssd"
    auto_scaling = {
      max_node = 1
      min_node = 3
    }
  }
}

# ############## Configurações da Rede do GKE (VPC, SUBNET, NAT) ################

vpc_name                          = "my-vpc"
subnet_name                       = "default-a"
master_ipv4_cidr_block            = "172.16.0.0/28"
subnet_ip_cidr_range              = "172.28.19.32/27"
subnet_secondary_ip_range_pods    = "172.23.128.0/20"
subnet_secondary_ip_range_service = "172.23.144.0/20"

# ##############  PERRING  ################

perring_networks = {
  peer_to_cross = {
    peer_project = "project-to-peer"
    peer_network = "vpc-network-name"
  }
}

# ############## SQL INSTANCES ############

database_instances = {
  default = {
    name                   = "default"
    disk_size              = "20"
    disk_type              = "PD_SSD"
    tier                   = "db-f1-micro"
    ipv4_enabled           = true
    database_name          = "defautlt"
    database_version       = "POSTGRES_14"
    database_user_name     = "user@user"
    database_user_password = "$pw=user@2057"
    deletion_protection    = false
  }
}


pubsubs = {
  topic1 = {
    name = "topic-poc"
  }
}


############### HELMS #################

helms = {
  nginx = {
    name             = "ingress-nginx"
    repository       = "https://kubernetes.github.io/ingress-nginx"
    chart            = "ingress-nginx"
    namespace        = "ingress-nginx"
    force_update     = true
    cleanup_on_fail  = true
    create_namespace = true
    wait             = false
    timeout          = 300000
    values           = "./helms/ingress-nginx/values.yaml"
  }
}

# ############## REDIS/MERCHANT ############

redis_instances = {
  redis = {
    name                    = "redis"
    tier                    = "STANDARD_HA"
    region                  = "us-east1"
    location_id             = "us-east1-d"
    reserved_ip_range       = "10.3.0.0/27"
    auth_enabled            = false
    transit_encryption_mode = "DISABLED"
  }
}


# ############## SPANNER ############

spanners = {
  shared = {
    name             = "shared"
    config           = "regional-us-east5"
    processing_units = 100
    databases = {
      crm = {
        name                     = "crm"
        version_retention_period = "1d"
        ddl                      = ["CREATE TABLE t1 (t1 INT64 NOT NULL,) PRIMARY KEY(t1)"]
      }
    }
  }
}
