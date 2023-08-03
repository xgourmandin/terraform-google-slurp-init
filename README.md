# terraform-google-slurp-init
A Terraform module to configure Slurp Server

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_restapi"></a> [restapi](#requirement\_restapi) | 1.18.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_restapi"></a> [restapi](#provider\_restapi) | 1.18.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [restapi_object.api_configuration](https://registry.terraform.io/providers/Mastercard/restapi/1.18.1/docs/resources/object) | resource |
| [google_service_account_id_token.oidc](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/service_account_id_token) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_configurations"></a> [api\_configurations](#input\_api\_configurations) | api\_configurations = {<br>      name: The unique name of this API configuration<br>      url: The API endpoint<br>      method: Http method (GET or POST)<br>      auth = {<br>        type        : The Authentication type (API\_KEY supported)<br>        in\_header   : Whether to put the credential in request header or in query param (if false)<br>        token\_env   : The token value environment variable<br>        token\_param : The name of the authentication parameter to add to the request<br>      }<br>      token\_scopes : "List of scopes affected by this service account impersonation"<br>      token\_lifetime : "Time the token will be active"<br>    } | <pre>list(object({<br>    name   = string<br>    url    = string<br>    method = string<br>    auth   = optional(object({<br>      type              = string<br>      in_header         = bool<br>      token_env         = optional(string)<br>      token_param       = optional(string)<br>      access_token_url  = optional(string)<br>      payload_template  = optional(string)<br>      client_id         = optional(string),<br>      client_secret     = optional(string),<br>      access_token_path = optional(string)<br>    }))<br>    pagination = optional(object({<br>      type           = string<br>      page_param     = optional(string)<br>      limit_param    = optional(string)<br>      page_size      = optional(number)<br>      next_link_path = optional(string)<br>    }))<br>    data = object({<br>      type = string<br>      root = string<br>    })<br>    additional_headers     = optional(map(string))<br>    additional_queryparams = optional(map(string))<br>    output                 = optional(object({<br>      type       = string<br>      filename   = optional(string)<br>      bucket     = optional(string)<br>      project    = optional(string)<br>      dataset    = optional(string)<br>      table      = optional(string)<br>      autodetect = optional(bool)<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_gcp_project_id"></a> [gcp\_project\_id](#input\_gcp\_project\_id) | The project ID in which Slurp is deployed | `string` | n/a | yes |
| <a name="input_gcp_region"></a> [gcp\_region](#input\_gcp\_region) | The GCP region in which Slurp is deployed | `string` | `"europe-west1"` | no |
| <a name="input_slurp_server_sa_email"></a> [slurp\_server\_sa\_email](#input\_slurp\_server\_sa\_email) | Email of the service account running Slurp Server | `string` | n/a | yes |
| <a name="input_slurp_server_url"></a> [slurp\_server\_url](#input\_slurp\_server\_url) | The Slurp server URL to configure | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->