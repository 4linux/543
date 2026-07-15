data "terraform_remote_state" "projetos" {
  backend = "local"

  config = {
    path = "../projetos/terraform.tfstate"
  }
}
