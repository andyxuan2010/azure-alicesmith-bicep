targetScope = 'subscription'

//param location string = resourceGroup().location
param location string = deployment().location
//param resourcegroup string = resourceGroup().name
param rg_name string = 'rg-alicesmith'

resource rgalicesmith 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: rg_name
  location: location
  properties: {}
}
