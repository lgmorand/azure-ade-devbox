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

# create pool DevPool
resource "azapi_resource" "devpool" {
  type = "Microsoft.DevCenter/projects/pools@2023-04-01"
  name = "${var.devcenter_name}DevPool"
  location = azurerm_resource_group.rg.location
  parent_id = azurerm_dev_center_project.demodevproject.id
  tags = {
    env = "dev"
  }
  body = jsonencode({
    properties = {
      devBoxDefinitionName = "${azurerm_dev_center_dev_box_definition.WebDevBox.name}"
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

# create pool DevPoolPowerFull
resource "azapi_resource" "devpoolpowerfull" {
  type = "Microsoft.DevCenter/projects/pools@2023-04-01"
  name = "${var.devcenter_name}DevPoolPowerFull"
  location = azurerm_resource_group.rg.location
  parent_id = azurerm_dev_center_project.demodevproject.id
  tags = {
    env = "dev"
  }
  body = jsonencode({
    properties = {
      devBoxDefinitionName = "${azurerm_dev_center_dev_box_definition.SuperPowerfullDevBox.name}"
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