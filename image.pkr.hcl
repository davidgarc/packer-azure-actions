packer {
  required_plugins {
    azure = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/azure"
    }
  }
}

variable "subscription-id" {
  type = string
  default = env("SUBSCRIPTION_ID")
}

source "azure-arm" "ubuntu" {
  use_azure_cli_auth = true

  // Specify the Marketplace image you want to use
  image_publisher = "Canonical"
  image_offer     = "UbuntuServer"
  image_sku       = "18.04-LTS"

  // VM Size
  vm_size = "Standard_DS2_v2"

  // Specify the OS type of the source image
  os_type = "Linux" // or "Windows"

  // Output settings
  // managed_image_name = "my-custom-ubuntu-image"
  // managed_image_resource_group_name = "packer-demo"

  # use existing resource group where the pipeline has access to do all the actions
  build_resource_group_name         = "packer-demo"
  
  shared_image_gallery_destination {
    subscription = var.subscription-id
    resource_group = "packer-demo"
    gallery_name = "packer_demo_gallery"
    
    image_name = "my-linux-image"
    image_version = "1.1.0"
  }
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