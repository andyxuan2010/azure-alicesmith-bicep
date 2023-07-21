@description('The name of the DNS zone to be created.  Must have at least 2 segments, e.g. hostname.org')
param zoneName string = 'dev.argentiacapital.com'

@description('The name of the DNS record to be created.  The name is relative to the zone, not the FQDN.')


resource devargentiacapitalcom 'Microsoft.Network/dnsZones@2018-05-01' = {
  name: zoneName
  location: 'global'
  tags: {}
  properties: {
    zoneType: 'Public'
  }
}


