locals {
  resource_tags = merge(
    var.azure_resource_tags, {
      company_name     = var.company_name
      project_name     = var.project_name
      environment_name = var.environment_name
    }
  )
}
