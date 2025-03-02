provider "vault" {
  skip_child_token = true
}

provider "restapi" {
  uri                  = "https://cmp-web.sncf.fr/api"
  write_returns_object = true
  username             = var.cmp_user
  password             = var.cmp_pwd
  insecure             = false
  timeout              = 3600
}

provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::${var.aws_account_id}:role/${var.aws_role}"
  }
}

provider "solidserver" {
  username  = data.vault_kv_secret_v2.svc_ac_ddi.data["USERNAME"]
  password  = data.vault_kv_secret_v2.svc_ac_ddi.data["PASSWORD"]
  host      = "ddi.sncf.fr"
  sslverify = "false"
}

terraform {
  required_providers {
    restapi = {
      source = "fmontezuma/restapi"
    }
    solidserver = {
      source = "EfficientIP-Labs/solidserver"
    }
  }
}
