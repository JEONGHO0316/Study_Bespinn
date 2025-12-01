

```
terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~>2.3"
    }
  }
}

provider "local" {}

resource "local_file" "hell2o" {
  content  = " Hello tf "
  filename = "${path.module}/hello.txt"
}
```