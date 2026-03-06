resource "aws_instance" "mongo" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  subnet_id = local.database_subnet
  vpc_security_group_ids = [local.mongo_sg_id]
  tags = merge(local.common_tags,
    {
      Name = "${var.project}-${var.environment}-mongo"
    }
    )
}

resource "terraform_data" "bootstrap" {
  triggers_replace = [
    aws_instance.mongo.id
  ]

  connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = aws_instance.mongo.private_ip
  }

  provisioner "file" {
    source = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    inline = [ 
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh mongo"
     ]
  }
}