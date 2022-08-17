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




  tags = {
    Name = "ExampleAppServerInstance"
  }
}
