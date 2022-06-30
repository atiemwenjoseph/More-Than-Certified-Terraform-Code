variable "env" {
  type = string
  description = "Env to depoy to"
  default = "dev"
}

variable "image" {
  type = map
  description = "image for container"
  default = {
    dev = "nodered/node-red:latest"
    prod = "nodered/node-red:latest-minimal"
  }
}

variable "ext_port" {
  type = map
  

  validation {
    condition = max(var.ext_port["dev"]...) <= 65535 && min(var.ext_port["dev"]...) > 0
    error_message = "The external port MUST be in the valid port range 0 - 65535."
  }
}


variable "in_port" {
  type = number
  default = 1880
  
  validation {
    condition = var.in_port == 1880
    error_message = "The internal port must be 1880."
  }
}

locals {
  container_count = length(lookup(var.ext_port, var.env))
}

# variable "container_count" {
#   type = number
#   default = 3
# }
