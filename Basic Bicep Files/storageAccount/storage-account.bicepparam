using './storage-account.bicep'

param location = 'eastus2'
param prefix = 'sa'
param name = 'asdfljkajsdfl'
param tags = {
  Environment: 'Production'
  Owner: 'John Doe'
  Classification: 'Confidential'
  CostCenter: '12345'
  WorkloadName: 'Azure Stack HCI Cluster Cloud Witness'
  DeploymentType: 'Bicep'
  HCIClusterName: '12345CL01'
}
param sku = 'Standard_LRS'

