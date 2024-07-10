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
      echo "Current working directory: $(pwd)"
      echo "Listing files in current directory:"
      ls -la
      echo "Creating ansible directory and inventory file..."
      mkdir -p ./ansible
      echo "[web]" > ./ansible/inventory
      echo "${self.public_ip}" >> ./ansible/inventory
      echo "Inventory file created. Listing files in ansible directory:"
      ls -la ./ansible
      echo "Running Ansible playbook..."
      ansible-playbook -i ./ansible/inventory ./ansible/playbook.yml --private-key ~/.ssh/id_rsa -u ec2-user
    EOT
  }
}
