// Add logic to create a Log Analytics Workspace based on the automation account location. 

@description('Location for all resources.')
param location string = resourceGroup().location

@description('Name of the Log Analytics Workspace.')
param logAnalyticsWorkspaceName string = 'arc'
var updatedLogAnalyticsWorkspaceName  = 'la-${logAnalyticsWorkspaceName}-${location}-${uniqueString(resourceGroup().id)}'

@description('Tags for the Log Analytics Workspace.')
param tags object = {
  environment: 'dev '
  owner: 'dom'
}

@description('Sku for the Log Analytics Workspace.')
param sku string = 'PerGB2018'

@description('Retention in days for the Log Analytics Workspace.')
param retentionInDays int = 30

resource logWorkspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' ={
    name: updatedLogAnalyticsWorkspaceName
    tags: tags
    location: location
    properties: {
        sku: {
            name: sku
        }
        retentionInDays: retentionInDays
    }
}
