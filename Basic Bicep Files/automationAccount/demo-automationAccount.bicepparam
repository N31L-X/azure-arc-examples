using './demo-automationAccount.bicep'

param location = 'westus2'
param automationAccountWorkloadName = 'arc'
param environment = 'p'
param tags = {
  Environment: 'Production'
  Owner: 'John Doe'
  Classification: 'Internal'
  CostCenter: '54321'
  City: 'New York'
  StateOrDistrict: 'New York'
  CountryOrRegion: 'US'
  WorkloadName: 'Arc Inventory & Change Tracking'
  DeploymentType: 'Bicep'
}
param automationAccountSku = 'Free'

