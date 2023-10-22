targetScope = 'subscription'

@description('The workload name of the resource group to create.')
@maxLength(5)
param resourceGroupSiteName string = '12345'
var resourceGroupName = take(toLower('rg-${toLower(resourceGroupSiteName)}-${environment}-${location}'), 5)

@description('The location of the resource group to create.')
param location string = 'eastus'

@allowed(['p','np','qa'])
@description('The short name of the environment of the key vault to be created.')
param environment string = 'p'

// It depends on the what type of resource you are creating, but for my arc objects I use the following tags plus others.
// TODO: Have the environment match the environment parameter above. I just hate using the short name.
@description('The Tags to associate with the resource group to create.')
param tags object = {
  Environment: 'Production'
  Owner: 'John Doe'
  Classification: 'Confidential'
  CostCenter: '12345'
  City: 'New York'
  StateOrDistrict: 'New York'
  CountryOrRegion: 'US'
  WorkloadName: 'Arc'
  Timezone: 'UTC-5'
  DeploymentType: 'Bicep'
}

// Creates a resource group with a name of rg-<resourceGroupName>-<location>-<uniqueString> (first 3 characters). I'd recommend using a naming convention that makes sense for your organization.
resource resourceGroup 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}

