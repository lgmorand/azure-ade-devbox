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
  default = "3ec0c0c4-4d1a-4c0d-992b-5f9e4489c32e"
  type = string
}

variable "tenant_id" {
  default = "5adc10ff-32d0-4a47-ab9c-bf7e1204b58a"
  type = string
}

variable "location" {
  default = "northeurope"
  type = string
}

#GUID user to access devbox portal
variable "principal_ids" {
  type        = list(string)
  default = [ "9659e6f1-8bbd-4dd9-8211-989d356ad770" ]
  description = "The ID of the principal that is to be assigned the role at the devbox resource"
}
