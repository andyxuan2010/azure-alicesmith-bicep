param location string = resourceGroup().location
param vnet_name string = 'vnet-alicesmith'


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
        //networkSecurityGroupId           : nsgalicesmith.id
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}
