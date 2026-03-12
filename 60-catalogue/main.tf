resource "aws_instance" "catalogue" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  subnet_id = local.private_subnet
  vpc_security_group_ids = [local.catalogue_sg_id]
  tags = merge(local.common_tags,
    {
      Name = "${var.project}-${var.environment}-catalogue"
    }
    )
}

resource "terraform_data" "bootstrap_catalogue" {
  triggers_replace = [
    aws_instance.catalogue.id
  ]

  connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = aws_instance.catalogue.private_ip
  }

  provisioner "file" {
    source = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    inline = [ 
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh catalogue"
     ]
  }
}

resource "aws_ec2_instance_state" "catalogue" {
  instance_id = aws_instance.catalogue.id
  state = "stopped"
  depends_on = [ terraform_data.bootstrap_catalogue ]
}

resource "aws_ami_from_instance" "catalogue_ami" {
  name = "${var.project}-${var.environment}-catalogue-ami"
  source_instance_id = aws_instance.catalogue.id
  depends_on = [ aws_ec2_instance_state.catalogue ]
  tags = merge(local.common_tags,
    {
      Name = "${var.project}-${var.environment}-catalogue"
    }
    )
}

resource "aws_lb_target_group" "catalogue" {
  name = "${var.project}-${var.environment}-catalogue"
  port = 80
  protocol = "HTTP"
  vpc_id = local.vpc_id

  health_check {
    enabled = true
    healthy_threshold = 2
    interval = 10
    matcher = "200-209"
    path = "/health"
    port = 80
    protocol = "HTTP"
    unhealthy_threshold = 2
  }
}

resource "aws_launch_template" "catalogue" {
  name = "${var.project}/${var.environment}-catalogue"
  image_id = aws_ami_from_instance.catalogue_ami.id

  instance_initiated_shutdown_behavior = "terminate"
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.catalogue_sg_id]

  tag_specifications {
    resource_type = "instance"

    tags = merge(local.common_tags,
    {
      Name = "${var.project}-${var.environment}-catalogue-instance"
    }
    )
  }

  tag_specifications {
    resource_type = "volume"

    tags = merge(local.common_tags,
    {
      Name = "${var.project}-${var.environment}-catalogue-volume"
    }
    )
  }

  tags = merge(local.common_tags,
    {
      Name = "${var.project}-${var.environment}-catalogue"
    }
    )
}