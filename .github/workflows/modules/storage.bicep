@minLength(5)
@maxLength(24)
@description('StorageName must be between 5 and 24 characters long.')
param storageName string

param location string = resourceGroup().location

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: storageName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

