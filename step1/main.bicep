


param location string = resourceGroup().location

@secure()
param sqlAdminUser string

@secure()
param sqlAdminPassword string

param sqlDatabaseSku object = {
  name: 'Standard'
  tier: 'Standard'
}


var sqlServerName = 'eaug${location}${uniqueString(resourceGroup().id)}'
var sqldatabase = 'customers'

resource sqlServer 'Microsoft.Sql/servers@2021-02-01-preview' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: sqlAdminUser
    administratorLoginPassword: sqlAdminPassword
  }
}

resource sqlDatabase 'Microsoft.Sql/servers/databases@2021-02-01-preview' = {
  name: sqldatabase
  location: location
  parent: sqlServer
  sku: sqlDatabaseSku
}
