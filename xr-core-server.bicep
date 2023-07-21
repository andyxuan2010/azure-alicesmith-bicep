param location string = resourceGroup().location
param subscriptionId string = subscription().subscriptionId
param resourcegroup string = resourceGroup().name

param adminUsername string = 'azureuser'
param vnet_name string = 'vnet-alicesmith'
param vnic_name string = 'vnic-alicesmith'
param nsg_name string = 'nsg-alicesmith'
param pip_name string = 'pip-alicesmith'
param vm_name string = 'vm-alicesmith'
param osdisk_name string = 'osdisk-alicesmith'


param metricAlertsVMAvailability string = 'VM Availability - vm-alicesmith'
param metricAlertsCPU string = 'CPU usage - vm-alicesmith'
param virtualMachines_externalid string = '/subscriptions/${subscriptionId}/resourceGroups/${resourcegroup}/providers/Microsoft.Compute/virtualMachines/${vm_name}'
param emailActionGroup_externalid string = '/subscriptions/${subscriptionId}/resourceGroups/${resourcegroup}/providers/microsoft.insights/actionGroups/emailActionGroup'
param pip_externalid string = '/subscriptions/${subscriptionId}/resourceGroups/${resourcegroup}/providers/Microsoft.Network/publicIPAddresses/${pip_name}'
param subnet_externalid string = '/subscriptions/${subscriptionId}/resourceGroups/${resourcegroup}/providers/Microsoft.Network/virtualNetworks/${vnet_name}/subnets/default'
param vnic_externalid string = '/subscriptions/${subscriptionId}/resourceGroups/${resourcegroup}/providers/Microsoft.Network/networkInterfaces/${vnic_name}'
param nsg_externalid string = '/subscriptions/${subscriptionId}/resourceGroups/${resourcegroup}/providers/Microsoft.Network/networkSecurityGroups/${nsg_name}'
param ipconfig_externalid string = '/subscriptions/${subscriptionId}/resourceGroups/${resourcegroup}/providers/Microsoft.Network/networkInterfaces/${vnic_name}/ipConfigurations/ipconfig1'


@description('The name of the DNS zone to be created.  Must have at least 2 segments, e.g. hostname.org')
param zoneName string = 'dev.argentiacapital.com'

@description('The name of the DNS record to be created.  The name is relative to the zone, not the FQDN.')
//param www_record string = 'www'
param demo_record string = 'demo'


//for the vnet
resource vnetalicesmith 'Microsoft.Network/virtualNetworks@2023-02-01' = {
  name: vnet_name
  location: location
  tags: {}
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'default'
        //id: '/subscriptions/${subscriptionId}/resourceGroups/${resourcegroup}/providers/Microsoft.Network/virtualNetworks/vnet-alicesmith/subnets/default'
        properties: {
          addressPrefix: '10.0.0.0/24'
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
  dependsOn: [ nsgalicesmith ]
}

// for the vnic

resource vnicalicesmith 'Microsoft.Network/networkInterfaces@2023-02-01' = {
  name: vnic_name
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        id: ipconfig_externalid
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          privateIPAddress: '10.0.0.4'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: pip_externalid
            properties: {
              publicIPAddressVersion: 'IPv4'
              publicIPAllocationMethod: 'Dynamic'
              idleTimeoutInMinutes: 4
              ipTags: []
              deleteOption: 'Delete'
            }
            sku: {
              name: 'Basic'
              tier: 'Regional'
            }
          }
          subnet: {
            id: subnet_externalid
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
      id: nsg_externalid
    }
    nicType: 'Standard'
    //allowPort25Out: false
    //nicAuxiliarySkuBillingNotificationType: 'NoOp'
  }
  location: location
  dependsOn: [ vnetalicesmith ]
}

// for the nsg
resource nsgalicesmith 'Microsoft.Network/networkSecurityGroups@2023-02-01' = {
  name: nsg_name
  location: location
  tags: {}
  properties: {
    securityRules: [
      {
        name: 'SSH'
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          priority: 1010
          protocol: '*'
          access: 'Allow'
          direction: 'Inbound'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '22'
        }
      }
      {
        name: 'HTTP'
        type: 'Microsoft.Network/networkSecurityGroups/securityRules'
        properties: {
          protocol: 'TCP'
          sourcePortRange: '*'
          destinationPortRange: '80'
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

// for the pip
resource pipalicesmith 'Microsoft.Network/publicIPAddresses@2023-02-01' = {
  name: pip_name
  location: location
  tags: {}
  zones: [
    '3'
    '1'
    '2'
  ]
  properties: {
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
    ipTags: []
    dnsSettings: {
      domainNameLabel: pip_name
    }
  }
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
}

// last for the vm
resource vmalicesmith 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: vm_name
  location: location
  plan: {
    name: 'xr-server-v03'
    publisher: 'asdivertissementinc1617837708654'
    product: 'playfab_xr'
  }
  identity: {
    type: 'SystemAssigned'
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
        name: osdisk_name
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
          //id: '/subscriptions/${subscriptionId}/resourceGroups/${resourcegroup}/providers/Microsoft.Compute/disks/osdisk-alicesmith'
        }
        deleteOption: 'Delete'
        diskSizeGB: 30
      }
      dataDisks: []
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: 'vm-alicesmith'
      adminUsername: adminUsername
      linuxConfiguration: {
        disablePasswordAuthentication: true
        ssh: {
          publicKeys: [
            {
              path: '/home/azureuser/.ssh/authorized_keys'
              keyData: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDBhy/C9OvQsPDcuN2T/p2mGP1aQm9qCIOOe/tRFaF+PTn6GrqL94QIzUgIrfiuMU/NcfXzC5JrEFJtHod5PUwF1ksxZJu9kFGXPyCPGw/LgUjaWfgP3iZKDBIH0xaNYfpkwynWi8ZQElgQz1oFCsC8fY9cOwsfXxWbtuoFRn9ZeNERrDyqMjRQqsDQ7B1GNzDEVIrYVR2/cEuzyCvXI3L8kbyl8KrG8S+RKBMcJ1qTMSq5r30H8qPf1J/rokeEilwmxoJx80AXre99Bji4K8bY50JaxjdWuYIB5j+Y41DLPyJdBGic58qhkwoXAE4ElE1IxTV2Kao4KBCloluBD2FVrl9pEN315/FQZPFIpgRY8RlZggoeH0CqO4Asvb2+hLk0UC5Nfk/JRuugn2NOBXAPby+ObBPSOQEj0p28gqfB3MU/mb3gLt16Zs6/WpVvq23UOq17LvYYgAXznIzonmGvTeCALrVja93nBbJ2doQ103tcqlI2WeaVtukyBk6BUyk= generated-by-azure'
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
      //requireGuestProvisionSignal: true
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: vnic_externalid
          properties: {
            deleteOption: 'Delete'
          }
        }
      ]
    }
  }
  zones: [
    '1'
  ]
  dependsOn: [ vnicalicesmith, vnetalicesmith, pipalicesmith, nsgalicesmith ]
}









resource emailActionGroup 'microsoft.insights/actionGroups@2019-06-01' = {
  name: 'emailActionGroup'
  location: 'global'
  properties: {
    groupShortName: 'string'
    enabled: true
    emailReceivers: [
      {
        name: 'test email'
        emailAddress: 'test@gmail.com'
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



resource devargentiacapitalcom 'Microsoft.Network/dnsZones@2018-05-01' = {
  name: zoneName
  //scope: resourceGroup('PayAsYouGo')
  location: 'global'
  tags: {}
  properties: {
    zoneType: 'Public'
  }
}

// resource record1 'Microsoft.Network/dnsZones/A@2018-05-01' = {
//   parent: devargentiacapitalcom
//   name: www_record
//   properties: {
//     TTL: 3600
//     targetResource: {
//       id: pip_externalid
//     }
   
//   }
// }

resource record2 'Microsoft.Network/dnsZones/A@2018-05-01' = {
  parent: devargentiacapitalcom
  name: demo_record
  properties: {
    TTL: 3600
    ARecords: [
      {
        ipv4Address: pipalicesmith.properties.ipAddress
      }
    ]    
  }
}


output nameServers array = devargentiacapitalcom.properties.nameServers
output publicip string = pipalicesmith.properties.ipAddress
