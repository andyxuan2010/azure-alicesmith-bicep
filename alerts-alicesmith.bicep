
param subscriptionId string = subscription().subscriptionId
param resourcegroup string = resourceGroup().name

param metricAlertsVMAvailability string = 'VM Availability - vm-alicesmith'
param metricAlertsCPU string = 'CPU usage - vm-alicesmith'
param virtualMachines_externalid string = '/subscriptions/${subscriptionId}/resourceGroups/${resourcegroup}/providers/Microsoft.Compute/virtualMachines/vm-alicesmith'
param emailActionGroup_externalid string = '/subscriptions/${subscriptionId}/resourceGroups/${resourcegroup}/providers/microsoft.insights/actionGroups/emailActionGroup'




resource emailActionGroup 'microsoft.insights/actionGroups@2019-06-01' = {
  name: 'emailActionGroup'
  location: 'global'
  properties: {
    groupShortName: 'string'
    enabled: true
    emailReceivers: [
      {
        name: 'test email'
        emailAddress: 'andyxuan2010@gmail.com'
        useCommonAlertSchema: true
      }
    ]
  }
}


resource metricAlerts1 'microsoft.insights/metricAlerts@2018-03-01' = {
  name: metricAlertsVMAvailability
  location: 'Global'
  properties: {
    severity: 3
    enabled: true
    scopes: [
      virtualMachines_externalid
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT5M'
    criteria: {
      allOf: [
        {
          threshold: 1
          name: 'Metric1'
          metricNamespace: 'Microsoft.Compute/virtualMachines'
          metricName: 'VmAvailabilityMetric'
          operator: 'LessThan'
          timeAggregation: 'Average'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria'
    }
    targetResourceType: 'Microsoft.Compute/virtualMachines'
    actions: [
      {
        actionGroupId: emailActionGroup_externalid
        webHookProperties: {}
      }
    ]
  }
  dependsOn: [emailActionGroup]
}




resource metricAlerts2 'microsoft.insights/metricAlerts@2018-03-01' = {
  name: metricAlertsCPU
  location: 'Global'
  properties: {
    severity: 3
    enabled: true
    scopes: [
      virtualMachines_externalid
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT5M'
    criteria: {
      allOf: [
        {
          threshold: 80
          name: 'Metric1'
          metricNamespace: 'Microsoft.Compute/virtualMachines'
          metricName: 'Percentage CPU'
          operator: 'GreaterThan'
          timeAggregation: 'Average'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria'
    }
    targetResourceType: 'Microsoft.Compute/virtualMachines'
    actions: [
      {
        actionGroupId: emailActionGroup_externalid
        webHookProperties: {}
      }
    ]
  }
  dependsOn: [emailActionGroup]  
}
