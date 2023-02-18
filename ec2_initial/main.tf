data "template_file" "user_data" {
  template = file("../datafiles/user_data.yaml")
}

resource "aws_instance" "ec2_initial" {
  key_name      = "jumpbox_ppal_ssh"
  ami           = "ami-00eeedc4036573771"
  instance_type = "t2.micro"
  security_groups = [var.sg_name_ec2_innitial]
  iam_instance_profile = aws_iam_instance_profile.ec2-profile-admin-role.name
  provisioner "remote-exec" {
    script = "../datafiles/script.sh"
  }
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("${var.connection_ssh1}")
  }

  tags = {
    Name = "Jenkins"
    Terraform   = "true"
    Environment = "dev"
  }
}

# Generate assume role policy
 data "aws_iam_policy_document" "ec2-assume-role" {
   statement {
     actions = ["sts:AssumeRole"]

     principals {
       type        = "Service"
       identifiers = ["ec2.amazonaws.com"]
     }
   }
 }

 # Configure IAM instance profile
 resource "aws_iam_instance_profile" "ec2-profile-admin-role" {
   name = "profile_ec2_role"
   role = aws_iam_role.ec2-admin-role.name
 }
 # Configure IAM role
 resource "aws_iam_role" "ec2-admin-role" {
   name                  = "ec2_role"
   path                  = "/"
   assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "admin_policy" {
  name = "admin_policy"
  role = aws_iam_role.ec2-admin-role.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        }
    ]
}
EOF
}