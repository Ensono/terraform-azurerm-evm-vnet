locals {
  resource_tags = merge(
    var.azure_resource_tags, {
      environment_name = terraform.workspace
    }
  )
}
