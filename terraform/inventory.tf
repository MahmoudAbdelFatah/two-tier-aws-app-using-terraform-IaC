data "template_file" "ec2" {
  template = file("./hosts.tpl")
  vars = {
    bastion = aws_instance.Bastion_host.public_ip
    remote  = aws_instance.private_instance.tags.Name
  }
}

resource "local_file" "ansible_file" {
  content  = data.template_file.ec2.rendered
  filename = "../ansible/inventory"
}