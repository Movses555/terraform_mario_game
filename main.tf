resource "aws_instance" "mario_game_server" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.mario-server-key.key_name
  vpc_security_group_ids = [aws_security_group.mario-server-sg.id]
  tags = {
    Name = var.server_name
  }

  provisioner "file" {
    source      = "./scripts/docker.sh"
    destination = "/tmp/docker.sh"
  }

  provisioner "file" {
    source      = "./scripts/nginx.sh"
    destination = "/tmp/nginx.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/docker.sh",
      "sudo /tmp/docker.sh"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/nginx.sh",
      "sudo /tmp/nginx.sh"
    ]
  }

  provisioner "file" {
    source      = "./configs/reverse_proxy.conf"
    destination = "/tmp/reverse_proxy.conf"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/reverse_proxy.conf /etc/nginx/conf.d/",
      "sudo nginx -t",
      "sudo systemctl restart nginx"
    ]
  }

  provisioner "file" {
    source      = "./scripts/certbot.sh"
    destination = "/tmp/certbot.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/certbot.sh",
      "sudo /tmp/certbot.sh"
    ]
  }

  # Connect to mario server
  connection {
    user        = var.user
    private_key = file(var.key_path)
    host        = self.public_ip
  }
}