@description('The Azure location of the resources. It defaults to the location of the resource group.')
param location string = resourceGroup().location

@description('Prefix of Storage Account Resource Name. This param is ignored when name is provided.')
param prefix string = 'sa'

@description('Name of Storage Account has to unique within Azure.')
@maxLength(24)
@minLength(3)
param name string = '${prefix}${uniqueString(resourceGroup().id, location)}'


// TODO: Have the environment match the environment parameter above. I just hate using the short name.
@description('The Tags to associate with the storage account to create.')
param tags object = {
  Environment:'Production'
  Owner: 'John Doe'
  Classification: 'Confidential'
  CostCenter: '12345'
  WorkloadName: 'Azure Stack HCI Cluster Cloud Witness'
  DeploymentType: 'Bicep'
  HCIClusterName: '12345CL01'
}

//This is a very bad example but it works for now.
@description('Storage Account SKU.')
@allowed([
  'Premium_LRS'
  'Premium_ZRS'
  'Standard_GRS'
  'Standard_GZRS'
  'Standard_LRS'
  'Standard_RAGRS'
  'Standard_RAGZRS'
  'Standard_ZRS'
])
param sku string = 'Standard_LRS'

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
    name: name
    location: location
    tags: tags
    sku: {
        name: sku
    }
    kind: 'StorageV2'
    properties: {
        accessTier: 'Hot'
        supportsHttpsTrafficOnly: true
    }
}

output storageAccountName string = storageAccount.name
