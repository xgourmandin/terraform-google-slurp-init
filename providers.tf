terraform {
  required_providers {
    restapi = {
      source  = "Mastercard/restapi"
      version = "1.18.1"
    }
  }
  backend "gcs" {
    bucket = "slurp-terraform-state"
    prefix = "slurp/init"
  }
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

data "google_service_account_id_token" "oidc" {
  target_audience        = var.slurp_server_url
  target_service_account = var.slurp_server_sa_email
  include_email          = true
  delegates              = []
}

provider "restapi" {
  uri     = var.slurp_server_url
  headers = {
    Authorization = "Bearer ${data.google_service_account_id_token.oidc.id_token}"
  }
}