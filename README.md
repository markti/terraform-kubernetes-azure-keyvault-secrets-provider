# Terraform Kubernetes Azure KeyVault Secret Provider Class Module

This Terraform module provisions a Kubernetes SecretProviderClass to enable Azure KeyVault secret usage within a Kubernetes cluster. It has been tested with Azure Kubernetes Service (AKS).

## Requirements

- Terraform 1.0 or higher
- Kubernetes provider

## Usage

To use this module, include it in your Terraform configuration with the required parameters. Here is an example:

```hcl
module "keyvault_provider" {
  source = "./modules/keyvault"

  namespace                    = "app"
  keyvault_name                = var.keyvault_name
  workload_managed_identity_id = var.workload_managed_identity_id
  tenant_id                    = data.azurerm_client_config.current.tenant_id
  secret_provider_name         = "myapp-secrets"
  secret_name                  = "myapp"
  secrets = [
    "redis-connection-string",
    "redis-endpoint",
    "redis-username",
    "app-insights-connection-string"
  ]
}
```

## Variables

- `namespace`: The Kubernetes namespace where the SecretProviderClass will be created.
- `keyvault_name`: The name of the Azure KeyVault.
- `workload_managed_identity_id`: The managed identity ID for the AKS workload to access the KeyVault.
- `tenant_id`: The Azure tenant ID.
- `secret_provider_name`: The name of the SecretProviderClass.
- `secret_name`: The name of the Kubernetes secret to store the KeyVault secrets.
- `secrets`: A list of secret names from Azure KeyVault to be included in the Kubernetes secret.

## Outputs

- `secret_provider_name`: The name of the created SecretProviderClass.
- `secret_name`: The name of the created Kubernetes secret.

## Example

An example of using this module to create a SecretProviderClass for a set of secrets in Azure KeyVault:

```hcl
module "keyvault_provider" {
  source = "./modules/keyvault"

  namespace                    = "app"
  keyvault_name                = "myapp-keyvault"
  workload_managed_identity_id = "00000000-0000-0000-0000-000000000000"
  tenant_id                    = "00000000-0000-0000-0000-000000000000"
  secret_provider_name         = "myapp-secrets"
  secret_name                  = "myapp-secrets"
  secrets = [
    "redis-connection-string",
    "redis-endpoint",
    "redis-username",
    "app-insights-connection-string"
  ]
}
```

## Notes

- Ensure that the AKS workload managed identity has the necessary permissions to access the secrets in the Azure KeyVault.
- The secrets in the `secrets` list must exist in the specified Azure KeyVault.

## Contributing

Contributions to this module are welcome. Please open a pull request or issue to propose changes or report bugs.

## License

This Terraform module is licensed under the MPL License.