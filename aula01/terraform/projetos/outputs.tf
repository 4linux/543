output "project_ids" {
  description = "IDs reais dos projetos criados."
  value = {
    for key, project in google_project.course :
    key => project.project_id
  }
}

output "cluster1_project_id" {
  description = "ID real do projeto cluster1."
  value       = google_project.course["cluster1"].project_id
}

output "cluster2_project_id" {
  description = "ID real do projeto cluster2."
  value       = google_project.course["cluster2"].project_id
}
