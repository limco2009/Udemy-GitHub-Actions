param location string = 'southeastasia'
param storageName string = 'mygithubactionsstorage'

// param namePrefix string = 'mywebapp'

// param dockerImage string = 'ubuntu/nginx:latest'

targetScope = 'resourceGroup'

// How to consume modules

module storage './.github/workflows/modules/storage.bicep' = {
  name: 'storageName' 
  params: {
    storageName: storageName
    location: location
  }
}

module appPlanDeploy './modules/servicePlan.bicep' = {
  name: '$'{namePrefix}-appPlanDeploy'
  params: {
    namePrefix: namePrefix
    location: location
  }
}

module deployWebsite './.github/workflows/modules/webApp.bicep' = {
  name: '$'{namePrefix}-deploy-website'
  params: {
    location: location
    appPlanId: appPlanDeploy.outputs.appPlanId
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
