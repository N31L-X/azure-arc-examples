targetScope = 'subscription'

@description('The name of the resource group to create.')
param resourceGroupName string = 'arc'

@description('The location of the resource group to create.')
param location string = 'eastus'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-${toLower(resourceGroupName)}-${location}-${uniqueString(resourceGroupName, location)}'
  location: location
}
