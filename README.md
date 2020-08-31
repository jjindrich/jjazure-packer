# jjazure-packer

This repository describe how to bake custom image with your application and run this application. Application is simple webpage.
For image baking using Packer Azure DevOps task. For deployment using Azure Resource Manager.

Following articles can help you

- [How to use Packer to create Linux virtual machine images](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/build-image-with-packer)
- [Implement continuous deployment of your app to an Azure Virtual Machine Scale Set](https://docs.microsoft.com/en-us/azure/devops/pipelines/apps/cd/azure/deploy-azure-scaleset?view=azure-devops)
- [Azure virtual machine scale set from a Packer custom image by using Terraform](https://docs.microsoft.com/en-us/azure/developer/terraform/create-vm-scaleset-network-disks-using-packer-hcl)

Repository structure

- folder [packer](packer) - deployment script for Packer
- folder [app](packer/app) - prepared application code for Packer (typically builded in CI part)
- folder [template](template) - ARM script for deployment
- pipeline definition in [azure-pipelines.yaml](azure-pipelines.yaml)

## Prepare for DevOps

Create new Azure Storage Account for temporary image

- resource group jjpacker-rg
- storage account jjpackerstorage

```bash
az group create -n jjpacker-rg -l westeurope
az storage account create -n jjpackerstorage -g jjpacker-rg -l westeurope --sku Standard_LRS --kind StorageV2
```

Images will be stored in this resource group.

## Test ARM deployment

You can run this commands to deploy VM (fill-in password in template)

```powershell
$rg="jjdevv2vmapplx-rg"
az group create -n $rg -l westeurope
az deployment group create -g $rg --template-file deploy.json --parameters deploy.parameters.json
```

## DevOps pipeline

Check YAML pipeline definition using tasks

- [Build Machine Image (Packer) task](https://docs.microsoft.com/en-us/azure/devops/pipelines/tasks/deploy/packer-build?view=azure-devops) in packer folder
- [Azure Resource Group Deployment task](https://docs.microsoft.com/en-us/azure/devops/pipelines/tasks/deploy/azure-resource-group-deployment?view=azure-devops) in template folder

Check pipeline definition [azure-pipelines.yaml](azure-pipelines.yaml)

Create new Azure DevOps pipeline

- use pipeline definition
- create new Variable group in Library section with name jjpacker-DEV and add variable adminPassword

# TODOs

I'm planning to add:

- Use image in VMSS - first stage deployment to VM, next stage to VMSS
- Image for Windows Virtual Desktop - https://xenithit.blogspot.com/2020/03/how-to-deploy-windows-virtual-dekstop.html