# Azure Custom Image Builder with Packer

This project demonstrates how to use HashiCorp Packer to build custom VM images in Microsoft Azure. It includes a Packer template for creating an Ubuntu-based image with custom configurations.

## Prerequisites

- An Azure subscription
- Azure CLI installed and configured
- HashiCorp Packer installed
- GitHub account (for GitHub Actions)

## Project Structure

- `image.pkr.hcl`: Packer template for building the custom Azure VM image
- `.github/workflows/packer.yml`: GitHub Actions workflow for automating the image build process
- `.gitignore`: Specifies intentionally untracked files to ignore

## Setup

1. Fork and clone this repository.
2. Set up the following secrets in your GitHub repository:
   - `CLIENT_ID`: Your Azure Service Principal Client ID
   - `CLIENT_SECRET`: Your Azure Service Principal Client Secret
   - `SUBSCRIPTION_ID`: Your Azure Subscription ID
   - `TENANT_ID`: Your Azure Tenant ID

## Usage

### Local Build

To build the image locally:

1. Set the required environment variables:
   ```
   export ARM_CLIENT_ID=your_client_id
   export ARM_CLIENT_SECRET=your_client_secret
   export ARM_SUBSCRIPTION_ID=your_subscription_id
   export ARM_TENANT_ID=your_tenant_id
   ```
2. Run Packer:
   ```
   packer init .
   packer validate .
   packer build .
   ```

### GitHub Actions

The included GitHub Actions workflow will automatically build the image when changes are pushed to the repository. Ensure you've set up the required secrets in your GitHub repository settings.

## Customization

Modify the `image.pkr.hcl` file to customize the image build process, including:
- Changing the base image
- Adding more provisioners to install software or configure the system
- Adjusting Azure-specific settings like location or VM size

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
