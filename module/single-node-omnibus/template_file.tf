data "template_file" "gitlab_application_user_data" {
  template = "${file("${path.module}/templates/gitlab_application_user_data.tpl")}"
  vars {
  }
}