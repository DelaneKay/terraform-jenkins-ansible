locals {
  ssh_user         = "ubuntu"
  key_name         = "AWSDevOps"
  private_key_path = "~/AWSDevOps.pem"
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_iam_policy" "fullaccess_policy" {
  name        = "adminaccess"
  path        = "/"
  description = "Admin policy for Instance"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "*",
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "fullaccess-pol-attach" {
  role       = "${aws_iam_role.ec2_role.name}"
  policy_arn = "${aws_iam_policy.fullaccess_policy.arn}"
}

resource "aws_iam_role" "ec2_role" {
  name = "ec2_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }
    }
  ]
}
EOF

  tags = {
    Name = "ec2-role"
  }
}


# Create a security group
resource "aws_security_group" "terraform-ansible_webserver_sg" { 

    ingress {
        from_port = "${var.http_port}"
        to_port = "${var.http_port}"
        protocol = "tcp"
        cidr_blocks = [ "${var.my_system}"]
    }
     ingress {
        from_port = "${var.ssh_port}"
        to_port = "${var.ssh_port}"
        protocol = "tcp"
        cidr_blocks = [ "${var.my_system}"]
    }
   egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  } 

} 

variable "region" {
  default = "us-east-1"
}
variable "http_port" {
    default = 80
}
variable "ssh_port" {
    default = 22
}
variable "my_system" {
    default = "197.184.183.18/32"
}

variable "ami" {
  default = "ami-0261755bbcb8c4a84"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "az" {
  default="us-east-1a"
}

resource "aws_instance" "terraform-ansible" {
 ami = "${var.ami}" 
 instance_type = "${var.instance_type}"
 vpc_security_group_ids = ["${aws_security_group.terraform-ansible_webserver_sg.id}"]
 availability_zone = "${var.az}"
 key_name = "AWSDevOps"
 tags = {
	 Name = "Terraform-Ansible"
 }



 provisioner "remote-exec" {
    inline = ["echo 'Wait until SSH is ready'"]

    connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(local.private_key_path)
      host        = aws_instance.terraform-ansible.public_ip
    }
  }
  provisioner "local-exec" {
    command = "ansible-playbook  -i ${aws_instance.terraform-ansible.public_ip}, --private-key ${local.private_key_path} setup_ec2-playbook.yaml"
  }
}

output "terraform-ansible_ip" {
  value = aws_instance.terraform-ansible.public_ip
}


