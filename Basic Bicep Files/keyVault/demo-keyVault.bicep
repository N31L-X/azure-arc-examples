@description('The Azure location of the resources. It defaults to the location of the resource group.')
@minLength(3)
@maxLength(5)
param vaultWorkloadName string = '12345'

@allowed(['p','np','qa'])
@description('The environment of the key vault to be created.')
param environment string = 'p'

@description('The name of the key vault to be created.')
var vaultName = take(toLower('kv-${vaultWorkloadName}-${environment}-${uniqueString(resourceGroup().id)}'),20)

@description('The Azure location of the resources')
param location string = resourceGroup().location

@description('The SKU of the vault to be created.')
@allowed(['standard','premium'])
param skuName string = 'standard'

@allowed(['A', 'B'])
@description('The SKU family of the Key Vault.')
param skuFamily string = 'A'

//@description('The Tenant ID of the Key Vault to be created.')
//param tenantId string = subscription().tenantId

// TODO: Have the environment match the environment parameter above. I just hate using the short name.
@description('The Tags to associate with the keyvault to create.')
param tags object = {
  Environment:'Production'
  Owner: 'John Doe'
  Classification: 'Confidential'
  CostCenter: '12345'
  WorkloadName: 'Azure Stack HCI Cluster Key Vault'
  DeploymentType: 'Bicep'
  HCIClusterName: '12345CL01'
}

// The Key Vault resource
resource vault 'Microsoft.KeyVault/vaults@2021-11-01-preview' = {
  name: vaultName
  location: location
  tags: tags
  properties: {
    accessPolicies:[]
    enableRbacAuthorization: true
    enableSoftDelete: true
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    tenantId: subscription().tenantId
    sku: {
      name: skuName
      family: skuFamily
    }
    networkAcls: {
      defaultAction: 'Allow'
      bypass: 'AzureServices'
    }
  }
}

// Add a resource lock to the key vault to prevent accidental deletion
resource lock 'Microsoft.Authorization/locks@2020-05-01' = {
  name: '${vaultName}-lock'
  properties: {
    level: 'CanNotDelete'
    notes: 'This lock prevents accidental deletion of the key vault.'
  }
  scope: vault
}

