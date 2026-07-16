// param location string = 'southeastasia'
// param storageName string = 'mygithubactionsstorage'

// resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
//   name: storageName
//   location: location
//   sku: {
//     name: 'Standard_LRS'
//   }
//   kind: 'StorageV2'
//   properties: {
//     accessTier: 'Cool'
//   }
// }

param location string = 'southeastasia'
param storageName string = 'mygithubactionsstorage'

param namePrefix string = 'mywebapp'

param dockerImage string = 'ubuntu/nginx'
param dockerImageTag string = 'latest'

targetScope = 'resourceGroup'

// How to consume modules

// If the modules/storage.bicep file is not available, create the storage account inline

// resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
//   name: storageName
//   location: location
//   sku: {
//     name: 'Standard_LRS'
//   }
//   kind: 'StorageV2'
//   properties: {
//     accessTier: 'Cool'
//   }
// }

module storage 'modules/storage.bicep' = {
  name: storageName
  params: {
    storageName: storageName
    location: location
  }
}
module appPlanDeploy 'modules/servicePlan.bicep' = {
  name: '${namePrefix}-appPlanDeploy'
  params: {
    namePrefix: namePrefix
    location: location
  }
}

module deployWebsite 'modules/webApp.bicep' = {
  name: '${namePrefix}-deploy-website'
  params: {
    location: location
    // namePrefix: namePrefix
    appPlanId: appPlanDeploy.outputs.appPlanId
    dockerImage: dockerImage
    dockerImageTag: dockerImageTag
  }
}

output siteUrl string = 'https://${deployWebsite.outputs.webAppName}.azurewebsites.net'



// These lines were commented to do lab 38 on Udemy course "Implementing DevOps Solutions with GitHub Actions and Azure"

// param location string = 'southeastasia'
// param storageName string = 'mygithubactionsstorage'

// resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
//   name: storageName
//   location: location
//   sku: {
//     name: 'Standard_LRS'
//   }
//   kind: 'StorageV2'
//   properties: {
//     accessTier: 'Cool'
//   }
// }

