param location string = resourceGroup().location
param vnic_name string = 'vnic-alicesmith'

param subscriptionId string = subscription().subscriptionId
param resourcegroup string = resourceGroup().name

resource vniclicesmith 'Microsoft.Network/networkInterfaces@2023-02-01' = {
  name: vnic_name
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        //id: '/subscriptions/${subscriptionId}/resourceGroups/${resourcegroup}/providers/Microsoft.Network/networkInterfaces/vnic-alicesmith/ipConfigurations/ipconfig1'
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        properties: {
          privateIPAddress: '10.0.0.4'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: '/subscriptions/${subscriptionId}/resourceGroups/${resourcegroup}/providers/Microsoft.Network/publicIPAddresses/pip-alicesmith'
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
            id: '/subscriptions/1ec5edd4-5654-4246-8027-b29ef63b3393/resourceGroups/rg-alicesmith/providers/Microsoft.Network/virtualNetworks/vnet-alicesmith/subnets/default'
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
      id: '/subscriptions/1ec5edd4-5654-4246-8027-b29ef63b3393/resourceGroups/rg-alicesmith/providers/Microsoft.Network/networkSecurityGroups/nsg-alicesmith'
    }
    nicType: 'Standard'
    //allowPort25Out: false
    //nicAuxiliarySkuBillingNotificationType: 'NoOp'

  }
  location: location
}
