resource "local_file" "name" {
  content  = "Hello, World!, Nithin here"
  filename = "${path.module}/hello.txt"
}