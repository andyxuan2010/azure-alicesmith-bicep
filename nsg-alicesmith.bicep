param location string = resourceGroup().location
param nsg_name string = 'nsg-alicesmith'

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







