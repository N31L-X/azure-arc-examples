@description('The Azure location of the resources. It defaults to the location of the resource group.')
param location string = resourceGroup().location

@description('The scope of the maintenance configuration. It defaults to InGuestPatch. See https://learn.microsoft.com/en-us/azure/templates/microsoft.maintenance/maintenanceconfigurations?pivots=deployment-language-bicep for details')
@allowed([
  'Extension'
  'Host'
  'InGuestPatch'
  'OSImage'
  'Resource'
  'SQLDB'
  'SQLManagedInstance'
])
param maintenanceScope string = 'InGuestPatch'

@description('The visibility of the maintenance configuration. It defaults to Custom.')
@allowed([
  'Custom'
  'Public'
])
param visibility string = 'Custom'

@description('The start date and time of the maintenance window.')
param maintenanceWindows object = {
  startDateTime: '2023-03-09 00:00'
  duration: '03:55'
  timeZone: 'Eastern Standard Time'
  recurEvery: '1Month Second Tuesday Offset1'
}

@description('The patches to install. It defaults to Critical, Security and Updates. By Default, it will have Linux & Windows Settings but I wouldd recommend changing that')
param installPatches object = {
  classificationsToInclude: [
    'Critical'
    'Security'
    'Updates'
  ]
  rebootSetting: 'IfRequired'
  LinuxParameters: {
    classificationsToInclude: [
      'Critical'
      'Security'
    ]
  }
}

@description('The resource group name of the Azure Arc enabled server.')
@allowed([
  'User'
  'Platform'
])
param inGuestPatchMode string = 'User'

@allowed(['p','np','qa'])
@description('The short name of the environment of the key vault to be created.')
param environment string = 'p'

@description('Timezone of the Maintenance Configurations .')
@maxLength(10)
param timezone string = 'US-Eastern'

@description('Whether to create a lock on the maintenance configuration. It defaults to true')
param resourceLock bool = true

// PT+1 is the default day designation for the Wednesday after the second Tuesday of the month
@description('The day designation of the maintenance window. It defaults to PT+1')
param dayDesignation string = 'PT+1'

var maintenanceConfigurationName = toLower('mc-${timezone}-${environment}-${dayDesignation}')

@description('The Tags to associate with the resource group to create.')
param tags object = {
  Environment: 'Production'
  Owner: 'John Doe'
  Classification: 'Internal'
  CostCenter: '54321'
  WorkloadName: 'Arc Maintenance Configuration- ${timezone}'
  Timezone: timezone
  DeploymentType: 'Bicep'
}


resource patchConfiguration 'Microsoft.Maintenance/maintenanceConfigurations@2023-04-01' = {
  name: maintenanceConfigurationName
  location: location
  tags: tags
  properties: {
    extensionProperties: {
      inGuestPatchMode: inGuestPatchMode
    }
    installPatches: installPatches
    maintenanceScope: maintenanceScope
    maintenanceWindow: maintenanceWindows
    visibility: visibility
  }
}

resource lock 'Microsoft.Authorization/locks@2020-05-01' = if (resourceLock){
  name: '${maintenanceConfigurationName}-lock'
  properties: {
    level: 'CanNotDelete'
    notes: 'Lock to prevent accidental deletion of maintenance configuration'
  }
  scope: patchConfiguration
}
