@description('The Azure location of the resources. It defaults to the location of the resource group.')
param location string = resourceGroup().location

@description('Workload Name of the Automation Account.')
@maxLength(10)
param automationAccountWorkloadName string = 'arc'
var updatedAutomationAccountName = take(toLower('aa-${automationAccountWorkloadName}-${environment}-${location}-${uniqueString(resourceGroup().id)}'), 24) 

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

@description('Sku of the Automation Account.')
param automationAccountSku string = 'Free'

@description('Creates an Automation Account.')
resource automationAccount 'Microsoft.Automation/automationAccounts@2022-08-08' = {
  name: updatedAutomationAccountName
  tags: tags
  location: location
  properties: {
    sku: {
      name: automationAccountSku
    }
  }
}

resource lock 'Microsoft.Authorization/locks@2020-05-01' = {
  name: '${updatedAutomationAccountName}-lock'
  properties: {
    level: 'CanNotDelete'
    notes: 'This lock is to prevent accidental deletion of the Automation Account.'
  }
  scope: automationAccount
}
