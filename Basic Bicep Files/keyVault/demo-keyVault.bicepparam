using './demo-keyvault.bicep'

param vaultWorkloadName = '12345'
param environment = 'p'
param location = 'eastus2'
param skuName = 'standard'
param skuFamily = 'A'
param tags = {
  Environment: 'Production'
  Owner: 'John Doe'
  Classification: 'Confidential'
  CostCenter: '12345'
  WorkloadName: 'Azure Stack HCI Cluster Key Vault'
  DeploymentType: 'Bicep'
  HCIClusterName: '12345CL01'
}

