@description('This is a description for namePrefix')
param namePrefix string
param location string = resourceGroup().location
param sku string = "B1"

resource serviceServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: '${namePrefix}-website'
  location: location
  kind: 'ubuntu'
  sku: {
    name: sku
  }
}
