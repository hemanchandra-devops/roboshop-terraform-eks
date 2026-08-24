variable "project" {
  default = "roboshop"
}

variable "environment" {
  default = "dev"
}

variable "sg_names" {
    default = [
        "mongodb", "redis", "mysql", "rabbitmq",
        # "catalogue", "user", "cart", "shipping", "payment", 
        # "frontend",
        "bastion", 
        "frontend_alb",
        # "backend_alb"
        "eks_control_plane",
        "eks_node"
    ]
}