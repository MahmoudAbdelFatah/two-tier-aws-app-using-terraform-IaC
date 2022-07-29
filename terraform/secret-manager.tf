resource "tls_private_key" "keypair" {
  algorithm = "RSA"
}

resource "aws_key_pair" "keypair" {
  key_name   = "test-keypair"
  public_key = tls_private_key.keypair.public_key_openssh
  tags = {
    "Name" = "test-keypair"
  }

}

#create secret manager to store the private keypair 
resource "aws_secretsmanager_secret" "sm-keypairs" {
  name                    = "sm-keypairs-1"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "sm-v" {
  secret_id     = aws_secretsmanager_secret.sm-keypairs.id
  secret_string = tls_private_key.keypair.private_key_pem

}
