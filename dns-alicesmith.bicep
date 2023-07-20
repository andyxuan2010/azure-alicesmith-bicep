@description('The name of the DNS zone to be created.  Must have at least 2 segments, e.g. hostname.org')
param zoneName string = 'argentiacapital.com'

@description('The name of the DNS record to be created.  The name is relative to the zone, not the FQDN.')
param recordName string = 'www'

param subscriptionId string = subscription().subscriptionId
param resourcegroup string = resourceGroup().name
param pip_name string = 'pip-alicesmith'
param pip_externalid string = '/subscriptions/${subscriptionId}/resourceGroups/${resourcegroup}/providers/Microsoft.Network/publicIPAddresses/${pip_name}'

resource argentiacapitalcom 'Microsoft.Network/dnsZones@2018-05-01' = {
  name: zoneName
  //etag: 'da1dd138-94e1-4a56-b78f-9cd8fb12f60f'
  location: 'global'
  tags: {}
  properties: {
    zoneType: 'Public'
  }
}



resource record 'Microsoft.Network/dnsZones/A@2018-05-01' = {
  parent: argentiacapitalcom
  name: recordName
  properties: {
    TTL: 3600
    targetResource: {
      id: pip_externalid
    }
  }
}

output nameServers array = argentiacapitalcom.properties.nameServers







