locals {
  object_template = <<-EOT
    - |
      objectName: %s
      objectType: secret
      objectVersion: ""
  EOT

  objects_string = join("\n", [for name in var.secrets : format(local.object_template, name)])

  keyvault_objects = <<-EOT
        objects        = <<OBJECTS
      array:
    ${indent(6, local.objects_string)}
    OBJECTS
  EOT

  keyvault_data = [for name in var.secrets : {
    key        = name
    objectName = name
  }]
}


resource "kubernetes_manifest" "secret_store" {
  manifest = {
    apiVersion = "secrets-store.csi.x-k8s.io/v1"
    kind       = "SecretProviderClass"
    metadata = {
      name      = var.secret_provider_name
      namespace = var.namespace
    }
    spec = {
      provider = "azure"
      secretObjects = [
        {
          data       = local.keyvault_data
          secretName = var.secret_name
          type       = "Opaque"
        }
      ]
      parameters = {
        usePodIdentity = "false"
        clientID       = var.workload_managed_identity_id
        keyvaultName   = var.keyvault_name
        cloudName      = ""
        objects        = local.keyvault_objects
        tenantId       = var.tenant_id
      }
    }
  }
}