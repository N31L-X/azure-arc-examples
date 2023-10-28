using './demo-rg.bicep'

param resourceGroupSiteName = '12345'
param location = 'eastus'
param environment = 'p'
param tags = {
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

