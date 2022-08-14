provider "aws" {
    region = "${var.availability_zone}" 
}



resource "aws_instance" "aws_instance_challenge" {
  
    ami  = "${var.amis["eu-west-3-ubuntu-20"]}"
    instance_type = "${var.instance_type.micro}"
    key_name = "${var.private_key.name}"  # "${var.key_name.name}"
    subnet_id = aws_subnet.public_subnet.id
    vpc_security_group_ids = [ "${aws_security_group.sg_example.id}" ]
    tags = {
        Name = "Challenge_instance"
    }
    
#    provisioner "remote-exec" {
#    	inline = [" Wait for SSH"]
#    	
#    	connection {
#    		type = "ssh"
#    		user = "ubuntu"
#    		private_key = file(${var.key_name.path})
#    		host = aws_instance.aws_instance_challenge.public_ip
#    	}
#   }
#   
#   provisioner "local-exec" {
#   	command = "ansible-playbook -i ${aws_instance.aws_instance_challenge.public_ip} -u ubuntu --# private-key ${var.key_name.path} provisioner.yml
#   }
    	
    
}

output "intance_public_ip" {
  value = aws_instance.aws_instance_challenge.public_ip
}



