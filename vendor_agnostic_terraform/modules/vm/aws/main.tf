
resource "aws_instance" "this" {
  ami           = "ami-123456"
  instance_type = var.instance_type
  subnet_id     = var.vpc_id
  tags = {
    Name = var.vm_name
  }
}

output "vm_id" {
  value = aws_instance.this.id
}
