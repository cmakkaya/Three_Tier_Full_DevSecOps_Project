output "cluster_id" {
  value = aws_eks_cluster.cumhur.id
}

output "node_group_id" {
  value = aws_eks_node_group.cumhur.id
}

output "vpc_id" {
  value = aws_vpc.cumhur_vpc.id
}

output "subnet_ids" {
  value = aws_subnet.cumhur_subnet[*].id
}

