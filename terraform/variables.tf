variable "environment" {
  description = "Environnement de l'infrastructure à provisionner"
  type        = string
}
variable "aws_account_id" {
  description = "Id du compte aws"
  default     = ""
}

variable "aws_role" {
  description = "Nom du role à assumer"
  default     = ""
}

variable "cmp_user" {
  description = "utilisateur pour contacter l'Api de la CMDB"
}

variable "cmp_pwd" {
  description = "Mot de passe pour contacter l'Api de la CMDB"
}
