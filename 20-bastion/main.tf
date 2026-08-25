resource "aws_instance" "bastion" {
  ami                    = local.ami_id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [local.bastion_sg_id]
  subnet_id = local.public_subnet_id
  # iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  user_data = file("bastion.sh")
  root_block_device {
    volume_size = 50
    volume_type = "gp3"
  }
  tags = merge(
    var.bastion_tags,
    local.common_tags,
    {
      Name = "${local.common_name}-bastion"
    }
  )
}

# resource "aws_iam_role" "ec2_admin_role" {
#   name = "ec2-admin-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#         Action = "sts:AssumeRole"
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "admin_access" {
#   role       = aws_iam_role.ec2_admin_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
# }

# resource "aws_iam_instance_profile" "ec2_profile" {
#   name = "ec2-admin-instance-profile"
#   role = aws_iam_role.ec2_admin_role.name
# }
