$rginfra = "jjinfra-rg"
az group create -n $rginfra -l westeurope
az deployment group create --resource-group $rginfra --template-file deploy.bicep
