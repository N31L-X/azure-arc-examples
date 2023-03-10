@description('Location for all resources.')
param location string = resourceGroup().location

@description('Name of the Automation Account.')
param automationAccountWorkloadName string = 'name'
var updatedAutomationAccountName = toLower('aa-${automationAccountWorkloadName}-${location}-${uniqueString(resourceGroup().id)}') 

param tags object = {
  environment: 'dev '
  owner: 'dom'
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
