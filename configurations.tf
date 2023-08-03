locals {
  confs = {for c in var.api_configurations : c.name => c}
}


resource "restapi_object" "api_configuration" {
  for_each     = local.confs
  path         = "/api"
  data         = jsonencode(each.value)
  id_attribute = "name"
  debug        = true
}