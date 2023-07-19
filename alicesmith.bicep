param vaults_defaultVault_name string = 'defaultVault'
param virtualMachines_vm_alicesmith_name string = 'vm-alicesmith'
param publicIPAddresses_vm_alicesmith_ip_name string = 'vm-alicesmith-ip'
param virtualNetworks_vm_alicesmith_vnet_name string = 'vm-alicesmith-vnet'
param networkInterfaces_vm_alicesmith25_z1_name string = 'vm-alicesmith25_z1'
param networkSecurityGroups_vm_alicesmith_nsg_name string = 'vm-alicesmith-nsg'
param actionGroups_RecommendedAlertRules_AG_1_name string = 'RecommendedAlertRules-AG-1'
param metricAlerts_Percentage_CPU_vm_alicesmith_name string = 'Percentage CPU - vm-alicesmith'
param metricAlerts_VM_Availability_vm_alicesmith_name string = 'VM Availability - vm-alicesmith'
param metricAlerts_Network_In_Total_vm_alicesmith_name string = 'Network In Total - vm-alicesmith'
param metricAlerts_Network_Out_Total_vm_alicesmith_name string = 'Network Out Total - vm-alicesmith'
param metricAlerts_Available_Memory_Bytes_vm_alicesmith_name string = 'Available Memory Bytes - vm-alicesmith'
param metricAlerts_OS_Disk_IOPS_Consumed_Percentage_vm_alicesmith_name string = 'OS Disk IOPS Consumed Percentage - vm-alicesmith'
param metricAlerts_Data_Disk_IOPS_Consumed_Percentage_vm_alicesmith_name string = 'Data Disk IOPS Consumed Percentage - vm-alicesmith'

resource actionGroups_RecommendedAlertRules_AG_1_name_resource 'microsoft.insights/actionGroups@2023-01-01' = {
  name: actionGroups_RecommendedAlertRules_AG_1_name
  location: 'Global'
  properties: {
    groupShortName: 'recalert1'
    enabled: true
    emailReceivers: [
      {
        name: 'Email_-EmailAction-'
        emailAddress: 'xuanli2008@hotmail.com'
        useCommonAlertSchema: true
      }
    ]
    smsReceivers: []
    webhookReceivers: []
    eventHubReceivers: []
    itsmReceivers: []
    azureAppPushReceivers: []
    automationRunbookReceivers: []
    voiceReceivers: []
    logicAppReceivers: []
    azureFunctionReceivers: []
    armRoleReceivers: []
  }
}

resource networkSecurityGroups_vm_alicesmith_nsg_name_resource 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
  name: networkSecurityGroups_vm_alicesmith_nsg_name
  location: 'eastus'
  properties: {
    securityRules: [
      {
        name: 'HTTP'
        id: networkSecurityGroups_vm_alicesmith_nsg_name_HTTP.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 1010
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'default-allow-ssh'
        id: networkSecurityGroups_vm_alicesmith_nsg_name_default_allow_ssh.id
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '22'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 1020
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

resource publicIPAddresses_vm_alicesmith_ip_name_resource 'Microsoft.Network/publicIPAddresses@2022-11-01' = {
  name: publicIPAddresses_vm_alicesmith_ip_name
  location: 'eastus'
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  zones: [
    '1'
  ]
  properties: {
    ipAddress: '20.83.146.197'
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
  }
}

resource virtualNetworks_vm_alicesmith_vnet_name_resource 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: virtualNetworks_vm_alicesmith_vnet_name
  location: 'eastus'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'default'
        id: virtualNetworks_vm_alicesmith_vnet_name_default.id
        properties: {
          addressPrefix: '10.1.0.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
        type: 'Microsoft.Network/virtualNetworks/subnets'
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

resource vaults_defaultVault_name_resource 'Microsoft.RecoveryServices/vaults@2023-04-01' = {
  name: vaults_defaultVault_name
  location: 'eastus'
  sku: {
    name: 'RS0'
    tier: 'Standard'
  }
  properties: {
    redundancySettings: {}
    securitySettings: {}
    publicNetworkAccess: 'Enabled'
    restoreSettings: {
      crossSubscriptionRestoreSettings: {
        crossSubscriptionRestoreState: 'Enabled'
      }
    }
  }
}

resource virtualMachines_vm_alicesmith_name_resource 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: virtualMachines_vm_alicesmith_name
  location: 'eastus'
  zones: [
    '1'
  ]
  identity: {
    type: 'SystemAssigned'
  }
  plan: {
    name: 'xr-server-v03'
    product: 'playfab_xr'
    publisher: 'asdivertissementinc1617837708654'
  }
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2s_v3'
    }
    storageProfile: {
      imageReference: {
        publisher: 'asdivertissementinc1617837708654'
        offer: 'playfab_xr'
        sku: 'xr-server-v03'
        version: 'latest'
      }
      osDisk: {
        osType: 'Linux'
        name: '${virtualMachines_vm_alicesmith_name}_OsDisk_1_8ce08dc2bdab40b6988ec8de60735066'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'StandardSSD_LRS'
          id: resourceId('Microsoft.Compute/disks', '${virtualMachines_vm_alicesmith_name}_OsDisk_1_8ce08dc2bdab40b6988ec8de60735066')
        }
        deleteOption: 'Delete'
        diskSizeGB: 30
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: virtualMachines_vm_alicesmith_name
      adminUsername: 'azureuser'
      linuxConfiguration: {
        disablePasswordAuthentication: true
        ssh: {
          publicKeys: [
            {
              path: '/home/azureuser/.ssh/authorized_keys'
              keyData: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDIqfriZJbopqGHXo1gVfxo7LNF7rx+Yq1qSFpLeojDS4DWr/a8v2dpevDf95Xku/BGLZ16eRQFlW4/YFfhpPIy1sYVlaJQVOiALN8sk1R5OuGjLXy2e22SRVgH0LQehHCLwmszjuLhbmDO8qjNnzm0JIYHmv4+VkZ56LI8rTiPozHmKGxgKfhKhV1vh9NzdCnj7Nh/iQWAU82X5UzYU6J6t7Ape1bp4C74yPH3NOcVcV51qKZXiamfM2PfPnU11I+Wd7Ho8l1yvpUUZe0FdSBZtp7oWya+oPy5AXJlfuMCq5WjVUO9LCvpZMsJWQDhocMFuDRiNw4+0G/XnathEiRP root@emachine\n'
            }
          ]
        }
        provisionVMAgent: true
        patchSettings: {
          patchMode: 'ImageDefault'
          assessmentMode: 'ImageDefault'
        }
        enableVMAgentPlatformUpdates: false
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaces_vm_alicesmith25_z1_name_resource.id
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
    priority: 'Spot'
    evictionPolicy: 'Deallocate'
    billingProfile: {
      maxPrice: -1
    }
  }
}

resource networkSecurityGroups_vm_alicesmith_nsg_name_default_allow_ssh 'Microsoft.Network/networkSecurityGroups/securityRules@2022-11-01' = {
  name: '${networkSecurityGroups_vm_alicesmith_nsg_name}/default-allow-ssh'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '22'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 1020
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_vm_alicesmith_nsg_name_resource
  ]
}

resource networkSecurityGroups_vm_alicesmith_nsg_name_HTTP 'Microsoft.Network/networkSecurityGroups/securityRules@2022-11-01' = {
  name: '${networkSecurityGroups_vm_alicesmith_nsg_name}/HTTP'
  properties: {
    protocol: 'TCP'
    sourcePortRange: '*'
    destinationPortRange: '80'
    sourceAddressPrefix: '*'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 1010
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
  dependsOn: [
    networkSecurityGroups_vm_alicesmith_nsg_name_resource
  ]
}

resource virtualNetworks_vm_alicesmith_vnet_name_default 'Microsoft.Network/virtualNetworks/subnets@2022-11-01' = {
  name: '${virtualNetworks_vm_alicesmith_vnet_name}/default'
  properties: {
    addressPrefix: '10.1.0.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
  dependsOn: [
    virtualNetworks_vm_alicesmith_vnet_name_resource
  ]
}

resource vaults_defaultVault_name_DefaultPolicy 'Microsoft.RecoveryServices/vaults/backupPolicies@2023-02-01' = {
  parent: vaults_defaultVault_name_resource
  name: 'DefaultPolicy'
  properties: {
    backupManagementType: 'AzureIaasVM'
    instantRPDetails: {}
    schedulePolicy: {
      schedulePolicyType: 'SimpleSchedulePolicy'
      scheduleRunFrequency: 'Daily'
      scheduleRunTimes: [
        '2023-07-20T07:30:00Z'
      ]
      scheduleWeeklyFrequency: 0
    }
    retentionPolicy: {
      retentionPolicyType: 'LongTermRetentionPolicy'
      dailySchedule: {
        retentionTimes: [
          '2023-07-20T07:30:00Z'
        ]
        retentionDuration: {
          count: 30
          durationType: 'Days'
        }
      }
    }
    instantRpRetentionRangeInDays: 2
    timeZone: 'UTC'
    protectedItemsCount: 0
  }
}

resource vaults_defaultVault_name_EnhancedPolicy 'Microsoft.RecoveryServices/vaults/backupPolicies@2023-02-01' = {
  parent: vaults_defaultVault_name_resource
  name: 'EnhancedPolicy'
  properties: {
    backupManagementType: 'AzureIaasVM'
    policyType: 'V2'
    instantRPDetails: {}
    schedulePolicy: {
      schedulePolicyType: 'SimpleSchedulePolicyV2'
      scheduleRunFrequency: 'Hourly'
      hourlySchedule: {
        interval: 4
        scheduleWindowStartTime: '2023-07-20T08:00:00Z'
        scheduleWindowDuration: 12
      }
    }
    retentionPolicy: {
      retentionPolicyType: 'LongTermRetentionPolicy'
      dailySchedule: {
        retentionTimes: [
          '2023-07-20T08:00:00Z'
        ]
        retentionDuration: {
          count: 30
          durationType: 'Days'
        }
      }
    }
    instantRpRetentionRangeInDays: 2
    timeZone: 'UTC'
    protectedItemsCount: 0
  }
}

resource vaults_defaultVault_name_EnhancedPolicy_lka8lm1u 'Microsoft.RecoveryServices/vaults/backupPolicies@2023-02-01' = {
  parent: vaults_defaultVault_name_resource
  name: 'EnhancedPolicy-lka8lm1u'
  properties: {
    backupManagementType: 'AzureIaasVM'
    policyType: 'V2'
    instantRPDetails: {}
    schedulePolicy: {
      schedulePolicyType: 'SimpleSchedulePolicyV2'
      scheduleRunFrequency: 'Hourly'
      hourlySchedule: {
        interval: 4
        scheduleWindowStartTime: '2021-07-26T08:00:00Z'
        scheduleWindowDuration: 12
      }
    }
    retentionPolicy: {
      retentionPolicyType: 'LongTermRetentionPolicy'
      dailySchedule: {
        retentionTimes: [
          '2023-07-19T04:00:00Z'
        ]
        retentionDuration: {
          count: 30
          durationType: 'Days'
        }
      }
    }
    instantRpRetentionRangeInDays: 7
    timeZone: 'UTC'
    protectedItemsCount: 0
  }
}

resource vaults_defaultVault_name_HourlyLogBackup 'Microsoft.RecoveryServices/vaults/backupPolicies@2023-02-01' = {
  parent: vaults_defaultVault_name_resource
  name: 'HourlyLogBackup'
  properties: {
    backupManagementType: 'AzureWorkload'
    workLoadType: 'SQLDataBase'
    settings: {
      timeZone: 'UTC'
      issqlcompression: false
      isCompression: false
    }
    subProtectionPolicy: [
      {
        policyType: 'Full'
        schedulePolicy: {
          schedulePolicyType: 'SimpleSchedulePolicy'
          scheduleRunFrequency: 'Daily'
          scheduleRunTimes: [
            '2023-07-20T07:30:00Z'
          ]
          scheduleWeeklyFrequency: 0
        }
        retentionPolicy: {
          retentionPolicyType: 'LongTermRetentionPolicy'
          dailySchedule: {
            retentionTimes: [
              '2023-07-20T07:30:00Z'
            ]
            retentionDuration: {
              count: 30
              durationType: 'Days'
            }
          }
        }
      }
      {
        policyType: 'Log'
        schedulePolicy: {
          schedulePolicyType: 'LogSchedulePolicy'
          scheduleFrequencyInMins: 60
        }
        retentionPolicy: {
          retentionPolicyType: 'SimpleRetentionPolicy'
          retentionDuration: {
            count: 30
            durationType: 'Days'
          }
        }
      }
    ]
    protectedItemsCount: 0
  }
}

resource vaults_defaultVault_name_defaultAlertSetting 'Microsoft.RecoveryServices/vaults/replicationAlertSettings@2023-04-01' = {
  parent: vaults_defaultVault_name_resource
  name: 'defaultAlertSetting'
  properties: {
    sendToOwners: 'DoNotSend'
    customEmailAddresses: []
  }
}

resource vaults_defaultVault_name_default 'Microsoft.RecoveryServices/vaults/replicationVaultSettings@2023-04-01' = {
  parent: vaults_defaultVault_name_resource
  name: 'default'
  properties: {}
}

resource metricAlerts_Available_Memory_Bytes_vm_alicesmith_name_resource 'microsoft.insights/metricAlerts@2018-03-01' = {
  name: metricAlerts_Available_Memory_Bytes_vm_alicesmith_name
  location: 'Global'
  properties: {
    severity: 3
    enabled: true
    scopes: [
      virtualMachines_vm_alicesmith_name_resource.id
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT5M'
    criteria: {
      allOf: [
        {
          threshold: 1000000000
          name: 'Metric1'
          metricNamespace: 'Microsoft.Compute/virtualMachines'
          metricName: 'Available Memory Bytes'
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
        actionGroupId: actionGroups_RecommendedAlertRules_AG_1_name_resource.id
        webHookProperties: {}
      }
    ]
  }
}

resource metricAlerts_Data_Disk_IOPS_Consumed_Percentage_vm_alicesmith_name_resource 'microsoft.insights/metricAlerts@2018-03-01' = {
  name: metricAlerts_Data_Disk_IOPS_Consumed_Percentage_vm_alicesmith_name
  location: 'Global'
  properties: {
    severity: 3
    enabled: true
    scopes: [
      virtualMachines_vm_alicesmith_name_resource.id
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT5M'
    criteria: {
      allOf: [
        {
          threshold: 95
          name: 'Metric1'
          metricNamespace: 'Microsoft.Compute/virtualMachines'
          metricName: 'Data Disk IOPS Consumed Percentage'
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
        actionGroupId: actionGroups_RecommendedAlertRules_AG_1_name_resource.id
        webHookProperties: {}
      }
    ]
  }
}

resource metricAlerts_Network_In_Total_vm_alicesmith_name_resource 'microsoft.insights/metricAlerts@2018-03-01' = {
  name: metricAlerts_Network_In_Total_vm_alicesmith_name
  location: 'Global'
  properties: {
    severity: 3
    enabled: true
    scopes: [
      virtualMachines_vm_alicesmith_name_resource.id
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT5M'
    criteria: {
      allOf: [
        {
          threshold: 500000000000
          name: 'Metric1'
          metricNamespace: 'Microsoft.Compute/virtualMachines'
          metricName: 'Network In Total'
          operator: 'GreaterThan'
          timeAggregation: 'Total'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria'
    }
    targetResourceType: 'Microsoft.Compute/virtualMachines'
    actions: [
      {
        actionGroupId: actionGroups_RecommendedAlertRules_AG_1_name_resource.id
        webHookProperties: {}
      }
    ]
  }
}

resource metricAlerts_Network_Out_Total_vm_alicesmith_name_resource 'microsoft.insights/metricAlerts@2018-03-01' = {
  name: metricAlerts_Network_Out_Total_vm_alicesmith_name
  location: 'Global'
  properties: {
    severity: 3
    enabled: true
    scopes: [
      virtualMachines_vm_alicesmith_name_resource.id
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT5M'
    criteria: {
      allOf: [
        {
          threshold: 200000000000
          name: 'Metric1'
          metricNamespace: 'Microsoft.Compute/virtualMachines'
          metricName: 'Network Out Total'
          operator: 'GreaterThan'
          timeAggregation: 'Total'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria'
    }
    targetResourceType: 'Microsoft.Compute/virtualMachines'
    actions: [
      {
        actionGroupId: actionGroups_RecommendedAlertRules_AG_1_name_resource.id
        webHookProperties: {}
      }
    ]
  }
}

resource metricAlerts_OS_Disk_IOPS_Consumed_Percentage_vm_alicesmith_name_resource 'microsoft.insights/metricAlerts@2018-03-01' = {
  name: metricAlerts_OS_Disk_IOPS_Consumed_Percentage_vm_alicesmith_name
  location: 'Global'
  properties: {
    severity: 3
    enabled: true
    scopes: [
      virtualMachines_vm_alicesmith_name_resource.id
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT5M'
    criteria: {
      allOf: [
        {
          threshold: 95
          name: 'Metric1'
          metricNamespace: 'Microsoft.Compute/virtualMachines'
          metricName: 'OS Disk IOPS Consumed Percentage'
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
        actionGroupId: actionGroups_RecommendedAlertRules_AG_1_name_resource.id
        webHookProperties: {}
      }
    ]
  }
}

resource metricAlerts_Percentage_CPU_vm_alicesmith_name_resource 'microsoft.insights/metricAlerts@2018-03-01' = {
  name: metricAlerts_Percentage_CPU_vm_alicesmith_name
  location: 'Global'
  properties: {
    severity: 3
    enabled: true
    scopes: [
      virtualMachines_vm_alicesmith_name_resource.id
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
        actionGroupId: actionGroups_RecommendedAlertRules_AG_1_name_resource.id
        webHookProperties: {}
      }
    ]
  }
}

resource metricAlerts_VM_Availability_vm_alicesmith_name_resource 'microsoft.insights/metricAlerts@2018-03-01' = {
  name: metricAlerts_VM_Availability_vm_alicesmith_name
  location: 'Global'
  properties: {
    severity: 3
    enabled: true
    scopes: [
      virtualMachines_vm_alicesmith_name_resource.id
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
        actionGroupId: actionGroups_RecommendedAlertRules_AG_1_name_resource.id
        webHookProperties: {}
      }
    ]
  }
}

resource networkInterfaces_vm_alicesmith25_z1_name_resource 'Microsoft.Network/networkInterfaces@2022-11-01' = {
  name: networkInterfaces_vm_alicesmith25_z1_name
  location: 'eastus'
  kind: 'Regular'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        id: '${networkInterfaces_vm_alicesmith25_z1_name_resource.id}/ipConfigurations/ipconfig1'
        etag: 'W/"8c730382-ef88-45dc-8867-9581d74f7aeb"'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          provisioningState: 'Succeeded'
          privateIPAddress: '10.1.0.4'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            name: 'vm-alicesmith-ip'
            id: publicIPAddresses_vm_alicesmith_ip_name_resource.id
            properties: {
              provisioningState: 'Succeeded'
              resourceGuid: 'd1cdcbc5-db09-481e-b7c4-8768d2e98a02'
              publicIPAddressVersion: 'IPv4'
              publicIPAllocationMethod: 'Dynamic'
              idleTimeoutInMinutes: 4
              ipTags: []
              ipConfiguration: {
                id: '${networkInterfaces_vm_alicesmith25_z1_name_resource.id}/ipConfigurations/ipconfig1'
              }
              deleteOption: 'Detach'
            }
            type: 'Microsoft.Network/publicIPAddresses'
            sku: {
              name: 'Basic'
              tier: 'Regional'
            }
          }
          subnet: {
            id: virtualNetworks_vm_alicesmith_vnet_name_default.id
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: true
    enableIPForwarding: false
    disableTcpStateTracking: false
    networkSecurityGroup: {
      id: networkSecurityGroups_vm_alicesmith_nsg_name_resource.id
    }
    nicType: 'Standard'
  }
}