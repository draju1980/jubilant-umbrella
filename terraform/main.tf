provider "aws" {
  profile = "default"
  region  = var.region
}



// Create a new VPC
resource "aws_vpc" "demo-vpc" {
  cidr_block = var.vpc_cidr_block
    
  tags = {
    Name = "demo-vpc"
  } 
}



// Create a new subnet
resource "aws_subnet" "demo-subnet" {
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = var.subnet_cidr_block

  tags = {
    Name = "demo-subnet"
  } 
}



// Create a new internet gateway
resource "aws_internet_gateway" "demo-igw" {
  vpc_id = aws_vpc.demo-vpc.id

  tags = {
    Name = "demo-internet_gateway"
  } 
}



// Create a new route table
resource "aws_route_table" "demo-rt" {
  vpc_id = aws_vpc.demo-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo-igw.id 
  }

  tags = {
    Name = "demo-route_table"
  }
}



// Associate the route table with the subnet
resource "aws_route_table_association" "demo-rt-assoc" {
  subnet_id      = aws_subnet.demo-subnet.id
  route_table_id = aws_route_table.demo-rt.id
}



// Create a new security group
resource "aws_security_group" "demo-sg" {
  name        = "demo-sg"
  vpc_id      = aws_vpc.demo-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
tags = {
    Name = "demo-security_group"
  }
}

// Generate a new key pair for SSH access to the EC2 instance
 resource "tls_private_key" "this" {
   algorithm = "ED25519"
 }

// Create a new key pair
resource "aws_key_pair" "this" {
  key_name   = "terraform-ssh-key"
  public_key = tls_private_key.this.public_key_openssh
}

// Create a new local file to store the ssh key
resource "local_sensitive_file" "this" {
  content  = tls_private_key.this.private_key_openssh
  filename = "terraform-ssh-key"
}

// Create a new EC2 instance
resource "aws_instance" "demo-nginx-node" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.demo-subnet.id
  security_groups        = [aws_security_group.demo-sg.id]
  key_name               = aws_key_pair.this.key_name
  associate_public_ip_address = true  

    user_data = <<-EOF
              #!/bin/bash
              apt-get -y update
              apt-get -y install nginx
              sudo ufw allow 'Nginx HTTP'
              echo "<html><body><h1>Hello, World!</h1></body></html>" | sudo tee /var/www/html/index.html
              service nginx start
              EOF
    tags = {
      Name = "demo_node"
  }
}
