# Mario server key-pair
resource "aws_key_pair" "mario-server-key" {
  key_name   = "mario-server-key"
  public_key = file("./keys/mario-server-key.pub")
}