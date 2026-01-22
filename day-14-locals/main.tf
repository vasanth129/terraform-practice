locals {
    common_tags = {
        common_tags = {
            environment = var.environment
            project     = var.project
        }
    }

    #naming conventions
    resource_name = "${var.project}-${var.environment}"

    # Process the subnet list
    primary_public_subnet = var.subnet_ids[0]
    subnet_count          = length(var.subnet_ids)

     # Environmental deployment settings
    is_production      = var.environment == "prod"
    monitoring_enabled = local.is_production
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = local.primary_public_subnet
  monitoring    = local.monitoring_enabled

  tags = {
    Name        = local.resource_name
    Environment = var.environment
  }
}

resource "aws_security_group" "web" {
  name = "${local.resource_name}-sg"

  tags = {
    Name = "${local.resource_name}-security-group"
  }
}

#just as an example...