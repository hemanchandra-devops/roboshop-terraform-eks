module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = local.common_name
  kubernetes_version = "1.32"

  addons = {
    coredns                = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy             = {}
    vpc-cni                = {
      before_compute = true
    }
    metrics-server = {}
  }

  # Optional
  endpoint_public_access = false

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  vpc_id                   = local.vpc_id
  subnet_ids               = local.private_subnet_ids
  control_plane_subnet_ids = local.private_subnet_ids 
  create_security_group = false
  create_node_security_group = false
  security_group_id = local.eks_control_plane_sg_id
  node_security_group_id = local.eks_node_sg_id


  eks_managed_node_groups = {
    blue = {
      
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["m5.xlarge"]
      iam_role_additional_policies  = {
        amazonEFS = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
        amazonEBS = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
      }

      min_size     = 2
      max_size     = 10
      desired_size = 2
    }
  }

  tags = merge(
    local.common_tags,
    {
      Name = local.common_name
    }
  )
}