provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "elasticsearch_master" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  key_name      = "beef"

  tags = {
    Name = "master"
  }
}

resource "aws_instance" "elasticsearch_data_1" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  key_name      = "beef"

  tags = {
    Name = "data_1"
  }
}

resource "aws_instance" "elasticsearch_data_2" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  key_name      = "beef"

  tags = {
    Name = "data_2"
  }
}

resource "aws_instance" "kibana_logstash" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  key_name      = "beef"

  tags = {
    Name = "kibstash"
  }
}

