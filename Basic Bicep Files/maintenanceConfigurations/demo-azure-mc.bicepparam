using './demo-azure-mc.bicep'

param location = 'eastus'
param maintenanceScope = 'InGuestPatch'
param visibility = 'Custom'
param maintenanceWindows = {
  startDateTime: '2023-03-09 00:00'
  duration: '03:55'
  timeZone: 'Eastern Standard Time'
  recurEvery: '1Month Second Tuesday Offset1'
}
param installPatches = {
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
param inGuestPatchMode = 'User'
param environment = 'p'
param timezone = 'US-Eastern'
param dayDesignation = 'PT+1'
param tags = {
  Environment: 'Production'
  Owner: 'John Doe'
  Classification: 'Internal'
  CostCenter: '54321'
  WorkloadName: 'Arc Maintenance Configuration- ${timezone}'
  Timezone: timezone
  DeploymentType: 'Bicep'
}

