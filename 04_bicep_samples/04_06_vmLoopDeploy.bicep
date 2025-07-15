@allowed([
  'new'
  'existing'
])
param newOrExistingVnet  string = 'new'
@allowed([
  'prod'
  'dev'
])
param env string = 'dev'
param vmUserName string = 'awesomeadmin'
@secure()
param vmPass string
@allowed([
  'windows'
  'linux'
])
param winOrLin string = 'windows'
param dataDisksCount int

var location = resourceGroup().location
var vmName = 'vm${uniqueString(resourceGroup().id)}'
var image = {
  windows: {
    publisher: 'MicrosoftWindowsServer'
    offer: 'WindowsServer'
    sku: '2019-Datacenter'
    version: 'latest'
  }
  linux: {
    publisher: 'Canonical'
    offer: 'UbuntuServer'
    sku: '18.04-LTS'
    version: 'latest'
  }
}
var vmSize = (env == 'prod') ? 'Standard_D2s_v3' : 'Standard_DS1_v2' 

resource vm 'Microsoft.Compute/virtualMachines@2021-03-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: vmName
      adminUsername: vmUserName
      adminPassword: vmPass
    }
    storageProfile: {
      imageReference: {
        publisher: image[winOrLin].publisher
        offer: image[winOrLin].offer
        sku: image[winOrLin].sku
        version: image[winOrLin].version
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'StandardSSD_LRS'
        }
      }
      dataDisks:[for i in range(1,dataDisksCount):{
        createOption: 'Empty'
        lun: i
        diskSizeGB: 100
        name: '${vmName}-datadisk${i}'

      }]
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
}

resource nic 'Microsoft.Network/networkInterfaces@2021-02-01' = {
  name: 'nic${vmName}'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIp.id
          }
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', 'awesomevnet', 'awesomesubnet')
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: resourceId(resourceGroup().name, 'Microsoft.Network/networkSecurityGroups', 'awesomensg')
    }
  }
}

resource publicIp 'Microsoft.Network/publicIPAddresses@2021-02-01' = {
  name: 'ip${vmName}'
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2021-02-01' = {
  name: 'awesomensg'
  location: location
  properties: {
    securityRules: [
      {
        name: 'RDP'
        properties: {
          priority: 300
          protocol: 'Tcp'
          access: 'Allow'
          direction: 'Inbound'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '3389'
        }
      }
    ]
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-02-01' = if(newOrExistingVnet == 'new') {
  name: 'awesomevnet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'awesomesubnet'
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
    ]
  }
}
