variable "gcp_project_id" {
  type        = string
  description = "The project ID in which Slurp is deployed"
}

variable "gcp_region" {
  type        = string
  description = "The GCP region in which Slurp is deployed"
  default     = "europe-west1"
}

variable "slurp_server_url" {
  type        = string
  description = "The Slurp server URL to configure"
}

variable "slurp_server_sa_email" {
  type = string
  description = "Email of the service account running Slurp Server"
}

variable "api_configurations" {
  type = list(object({
    name   = string
    url    = string
    method = string
    auth   = optional(object({
      type              = string
      in_header         = bool
      token_env         = optional(string)
      token_param       = optional(string)
      access_token_url  = optional(string)
      payload_template  = optional(string)
      client_id         = optional(string),
      client_secret     = optional(string),
      access_token_path = optional(string)
    }))
    pagination = optional(object({
      type           = string
      page_param     = optional(string)
      limit_param    = optional(string)
      page_size      = optional(number)
      next_link_path = optional(string)
    }))
    data = object({
      type = string
      root = string
    })
    additional_headers     = optional(map(string))
    additional_queryparams = optional(map(string))
    output                 = optional(object({
      type       = string
      filename   = optional(string)
      bucket     = optional(string)
      project    = optional(string)
      dataset    = optional(string)
      table      = optional(string)
      autodetect = optional(bool)
    }))
  }))

  default = []

  description = <<EOT
    api_configurations = {
      name: The unique name of this API configuration
      url: The API endpoint
      method: Http method (GET or POST)
      auth = {
        type        : The Authentication type (API_KEY supported)
        in_header   : Whether to put the credential in request header or in query param (if false)
        token_env   : The token value environment variable
        token_param : The name of the authentication parameter to add to the request
      }
      token_scopes : "List of scopes affected by this service account impersonation"
      token_lifetime : "Time the token will be active"
    }
  EOT

  validation {
    condition = alltrue([
      for conf in var.api_configurations : (
      conf.method == "GET" || conf.method == "POST"
      )
    ])
    error_message = "API method shall be one of GET or POST"
  }
}
