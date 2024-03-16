output "secret_name" {
  value = kubernetes_manifest.secret_store.manifest.spec.secretObjects.0.secretName
}
output "secret_provider_name" {
  value = kubernetes_manifest.secret_store.manifest.metadata.name
}