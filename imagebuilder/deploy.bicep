param galleryName string = 'jjazimggallery'
param imageDefinitionName string = 'jjazimgdef-avdcustom'
param imageTemplateName string = 'jjazimgtemp-avdcustom'
param identityName string = 'jjazidentity-imagebuilder'
param location string = resourceGroup().location

resource identityBuilder 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' existing = {  
  name: identityName
}

resource gallery 'Microsoft.Compute/galleries@2022-03-03' = {
  location: location
  name: galleryName  
}

resource imgDefAvd 'Microsoft.Compute/galleries/images@2022-03-03' = {
  location: location
  name: imageDefinitionName  
  parent: gallery
  properties: {
    osType: 'Windows'
    hyperVGeneration: 'V2'
    osState: 'Generalized'
    identifier: {
      publisher: 'JJAzure'
      offer: 'AzureVirtualDesktop'
      sku: 'Win11-O365-custom-apps'
    }
  }
}

resource imgTemplateAvd 'Microsoft.VirtualMachineImages/imageTemplates@2022-02-14' = {
  location: location
  name: imageTemplateName
  properties:{
    vmProfile: {
      vmSize: 'Standard_D2ds_v5'
      osDiskSizeGB: 128
    }
    source: {
      type: 'PlatformImage'
      offer: 'office-365'
      publisher: 'MicrosoftWindowsDesktop'
      sku: 'win11-22h2-avd-m365'
      version: 'latest'
    }
    customize:[
      {
        type: 'WindowsUpdate'
        searchCriteria: 'IsInstalled=0'
        filters:[
            'exclude:$_.Title -like "*Preview*"'
            'include:$true'
        ]        
        updateLimit: 40
      }
    ]
    distribute:[
      {
        type: 'SharedImage'
        galleryImageId: imgDefAvd.id
        replicationRegions: [
          location
        ]
        runOutputName: 'jjazimgtemp-avdcustom'
      }
    ]
  }
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${identityBuilder.id}': {}
    }
  }  
}
