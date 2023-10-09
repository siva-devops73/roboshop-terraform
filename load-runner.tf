data "aws_ami" "ami" {
  owners = ["973714476881"]
  most_recent = true
  name_regex = "Centos-8-DevOps-Practice"
}

resource "aws_instance" "load-runner" {
  instance_type = "t3.medium"
  ami = data.aws_ami.ami.id
  vpc_security_group_ids = ["sg-09d7039fc04d628ea"]
    tags = {
       Name = "load-runner"
    }
}