data "vault_kv_secret_v2" "svc_ac_ddi" {
  mount = "eul_dosn"
  name  = "04374/h/DDI_MANAGE"
}
