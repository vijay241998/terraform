#VPC 

variable "vpc_cidr" {
    default = "10.0.0.0/16"
}
variable "vpc_name" {
    default = "Default vpc"
}

#PUBLIC_SUBNET_zone-1a

variable "PUBLIC_SUBNET_1A_NAME"{
    default= "PUBLIC_SUBNET_1A"
}
variable "PUBLIC_SUBNET_1a_CIDR"{
    default= "10.0.1.0/24"
}

#PUBLIC_SUBNET_zone-1b

variable "PUBLIC_SUBNET_1B_NAME"{
    default= "PUBLIC_SUBNET_1b"
}
variable "PUBLIC_SUBNET_1b_CIDR"{
    default= "10.0.2.0/24"
}

#PRIVATE_SUBNET_zone-1a

variable "PRIVATE_SUBNET_1A_NAME"{
    default= "PUBLIC_SUBNET_1A"
}
variable "PRIVATE_SUBNET_1a_CIDR"{
    default= "10.0.3.0/24"
}

#PRIVATE_SUBNET_zone-1b

variable "PRIVATE_SUBNET_1B_NAME"{
    default= "PUBLIC_SUBNET_1b"
}
variable "PRIVATE_SUBNET_1b_CIDR"{
    default= "10.0.4.0/24"
}

#Internet gateway
variable "IGW"{
    default= "Default_IGW"
}

#eip for nat
variable "nat_ip"{
    default= "nat_ip"
}

#nat gateway
variable "nat_gw"{
    default= "nat_gw"
}

#route
variable "public_route"{
    default= "public route"
}
variable "private_route"{
    default= "private route"
}

variable "public_subnet_count" {
  description = "PUBLIC_SUBNET_1A , PUBLIC_SUBNET_1B"
}

variable "private_subnet_count" {
  description = "PRIVATE_SUBNET_1A , PRIVATE_SUBNET_1B"
}




















