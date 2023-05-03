# Configure GCP
provider "google" {
  credentials = file("${var.credentials}")
  project     = "ParentProject"
  region      = var.region
}

# Enable A Shared VPC in the host project
resource "google_compute_shared_vpc_host_project" "host" {
  project = var.project 
}

#  first service project with host project 
resource "google_compute_shared_vpc_service_project" "service1" {
  host_project    = google_compute_shared_vpc_host_project.host.project
  service_project = var.service_project1 
}

# second service project with host project 
resource "google_compute_shared_vpc_service_project" "service2" {
  host_project    = google_compute_shared_vpc_host_project.host.project
  service_project = var.service_project2 
}

# Shared Network to attach 
data "google_compute_network" "network" {
  name    = "myvpc"
  project = var.project
}

# Shared Sub-Networks to attach 
data "google_compute_subnetwork" "subnet" {
  name    = "subnet1"
  project = var.project
  region  = "us-west1"
}

data "google_compute_subnetwork" "subnet1" {
  name    = "subnet3"
  project = var.project
  region  = "us-west1"
}

# Create a GKE Cluster in Service  subnetwork
resource "google_container_cluster" "my-gke-cluster" {
  name               = "my-gke-cluster"
  location           = "us-west1"
  initial_node_count = 1
  network            = data.google_compute_network.network.self_link

  subnetwork = data.google_compute_subnetwork.subnet.self_link

  master_auth {
    username = "vijul"
    password = "v@456"

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

# Create VM in Service Project1: 
resource "google_compute_instance" "vm_machine1" {
  project      = var.service_project1
  zone         = "us-west1-a"
  name         = "vijulvm1"
  machine_type = "e2-medium"
  
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    subnetwork = data.google_compute_subnetwork.subnet.self_link
    
  }
}

## Created a VM in Service Project2:

resource "google_compute_instance" "vm_machine2" {
  project      = var.service_project2
  zone         = "us-west1-a"
  name         = "vijulvm2"
  machine_type = "e2-medium"
 
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    subnetwork = data.google_compute_subnetwork.subnet1.self_link
    
  }
}