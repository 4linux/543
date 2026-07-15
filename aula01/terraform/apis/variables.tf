variable "bootstrap_project_id" {
  description = "Projeto inicial/padrão usado para executar o Terraform e criar rede, IPs e instâncias."
  type        = string
}

variable "billing_account_id" {
  description = "ID da conta de faturamento da GCP."
  type        = string
}

variable "org_id" {
  description = "ID da Organization da GCP. Caso não utilize Organization, deixe vazio."
  type        = string
  default     = ""
}

variable "folder_id" {
  description = "ID da Folder da GCP. Caso não utilize Folder, deixe vazio."
  type        = string
  default     = ""
}

variable "project_prefix" {
  description = "Prefixo usado para gerar IDs únicos dos projetos."
  type        = string
  default     = "rancher543"
}

variable "region" {
  description = "Região padrão dos recursos."
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "Zona padrão das instâncias."
  type        = string
  default     = "us-central1-a"
}

variable "allowed_source_ranges" {
  description = "CIDRs autorizados a acessar os serviços do laboratório."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "ubuntu_image_family" {
  description = "Família da imagem Ubuntu usada nas instâncias."
  type        = string
  default     = "ubuntu-2204-lts"
}
