// Provider
provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

// Resource
resource "aws_instance" "aws_instance" {
  availability_zone      = "eu-north-1a"
  ami                    = "ami-08eb150f611ca277f"
  instance_type          = "t3.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.DefaultTerraformSG.id]
  count                  = 1

  // Main disk
  ebs_block_device {
    device_name           = "/dev/sda1"
    volume_size           = 15
    volume_type           = "gp3"
    delete_on_termination = true
    tags = {
      Name = "root disk"
    }
  }

  // User script
  user_data = file(var.user_data_file)

  tags = {
    Name = "DefaultTerraformInstance"
  }
}

// Security Group
resource "aws_security_group" "DefaultTerraformSG" {
  name        = "DefaultTerraformSG"
  description = "DefaultTerraformSG"

  dynamic "ingress" {
    for_each = var.ports_ingress_list

    content {
      description = "Allow ${ingress.value}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "DefaultTerraformSG"
  }
}


// Outputs
output "public_ip" {
  value = aws_instance.aws_instance.*.public_ip
}

output "private_ip" {
  value = aws_instance.aws_instance.*.private_ip
}
output "instance_id" {
  value = aws_instance.aws_instance.*.id
}

output "key_name" {
  value = aws_instance.aws_instance.*.key_name
}

output "user_data_file" {
  value = var.user_data_file
}

