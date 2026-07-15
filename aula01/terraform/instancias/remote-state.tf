data "terraform_remote_state" "projetos" {
  backend = "local"

  config = {
    path = "../projetos/terraform.tfstate"
  }
}

data "terraform_remote_state" "rede" {
  backend = "local"

  config = {
    path = "../rede/terraform.tfstate"
  }
}
