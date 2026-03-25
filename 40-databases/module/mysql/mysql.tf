resource "aws_instance" "mysql" {
  ami           = local.ami_id
  instance_type = "t3.micro"
  subnet_id = local.database_subnet
  vpc_security_group_ids = [local.mysql_sg_id]
  iam_instance_profile = aws_iam_instance_profile.mysql.id
  tags = merge(local.common_tags,
    {
      Name = "${var.project}-${var.environment}-mysql"
    }
    )
}

resource "terraform_data" "mysql_bootstrap" {
  triggers_replace = [
    aws_instance.mysql.id
  ]

  connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = aws_instance.mysql.private_ip
  }

  provisioner "file" {
    source = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    inline = [ 
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh mysql ${var.environment} ${var.app_version}"
     ]
  }
}

resource "aws_iam_role" "mysql" {
  name = "${var.project}-${var.environment}-mysql"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = merge(local.common_tags,
    {
      Name = "${var.project}-${var.environment}-mysql-role"
    }
    )
}

resource "aws_iam_policy" "mysql" {
  name        = "${var.project}-${var.environment}-mysql-policy"
  description = "Instance policy to read only SSM parameter for mysql root password."
  policy = templatefile("mysql-policy.json",{
    environment = var.environment
  })
}

resource "aws_iam_role_policy_attachment" "mysql" {
  role       = aws_iam_role.mysql.name
  policy_arn = aws_iam_policy.mysql.arn
}

resource "aws_iam_instance_profile" "mysql" {
  name = "${var.project}-${var.environment}-mysql-instance-profile"
  role = aws_iam_role.mysql.name
}

resource "aws_route53_record" "mysql" {
  zone_id = var.zone_id
  name="mysql-${var.environment}.${var.domain_name}"
  type = "A"
  ttl = "1"
  records = [ aws_instance.mysql.private_ip ]
}