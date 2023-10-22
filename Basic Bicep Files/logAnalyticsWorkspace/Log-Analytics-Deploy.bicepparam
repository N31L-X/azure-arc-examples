using './Log-Analytics-Deploy.bicep'

param location = 'eastus2'
param WorkloadName = 'arc-ict'
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
param sku = 'PerGB2018'
param retentionInDays = 30

