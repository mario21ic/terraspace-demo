# GCP
resource "google_compute_instance" "cpu-instance" {
    name = "vm-instance-demo"
    machine_type = "e2-micro"
    zone = "us-central1-a"

    tags = ["env", "default"]

    boot_disk {
    initialize_params {
          image = "debian-cloud/debian-9"
        }
    }


    network_interface {
        network = "default"
        access_config {
        }
    }
}

