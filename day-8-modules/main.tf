module "web_instance" {
  source = "../day-2-child-module-ec2"

  key_name = "kabali_access"
  instance_type = "t2.micro"
  ami_id = "ami-01ca13db604661046"
  name = "web"
  
}

output "instance_id" {
  value = module.web_instance.instance_id
}