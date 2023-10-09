variable "ami" {
  type    = string
  default = "ami-067d1e60475437da2"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "server_name" {
  type    = string
  default = "Mario-Server"
}

variable "user" {
  type    = string
  default = "ec2-user"
}

variable "key_path" {
  type    = string
  default = "./keys/mario-server-key"
}

variable "security_group_name" {
  type    = string
  default = "mario-server-sg"
}

variable "ip_info_url" {
  type    = string
  default = "https://ipinfo.io"
}