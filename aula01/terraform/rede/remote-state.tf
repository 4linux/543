data "terraform_remote_state" "projetos" {
  backend = "local"

  config = {
    path = "../projetos/terraform.tfstate"
  }
}

data "terraform_remote_state" "apis" {
  backend = "local"

  config = {
    path = "../apis/terraform.tfstate"
  }
}
