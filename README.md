# Azure Custom Image Builder with Packer

This project demonstrates how to use HashiCorp Packer to build custom VM images in Microsoft Azure. It includes a Packer template for creating an Ubuntu-based image with custom configurations. It publishes the image to a shared image gallery.

## Prerequisites

- An Azure subscription
- Azure CLI installed and configured
- HashiCorp Packer installed
- GitHub account (for GitHub Actions)
- Run terraform project first to setup all the required resources in Azure: https://github.com/davidgarc/tf-azure-shared-image-gallery

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

### GitHub Actions

The included GitHub Actions workflow will automatically build the image when changes are pushed to the repository. This project now uses OpenID Connect (OIDC) for authentication with Azure in the GitHub Actions workflow. This method is more secure than using long-lived credentials.

To set up OIDC authentication, please follow the instructions in the project:
https://github.com/davidgarc/tf-azure-github-actions

After setting up OIDC authentication, update your GitHub repository secrets under the `Prod` environment:
- Update or add the following secrets:
  - `AZURE_CLIENT_ID`: The Client ID of your app registration
  - `AZURE_SUBSCRIPTION_ID`: Your Azure Subscription ID
  - `AZURE_TENANT_ID`: Your Azure Tenant ID

The GitHub Actions workflow will now use these secrets to authenticate with Azure using OIDC. This eliminates the need for storing sensitive client secrets in your GitHub repository.

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

### Versioning

The versioning is managed by the `image_version` variable in the `image.pkr.hcl` file. Modify this value to update the version of the image.

## Customization

Modify the `image.pkr.hcl` file to customize the image build process, including:
- Changing the base image
- Adding more provisioners to install software or configure the system
- Adjusting Azure-specific settings like location or VM size

## Output

After successfully running the Packer build process, you should see output similar to the following:

![Packer Build Output](img/packer-build-sig-publish.png)

This image shows the successful completion of the Packer build process, including the creation and registration of the custom image in the Azure Shared Image Gallery.

Note: The actual output may vary slightly depending on your specific configuration and any customizations you've made to the build process.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.