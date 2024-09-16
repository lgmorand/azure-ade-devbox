![](/media/devbox.png)

# Demo for Azure Deployment Env & Azure Dev Box

This repo helps to setup a demo of Azure Deployment Environment and Azure Dev Box [with customization](https://techcommunity.microsoft.com/t5/microsoft-developer-community/accelerate-developer-onboarding-with-the-configuration-as-code/ba-p/4062416)

# Installation

1. Run the [Github Action workflow](https://github.com/lgmorand/azure-ade-devbox/actions/workflows/demo.yaml) to provision a full demo environnment (it can take 90min but after 15min you can use it, the missing part is when creating & using a custom OS image)

# Demo

1. Go on the [Developer portal](https://devportal.microsoft.com/)

2. Create a DevBox. Select and upload a customization file. One example can be found [here](./devbox-customization/workload.yaml)

3. Wait for the creation of the DevBox. **It can take between 25 and 60min !!!**


# Installation via Terraform in progress

[Terraform portal DevCenter](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dev_center)
https://github.com/orgs/Azure/projects/529/views/1?filterQuery=devcenter

# Prerequisite
1- The subscription need to be registered to use namespace 'Microsoft.DevCenter'

# Creation order

Microsoft.Network/virtualNetworks: create a virtual network.
Microsoft.Network/virtualNetworks/subnets: create a subnet.
Microsoft.DevCenter/devcenters: create a dev center.
Microsoft.DevCenter/projects: create a project.
Microsoft.DevCenter/networkConnections: create a network connection.
Microsoft.DevCenter/devcenters/devboxdefinitions: create a dev box definition.
Microsoft.DevCenter/devcenters/galleries: create an Azure Compute Gallery.
Microsoft.DevCenter/projects/pools: create a dev box pool.