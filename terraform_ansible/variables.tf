variable "amis" {
  default = {
      "eu-west-3-ubuntu-20" = "ami-0c6ebbd55ab05f070"
  }
}
 
variable "instance_type" {
  default = {
      "micro" = "t2.micro" 
  }
}

variable "key_name" {
  default = {
      "name" = "kp_2"
  }
} 

variable "private_key" {
  default = {
    "path" = "~/Transferências/teste_1.pem"
    "name" = "teste_1"
  }
}

variable "availability_zone" {
  default = "eu-west-3"
}

/*
variable "app_name" {
  description = "The name of the App that will be launch"
}

variable "stage" {
  description = "Environment to launch"
}*/