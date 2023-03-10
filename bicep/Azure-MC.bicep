param name string = 'azmc-arc-day1'
param location string = resourceGroup().location

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

@allowed([
  'Custom'
  'Public'
])
param visibility string = 'Custom'

@description('See https://learn.microsoft.com/en-us/azure/templates/microsoft.maintenance/maintenanceconfigurations?pivots=deployment-language-bicep#maintenancewindow for details')
param maintenanceWindows object = {
  startDateTime: '2023-03-09 00:00'
  duration: '03:55'
  timeZone: 'Eastern Standard Time'
  recurEvery: '1Month Second Tuesday Offset1'
}

param installPatches object = {
  classificationsToInclude: [
    'Critical'
    'Security'
    'Updates'
  ]
  LinuxParameters: {
    classificationsToInclude: [
      'Critical'
      'Security'
    ]
  }
}

@allowed([
  'User'
  'Platform'
])
param inGuestPatchMode string = 'User'

resource patchConfiguration 'Microsoft.Maintenance/maintenanceConfigurations@2022-07-01-preview' = {
  name: name
  location: location
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
