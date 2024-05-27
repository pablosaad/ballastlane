output "kube_config" {
  description = "Kubernetes config file content"
  value       = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
}
