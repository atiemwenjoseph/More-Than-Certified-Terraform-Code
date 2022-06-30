terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.17.0"
    }
  }
}
 

provider "docker" {}

resource "null_resource" "dockervoll" {
  provisioner "local-exec"{
    command = "mkdir noderedvoll/ || true && sudo chown -R 1000:1000 noderedvoll"
  }
}

resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}

resource "random_string" "random"{
  count = var.ext_port.container_count
  length = 4
  upper = false
  special = false
}


resource "docker_container" "nodered_container" {
  count = local.container_count
  name  = join("-",["nodered", random_string.random[count.index].result])
  image = docker_image.nodered_image.latest
  ports {
    internal = var.in_port
    external = var.ext_port[count.index]
  }
  volumes {
   container_path = "/data"
   host_path = "/home/ubuntu/environment/terraform-docker/noderedvoll"
    
  }
}




