module "sg" {
    count = length(var.sg_names)
    source = "git::https://github.com/hemanchandra-devops/terraform-aws-sg.git"
    project = var.project
    environment = var.environment
    sg_name = var.sg_names[count.index]
    sg_description = "Created for ${var.sg_names[count.index]}"
    vpc_id = local.vpc_id
}
