variable "resource_group_name" {
  default = "DemoDevBoxViaTerraform"
  type = string
}

variable "devcenter_name" {
  default = "DevCenterViaTerraform"
  type = string
}

variable "devproject_name" {
  default = "DevProjectViaTerraform"
  type = string
}

variable "subscription_id" {
  default = "######"
  type = string
}

variable "tenant_id" {
  default = "######"
  type = string
}

variable "location" {
  default = "northeurope"
  type = string
}
