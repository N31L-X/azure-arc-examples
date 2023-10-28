targetScope = 'subscription'

@description('The workload name of the resource group to create.')
@maxLength(5)
param resourceGroupSiteName string = '15108'
var resourceGroupName = toLower('rg-${toLower(resourceGroupSiteName)}-${environment}-${location}')

@description('The location of the resource group to create.')
param location string = 'eastus'

@allowed(['p','np','qa'])
@description('The short name of the environment of the key vault to be created.')
param environment string = 'p'

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

@description('The name of the key vault to create.')
param kvName string = 'kv-${toLower(resourceGroupSiteName)}-${environment}-${location}'

@description('The name of the storage account to create.')
param storageAccountName string = 'sa${toLower(resourceGroupSiteName)}${environment}cwazhci'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}


// Create a Storage Account
module storageAccount 'br/public:storage/storage-account:3.0.1' = {
  name: storageAccountName
  params: {
    name: storageAccountName
    location: location
    tags: tags
    minimumTlsVersion: 'TLS1_2'
    isZoneRedundant: false
    kind: 'StorageV2'
    accessTier: 'Hot'
  }
  scope: resourceGroup
}

// Create a Key Vault with a soft delete enabled. Module doesn't support tags yet.
module keyVault 'br/public:security/keyvault:1.0.2' = {
  name: kvName
  params: {
    location: location
    name: kvName
    enableSoftDelete: true
    skuFamily: 'A'
    skuName: 'standard'
  }
  scope: resourceGroup
}

output resourceGroupName string = resourceGroup.name
output storageAccountName string = storageAccount.outputs.name
output keyVaultName string = keyVault.outputs.name
