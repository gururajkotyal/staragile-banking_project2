
resource "aws_instance" "test-server" {
  ami           = "ami-00c39f71452c08778" 
  instance_type = "t2.micro" 
  key_name = "UBUNTUKEY"
  vpc_security_group_ids= ["sg-09ab4eda7c57a0d8b"]
  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("./ubuntu-keypair.pem")
    host     = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [ "echo 'wait to start instance' "]
  }
  tags = {
    Name = "test-server"
  }
 provisioner "local-exec" {

        command = " echo ${aws_instance.test-server.public_ip} > inventory "
 }
 
 provisioner "local-exec" {
 command = "ansible-playbook /var/lib/jenkins/workspace/banking_project2/test-server/test-banking-playbook.yml "
  } 
}
