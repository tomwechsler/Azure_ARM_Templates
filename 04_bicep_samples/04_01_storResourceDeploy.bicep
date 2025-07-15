resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'cttprod2025'
  location: 'westeurope'
  kind: 'StorageV2'
  sku: {
    name: 'Premium_LRS'
  }
  properties: {
    supportsHttpsTrafficOnly: true
  }
}
