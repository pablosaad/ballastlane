variable "resource_group_name" {
  description = "The name of the resource group"
  default     = "aks-resource-group"
}

variable "location" {
  description = "The location of the resource group"
  default     = "East US"
}

variable "aks_cluster_name" {
  description = "The name of the AKS cluster"
  default     = "aks-cluster"
}
