# jjazure-packer-imagebuilder
This repository describes how create image using Azure Image Builder with Azure Shared Image Gallery to build image and publish images.

Related documentation Azure Image Builder

- https://docs.microsoft.com/en-us/azure/virtual-machines/linux/image-builder-json
- https://docs.microsoft.com/en-us/azure/virtual-machines/windows/image-builder-virtual-desktop
- https://github.com/Azure/azvmimagebuilder/tree/main/solutions/14_Building_Images_WVD

How to integrate with Azure DevOps

- https://github.com/Azure/azvmimagebuilder/tree/main/solutions/1_Azure_DevOps

Repository structure

- folder [template-builder](image builder templates) - template for Azure image builder resource

## Prepare for deployment

User Identity must be provided to access other Azure resources, check [docs](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/image-builder-json#identity)

```powershell
'Az.ImageBuilder', 'Az.ManagedServiceIdentity' | ForEach-Object {Install-Module -Name $_ -AllowPrerelease}
$rg = "JJDevV2-Infra"
$idenityName = "jjdevv2imagebuilder"
# create User Identity
New-AzUserAssignedIdentity -ResourceGroupName $rg -Name $idenityName
$idenityNameResourceId=$(Get-AzUserAssignedIdentity -ResourceGroupName $rg -Name $idenityName).Id
$idenityNamePrincipalId=$(Get-AzUserAssignedIdentity -ResourceGroupName $rg -Name $idenityName).PrincipalId
# assign permission Contributor
New-AzRoleAssignment -ObjectId $idenityNamePrincipalId -RoleDefinitionName "Contributor" -ResourceGroupName $rg
```

## Deploy ARM template

Template using existing virtual network to be able access network resources, check [docs](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/image-builder-json#vnetconfig)

Check you are using right image, you can check avaiblable images

```powershell
Get-AzVMImageSku -Location westeurope -PublisherName MicrosoftWindowsDesktop -Offer windows-10
```

Run deployment

```powershell
$rg = "JJDevV2-Infra"
az group create -n $rg -l westeurope
az deployment group create -g $rg --template-file deploy-image-wvd.json --parameters deploy-image-wvd.parameters.json
```