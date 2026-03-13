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

/*resource "aws_ec2_instance_state" "catalogue" {
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
}*/

resource "aws_lb_target_group" "catalogue" {
  name = "${var.project}-${var.environment}-catalogue"
  port = 8080
  protocol = "HTTP"
  vpc_id = local.vpc_id
  deregistration_delay = 60

  health_check {
    enabled = true
    healthy_threshold = 2
    interval = 20
    matcher = "200-299"
    path = "/health"
    port = 80
    protocol = "HTTP"
    timeout = 30
    unhealthy_threshold = 2
  }
}

/*resource "aws_launch_template" "catalogue" {
  name = "${var.project}-${var.environment}-catalogue"
  image_id = aws_ami_from_instance.catalogue_ami.id

  instance_initiated_shutdown_behavior = "terminate"
  instance_type = "t3.micro"
  vpc_security_group_ids = [local.catalogue_sg_id]
  update_default_version = true

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

resource "aws_autoscaling_group" "catalogue" {
  name = "${var.project}-${var.environment}-catalogue"
  max_size = 10
  min_size = 1
  desired_capacity = 1
  health_check_grace_period = 120
  health_check_type = "ELB"
  force_delete = false

  launch_template {
    id = aws_launch_template.catalogue.id
    version = "$Latest"
  }

  vpc_zone_identifier = [ local.private_subnet ]
  target_group_arns = [ aws_lb_target_group.catalogue.arn ]

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = [ "launch_template" ]
  }

  # instances should be launched in given time else timeout from ASG.
  timeouts {
    delete = "15m"
  }

  dynamic "tag" {
    for_each = merge(
      {
        Name = "${var.project}-${var.environment}-catalogue"
      },
      local.common_tags
    )
    content {
      key = tag.key
      value = tag.value
      propagate_at_launch = true
    }
  }
}

resource "aws_autoscaling_policy" "catalogue" {
  autoscaling_group_name = aws_autoscaling_group.catalogue.name
  name = "${var.project}-${var.environment}-catalogue"
  policy_type = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
  
  target_value = 70.0
  }
}*/

resource "aws_alb_listener_rule" "catalogue" {
    listener_arn = local.backend_alb_arn
    priority = 10

    condition {
      host_header {
        values = [ "catalogue.backend-alb-${var.environment}.${var.domain_name}" ]
      }
    }

    action {
      type = "forward"
      target_group_arn = aws_lb_target_group.catalogue.arn
    }
}

/*resource "terraform_data" "catalogue_delete" {
  triggers_replace = [
    aws_instance.catalogue.id
  ]
  depends_on = [ aws_autoscaling_policy.catalogue ]
  provisioner "local-exec" {
    command = "aws ec2 terminate-instances --instance-ids ${aws_instance.catalogue.id} "
  }
}*/