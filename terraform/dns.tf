resource "solidserver_dns_rr" "result" {
  dnsserver = "dns-smart-intranet-prod.sncf.fr"
  dnszone   = "tod.sncf.fr"
  name      = "temoin-vda3.tod.sncf.fr"
  type      = "CNAME"
  value     = "temoin-vda3.dok-todnp-tod01.aws.sncf.cloud"
  ttl       = 300
}
