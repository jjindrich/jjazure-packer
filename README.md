# jjazure-packer

This repository describe how to bake custom image with your application and run this application.

## Prepare for DevOps

Create new Azure Storage Account for temporary image

- resource group jjpacker-rg
- storage account jjpackerstorage

```bash
az group create -n jjpacker-rg -l westeurope
az storage account create -n jjpackerstorage -g jjpacker-rg -l westeurope --sku Standard_LRS --kind StorageV2
```

Images will be stored in this resource group.

## Run ARM deployment

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
