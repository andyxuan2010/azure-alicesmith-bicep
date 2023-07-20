param pip_name string = 'pip-alicesmith'
param location string = resourceGroup().location

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
