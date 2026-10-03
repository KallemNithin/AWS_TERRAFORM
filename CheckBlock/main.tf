check "website_check" {
  data "http" "example" {
    url = "https://www.google.com"
  }

  assert {
    condition     = data.http.example.status_code != 200
    error_message = "The website is  reachable."
  }
}

resource "local_file" "example" {
  content  = "Website check passed."
  filename = "website_check.txt"
}