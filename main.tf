
variable "ACCESSKEY" {
}
variable "SECRETKEY" {
}

variable "image_id" {
}

provider "aws" {
  access_key = var.ACCESSKEY
  secret_key = var.SECRETKEY
  region     = "us-west-1"
}

output "public_ip" {

  value = aws_instance.app_server.public_ip

}

resource "aws_instance" "app_server" {
  ami           = var.image_id
  instance_type = "t2.micro"
  key_name      = "id_rsa"


  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install httpd -y",
      "sudo systemctl start httpd",
      "sudo chown -R ec2-user:ec2-user /var/www/html/",
      "echo helloworld remote provisioner >> hello.txt",
    ]
  }

  provisioner "file" {
    source      = "/home/ec2-user/TERRAFORM/PRIVISIONER/a.html"
    destination = "/var/www/html/a.html"
  }
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file("/home/ec2-user/.ssh/id_rsa")
    timeout     = "4m"
  }

  tags = {
    Name = "ExampleAppServerInstance"
  }
}



resource "aws_key_pair" "deployer" {
  key_name   = "id_rsa"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDMDq6cuuUlec7cG5XhZiA/RTsEDIFVi/qpvUU7Veq2HHa4kAjae1hYLEj8165RBqXJxjUIxGnsqqkcioEobyfFyZLDGb4uhJFk85GDUok0aYOUiyMRpWgd1YjsIv+c+W89QL6bCzIl1AgaIKerBLrlWDT1Fh80eI4eJqOXsnCwqL2Gfq4Wm7CXjtiVJqC/Mb0rUwWTTapn8tlfR1vEH2hat0Nk91+XXDniLPUZLuSDyfnWYqta5U9+hBvbGbkaVVVDFxuf2OsimnkQ9zKt7i+GNwgDzEgUBGEhEY6h5Ixm6m0jwC7YcWVpY9WjtM8MSurCoyeqSkWstus5sQ3MEAD9 ec2-user@ip-172-31-7-96.us-west-1.compute.internal"
}
