module "rds" {
  source = "git::https://gitlab-repo-gpf.apps.eul.sncf.fr/dosn/TERRAFORM/aws/rds.git?ref=1.8.2.1"

  cmdb_business_application = "TEAM OPS DEVOPS"
  cmdb_used_for             = "DÉVELOPPEMENT"
  cmdb_business_area        = "Services Communs"
  cmdb_appid                = "1"
  cmdb_assigned_to          = "PJDE06241"
  cmdb_supervision_enabled  = false
  cmdb_subscription         = "esncf-tod-tod-sf-nonprod-01"
  # pour différencier les bdds des gens
  cmdb_suffixe = "jde"

  deletion_protection = false

  vpc_security_group_ids = [
    "sg-0c45ca2e718338c61"
  ]

  subnet_ids = [
    "subnet-0ce7a63b2ac0f484d",
    "subnet-0ebd6e3a253c1cabd",
    "subnet-0e65f6e5135ec8153"
  ]

  enable_vault_static_role_resources = true

  instance_class = "db.t3.micro"

  aresis_project = "04374"

  tag_builder             = "prj"
  tag_criticality         = "mineur"
  tag_data_classification = "c1"
  tag_datadog_monitored   = "yes"
  tag_owner               = "TEAM OPS DEVOPS"
  additional_tags = {
    environment = "dev"
  }

}
