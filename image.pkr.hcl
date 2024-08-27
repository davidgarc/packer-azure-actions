packer {
  required_plugins {
    azure = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/azure"
    }
  }
}

variable "client_id" {
  type = string
  default = env("ARM_CLIENT_ID")
}

variable "client_secret" {
  type = string
  default = env("ARM_CLIENT_SECRET")
}

variable "subscription_id" {
  type = string
  default = env("ARM_SUBSCRIPTION_ID")
}

variable "tenant_id" {
  type = string
  default = env("ARM_TENANT_ID")
}

source "azure-arm" "ubuntu" {
  cloud_environment_name = "Public" # China, Germany, or USGovernment

  location = "South Central US"

  client_id = var.client_id
  client_secret = var.client_secret
  subscription_id = var.subscription_id
  tenant_id = var.tenant_id

  // Specify the Marketplace image you want to use
  image_publisher = "Canonical"
  image_offer     = "UbuntuServer"
  image_sku       = "18.04-LTS"

  // VM Size
  vm_size = "Standard_DS2_v2"

  // Specify the OS type of the source image
  os_type = "Linux" // or "Windows"

  // Output settings
  managed_image_name                = "my-custom-ubuntu-image"
  managed_image_resource_group_name = "custom-image-rg"
}

build {
  sources = ["source.azure-arm.ubuntu"]

  // Add your provisioners here to modify the image
  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get upgrade -y",
      // Add more commands to customize your image
    ]
  }

  // Optionally, add post-processors here
}