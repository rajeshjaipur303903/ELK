output "elasticsearch_ip_addr" {
  value = join(":",[aws_instance.elastic_nodes[0].public_ip,"9200"])
}
output "kibana_ip_addr" {
  value = join(":",[aws_instance.kibana.public_ip,"5601"])
}