resource "aws_instance" "web" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  associate_public_ip_address = true
  key_name               = var.key_name

  tags = {
    Name = "Terraform EC2"
  }

  provisioner "local-exec" {
    command = <<EOT
      echo "Current working directory: \$(pwd)"
      echo "Listing files in current directory:"
      ls -la
      echo "Changing to ansible directory..."
      cd ../ansible
      echo "Creating ansible directory and inventory file..."
      mkdir -p .
      echo "[web]" > inventory
      echo "${self.public_ip}" >> inventory
      echo "Inventory file created. Listing files in ansible directory:"
      ls -la
      echo "Sleeping for 60 seconds to allow EC2 instance to initialize..."
      sleep 30
      echo "Running Ansible playbook..."
      ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory playbook.yml --private-key ~/.ssh/id_rsa -u ec2-user
    EOT
  }
}
