resource "aws_instance" "bastion" {
  ami           = local.ami_id
  instance_type = "c5.large"
  subnet_id = local.public_subnet
  vpc_security_group_ids = [local.bastion_sg_id]
  iam_instance_profile = aws_iam_instance_profile.bastion.id
  #user_data = file("${path.module}/bastion.sh")
  root_block_device {
    volume_size = 50
    volume_type = "gp3"
    tags = merge(local.common_tags,
    {
      Name = "${var.project}-${var.environment}-voulme_ebs"
    }
    )
  }
  tags = merge(local.common_tags,
    {
      Name = "${var.project}-${var.environment}-bastion"
    }
    )
}

resource "aws_iam_role" "bastion" {
  name = "${var.project}-${var.environment}-bastion-ec2-role"

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
      Name = "${var.project}-${var.environment}-bastion-role"
    }
    )
}

resource "aws_iam_role_policy_attachment" "bastion" {
  role       = aws_iam_role.bastion.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_instance_profile" "bastion" {
  name = "${var.project}-${var.environment}"
  role = aws_iam_role.bastion.name
}

resource "terraform_data" "bastion_bootstrap" {
  triggers_replace = [
    aws_instance.bastion.id
  ]

  connection {
    user = "ec2-user"
    password = "DevOps321"
    host = aws_instance.bastion.public_ip
    type = "ssh"
  }

  provisioner "file" {
    source = "${path.module}/bastion.sh"
    destination = "/tmp/bastion.sh"
  }

  provisioner "remote-exec"  {
    inline = [ 
      "chmod +x /tmp/bastion.sh",
      "sudo sh /tmp/bastion.sh"
     ]
  }
}