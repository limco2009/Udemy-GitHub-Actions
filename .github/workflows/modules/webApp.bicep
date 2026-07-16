// param location string = resourceGroup().location
param location string = 'southeastasia'

param namePrefix string = 'mywebapp'
param appPlanId string

param dockerImage string = 'ubuntu/nginx'
param dockerImageTag string = 'latest'

resource webApplication 'Microsoft.Web/sites@2021-02-01' = {
  name: '${namePrefix}-site'
  location: location

  // kind: 'app,linux'

  properties: {
    serverFarmId: appPlanId
    siteConfig: {
      appSettings: [
        {
          name: 'DOCKER_REGISTRY_SERVICE_URL'
          value: 'https://index.docker.io'
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_USERNAME'
          value: ''
        }
        {
          name: 'DOCKER_REGISTRY_SERVER_PASSWORD'
          value: ''
        }
        {
          name : 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
          value: 'false'
        }     
      ]
      // linuxFxVersion: 'DOCKER|${dockerImage}:${dockerImageTag}'
    }
  }
}

output siteUrl string = webApplication.properties.defaultHostName
