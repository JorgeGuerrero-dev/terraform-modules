provider "aws" {
    region="eu-west-3"
}

resource "aws_security_group" "ssh_conection"{
  name = var.sg_name
  tags = var.tag_sg
  dynamic "ingress"{
    for_each = var.ingress_rules
    content {
        from_port   = ingress.value.from_port
        to_port     = ingress.value.to_port
        protocol    = ingress.value.protocol
        cidr_blocks = ingress.value.cidr_blocks
    }
 }

  dynamic "egress"{
    for_each = var.egress_rules
    content {
        from_port   = egress.value.from_port
        to_port     = egress.value.to_port
        protocol    = egress.value.protocol
        cidr_blocks = egress.value.cidr_blocks
    }
  }
}

resource "aws_instance" "jorge-instance"{
    ami = var.ami_id
    instance_type = var.instance_type
    tags = var.tagsinstance
    security_groups = ["${aws_security_group.ssh_conection.name}"]
    key_name = aws_key_pair.jorge-key.key_name
    provisioner "remote-exec" {
      connection {
        type = "ssh"
        user = "ubuntu"
        private_key = "${file("~/.ssh/privatekey")}"
        host = self.public_ip
      }
     inline = ["echo test > /home/ubuntu/test.txt"]
    }   
}

resource "aws_key_pair" "jorge-key" {
  key_name   = "jorge-key"
  public_key = "ssh-rsa YOUR_PUBLIC_KEY"
}

