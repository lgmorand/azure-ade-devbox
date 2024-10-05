
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}


######### Create an devcenter
resource "azurerm_dev_center" "demodevcenter" {
  location            = azurerm_resource_group.rg.location
  name                = var.devcenter_name
  resource_group_name = azurerm_resource_group.rg.name
  identity {
    type = "SystemAssigned"
  }
}
######### Create an project
resource "azurerm_dev_center_project" "demodevproject" {
  dev_center_id       = azurerm_dev_center.demodevcenter.id
  location            = azurerm_resource_group.rg.location
  name                = "${var.devcenter_name}DevProject"
  maximum_dev_boxes_per_user = 3
  resource_group_name = azurerm_resource_group.rg.name
  depends_on = [ azurerm_dev_center.demodevcenter ]
}

####### Create VNet
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.devcenter_name}VNet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

####### Create subnet
resource "azurerm_subnet" "subnetdevcenternetwork" {
  name                 = "${var.devcenter_name}subnetdevcenternetwork"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]

  depends_on = [ azurerm_virtual_network.vnet ]
}

####### Create subnet nsg
resource "azurerm_network_security_group" "nsgdevcenternetwork" {
  name                = "${var.devcenter_name}nsgdevcenternetwork"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet_network_security_group_association" "networksecuritygroupassociation" {
  subnet_id                 = azurerm_subnet.subnetdevcenternetwork.id
  network_security_group_id = azurerm_network_security_group.nsgdevcenternetwork.id
   depends_on = [ azurerm_subnet.subnetdevcenternetwork, azurerm_network_security_group.nsgdevcenternetwork ]
}


#creation devcenter network connection
resource "azurerm_dev_center_network_connection" "devcenternetworkconnection" {
  name                = "${var.devcenter_name}Networkconnection"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  domain_join_type    = "AzureADJoin"
  subnet_id           = azurerm_subnet.subnetdevcenternetwork.id
  depends_on = [ azurerm_subnet_network_security_group_association.networksecuritygroupassociation ]
}





#creation dev box definition
resource "azurerm_dev_center_dev_box_definition" "WebDevBox" {
  name               = "${var.devcenter_name}webdevbox"
  location           = azurerm_resource_group.rg.location
  dev_center_id      = azurerm_dev_center.demodevcenter.id
  image_reference_id = "${azurerm_dev_center.demodevcenter.id}/galleries/default/images/microsoftvisualstudio_visualstudioplustools_vs-2022-ent-general-win10-m365-gen2"
  sku_name           = "general_i_8c32gb256ssd_v2"
  depends_on = [ azurerm_dev_center.demodevcenter ]
}

resource "azurerm_dev_center_dev_box_definition" "SuperPowerfullDevBox" {
  name               = "${var.devcenter_name}superpowerfulldevbox"
  location           = azurerm_resource_group.rg.location
  dev_center_id      = azurerm_dev_center.demodevcenter.id
  image_reference_id = "${azurerm_dev_center.demodevcenter.id}/galleries/default/images/microsoftvisualstudio_visualstudioplustools_vs-2022-ent-general-win10-m365-gen2"
  sku_name           = "general_i_32c128gb512ssd_v2"
  depends_on = [ azurerm_dev_center.demodevcenter ]
}


resource "azurerm_dev_center_environment_type" "envtypePROD" {
  name          = "PROD"
  dev_center_id = azurerm_dev_center.demodevcenter.id

  tags = {
    Env = "PROD"
  }
}
resource "azurerm_dev_center_environment_type" "envtypeTEST" {
  name          = "TEST"
  dev_center_id = azurerm_dev_center.demodevcenter.id

  tags = {
    Env = "TEST"
  }
}
resource "azurerm_dev_center_environment_type" "envtypeDEV" {
  name          = "DEV"
  dev_center_id = azurerm_dev_center.demodevcenter.id

  tags = {
    Env = "DEV"
  }
}