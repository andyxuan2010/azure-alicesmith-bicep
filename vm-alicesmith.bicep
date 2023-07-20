param location string = resourceGroup().location
param adminUsername string = 'azureuser'
param vnic_name string = 'vnic-alicesmith'
param vm_name string = 'vm-alicesmith'
param osdisk_name string = 'osdisk-alicesmith'


@description('Generated from /subscriptions/1ec5edd4-5654-4246-8027-b29ef63b3393/resourceGroups/rg-alicesmith/providers/Microsoft.Compute/virtualMachines/vm-alicesmith')
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
          //id: '/subscriptions/1ec5edd4-5654-4246-8027-b29ef63b3393/resourceGroups/rg-alicesmith/providers/Microsoft.Compute/disks/osdisk-alicesmith'
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
          id: '/subscriptions/1ec5edd4-5654-4246-8027-b29ef63b3393/resourceGroups/rg-alicesmith/providers/Microsoft.Network/networkInterfaces/${vnic_name}'
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
  //dependsOn: [vmalicesmithOsDisk]
}




// @description('Generated from /subscriptions/1ec5edd4-5654-4246-8027-b29ef63b3393/resourceGroups/RG-ALICESMITH/providers/Microsoft.Compute/disks/vm-alicesmith_OsDisk_1_257dd552f00c4a20bfa16f0d65112cce')
// resource vmalicesmithOsDisk 'Microsoft.Compute/disks@2023-01-02' = {
//   //name: 'vm-alicesmith_OsDisk_1_257dd552f00c4a20bfa16f0d65112cce'
//   name: osdisk_name
//   location: location
//   zones: [
//     '1'
//   ]
//   sku: {
//     name: 'Premium_LRS'
//   }
//   properties: {
//     osType: 'Linux'
//     hyperVGeneration: 'V2'
//     purchasePlan: {
//       name: 'xr-server-v03'
//       publisher: 'asdivertissementinc1617837708654'
//       product: 'playfab_xr'
//     }
//     supportedCapabilities: {
//       acceleratedNetwork: true
//       architecture: 'x64'
//     }
//     creationData: {
//       createOption: 'FromImage'
//       imageReference: {
//         id: '/Subscriptions/1ec5edd4-5654-4246-8027-b29ef63b3393/Providers/Microsoft.Compute/Locations/eastus/Publishers/asdivertissementinc1617837708654/ArtifactTypes/VMImage/Offers/playfab_xr/Skus/xr-server-v03/Versions/3.0.10'
//       }
//     }
//     diskSizeGB: 30
//     diskIOPSReadWrite: 120
//     diskMBpsReadWrite: 25
//     encryption: {
//       type: 'EncryptionAtRestWithPlatformKey'
//     }
//     networkAccessPolicy: 'AllowAll'
//     publicNetworkAccess: 'Enabled'
//     tier: 'P4'
//   }
// }


