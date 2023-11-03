# Configurações específicas do ambiente dev
include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules//"

  extra_arguments "var-file" {
    commands = ["apply", "plan", "destroy"]
    arguments = ["-var-file=main.tfvars", "-lock=false"]
  }
}