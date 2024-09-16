# connect devcenter to the Network connection
resource "azapi_resource" "attachdevcenternetwork" {
  type = "Microsoft.DevCenter/devcenters/attachednetworks@2023-04-01"
  name = "${var.devcenter_name}Attachdevcenternetwork"
  parent_id = azurerm_dev_center.demodevcenter.id
  body = jsonencode({
    properties = {
      networkConnectionId = "${azurerm_dev_center_network_connection.devcenternetworkconnection.id}"
    }
  })
  depends_on = [ azurerm_dev_center.demodevcenter,azurerm_dev_center_network_connection.devcenternetworkconnection ]
}

# create pool
resource "azapi_resource" "devboxpoolwebdev" {
  type = "Microsoft.DevCenter/projects/pools@2023-04-01"
  name = "${var.devcenter_name}Devboxwebdev"
  location = azurerm_resource_group.rg.location
  parent_id = azurerm_dev_center_project.demodevproject.id
  tags = {
    tagName1 = "tagValue1"
    tagName2 = "tagValue2"
  }
  body = jsonencode({
    properties = {
      devBoxDefinitionName = "${azurerm_dev_center_dev_box_definition.devboxdefinition.name}"
      licenseType = "Windows_Client"
      localAdministrator = "Disabled"
      networkConnectionName = "${azapi_resource.attachdevcenternetwork.name}"
      stopOnDisconnect = {
        gracePeriodMinutes = 60
        status = "Enabled"
      }
    }
  })
    depends_on = [ azurerm_dev_center_project.demodevproject ]
}