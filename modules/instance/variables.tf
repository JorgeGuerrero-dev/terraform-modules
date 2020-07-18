variable "ami_id"{
    default=""
    description="Ami ID"
}

variable "instance_type" {
}

variable "tagsinstance"{
    type = map
}

variable "sg_name" {
}

variable "tag_sg" {

}

variable "ingress_rules" {

}

variable "egress_rules" {

}


