resource "aws_eip" "ElisticIP-NAT" {
  vpc = true
}


resource "aws_nat_gateway" "NAT" {
  allocation_id = aws_eip.ElisticIP-NAT.id
  subnet_id     = aws_subnet.public-sub-1.id

}