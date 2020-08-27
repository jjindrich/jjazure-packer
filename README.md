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

## DevOps pipeline

Check YAML pipeline definition

- using [Build Machine Image (Packer) task](https://docs.microsoft.com/en-us/azure/devops/pipelines/tasks/deploy/packer-build?view=azure-devops)
