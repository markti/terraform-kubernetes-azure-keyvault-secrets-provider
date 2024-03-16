variable "namespace" {
  type = string
}
variable "keyvault_name" {
  type = string
}
variable "workload_managed_identity_id" {
  type = string
}
variable "secret_provider_name" {
  type = string
}
variable "secret_name" {
  type = string
}
variable "tenant_id" {
  type = string
}
variable "secrets" {
  type = list(string)
}