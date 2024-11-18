provider "aws" {
  region = "eu-west-2"
}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
}

variable "instance_type" {
  description = "The type of instance to deploy"
  type        = string
  default     = "t2.micro"  # Default for other environments
}

variable "feature_flag" {
  description = "Enable experimental features"
  type        = bool
  default     = false
}

resource "aws_instance" "app" {
  ami           = "ami-0acc77abdfc7ed5a6"
  instance_type = var.instance_type

  tags = {
    Name        = "staging-app"
    FeatureFlag = var.feature_flag ? "enabled" : "disabled"
  }
}
