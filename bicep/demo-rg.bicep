targetScope = 'subscription'

@description('The name of the resource group to create.')
param resourceGroupName string = 'rg-arc-prod-eastus-001'

@description('The location of the resource group to create.')
param location string = 'eastus'

var updateResourceGroupName = 'rg-${resourceGroupName}-${location}-${uniqueString(resourceGroupName, location)}'
resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: updateResourceGroupName
  location: location
}
