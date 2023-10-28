// If you are using this to tie to a Automation Account, you will need to make sure that us deployed in the correct region. See: https://learn.microsoft.com/en-us/azure/automation/how-to/region-mappings
@description('The Azure location of the resources')
param location string = 'eastus2'

@description('Workload Name of the Log Analytics Workspace.')
@maxLength(7)
param WorkloadName string = 'arc-ict'

var logAnalyticsWorkspaceName  = take(toLower('la-${WorkloadName}-${environment}-${location}'), 24)

@allowed(['p','np','qa'])
@description('The short name of the environment of the key vault to be created.')
param environment string = 'p'

// TODO: Have the environment match the environment parameter above. I just hate using the short name.
@description('The Tags to associate with the resource group to create.')
param tags object = {
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

@description('Whether to create a lock on the maintenance configuration. It defaults to true')
param resourceLock bool = true

@description('Sku for the Log Analytics Workspace.')
param sku string = 'PerGB2018'

@description('Retention in days for the Log Analytics Workspace.')
param retentionInDays int = 30

resource logWorkspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' ={
    name: logAnalyticsWorkspaceName
    tags: tags
    location: location
    properties: {
        sku: {
            name: sku
        }
        retentionInDays: retentionInDays
    }
}

resource lock 'Microsoft.Authorization/locks@2020-05-01' = if(resourceLock) {
    name: '${logAnalyticsWorkspaceName}-lock'
    properties: {
      level: 'CanNotDelete'
      notes: 'This resource is locked to prevent accidental deletion of the log analytics workspace.'
    }
    scope: logWorkspace
  }
